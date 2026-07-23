# Python — Training Pipeline

PyTorch training pipeline for the FootDrop walking-intent model. It conditions the
raw sensor CSVs, cuts labeled windows, trains the network (leave-one-subject-out),
and exports per-layer golden vectors for the HLS implementation in [`../HLS`](../HLS).
Its two products — `best_model.pt` and `golden_vectors/` — are the inputs the FPGA
side is built and verified against.

> Project overview, deployment context, and the model architecture are in the
> [repository root README](../README.md). This file covers *how the pipeline works*.

Data comes from the public **ENABL3S** lower-limb gait dataset (subjects `AB156`,
`AB185`, …): surface EMG (native 1000 Hz, 20–350 Hz band-pass + 60/180/300 Hz
notches) and IMUs (native 500 Hz, interpolated to 1000 Hz in the processed CSVs),
recorded during walking and standing.

---

## Pipeline at a glance

```
Processed_data/*.csv ─▶ extract_dataset_sliding.py ─▶ enabl3s_dataset_sliding/*.npy ─▶ train.py ─▶ best_model.pt ─▶ export_golden.py
   (raw gait CSVs)        (causal chain, decimate,        (N,2,32 tensors + labels)      (CNN+LSTM)    (weights)    (golden_vectors/ for HLS)
                           sliding-window labeling)
```

1. **`extract_dataset_sliding.py`** — conditions the two channels with a **causal,
   deployment-matched** filter chain, decimates 1000 → 100 Hz, and cuts labeled
   fixed-length windows.
2. **`dataset.py` / `model.py` / `train.py`** — load the windows, define the network,
   train with leave-one-subject-out validation, save `best_model.pt`.
3. **`sweep.py`** — joint hyperparameter sweep (envelope cutoff × model width)
   selected on panel-averaged LOSO F1.
4. **`export_golden.py`** — dumps per-layer golden input/output vectors + weights for
   HLS/RTL verification.

---

## Signal chain & sampling (deployment-matched)

The processed CSVs are 1000 Hz. We condition each channel with a **causal** filter at
that native rate, then **decimate by 10 to 100 Hz** — the rate the model runs at:

- **Causal, not zero-phase.** The device filters a live stream and cannot see future
  samples, so training uses a causal `lfilter` (Butterworth). Zero-phase `filtfilt`
  is non-causal and unrealizable on the FPGA; a `CAUSAL` flag can switch to `filtfilt`
  for offline comparison only.
- **Decimate to 100 Hz.** Both channels are band-limited well below the new 50 Hz
  Nyquist (EMG envelope ≤ 40 Hz, gyro ≤ ~25 Hz), so plain every-10th-sample decimation
  is alias-free. 100 Hz shrinks the window to 32 samples and the model ~10×.

### The two input channels
- **Channel 0 — TA EMG envelope**: full-wave rectify (`|x|`) → causal low-pass
  (default **40 Hz**, 4th-order Butterworth) of the tibialis anterior EMG. Cutoff is
  the main tuning knob (onset lag vs. ripple).
- **Channel 1 — Shank gyroscope** (`Shank_Gy`): causal low-pass (default **30 Hz**) of
  lower-leg angular velocity.

Both are z-scored to the subject's quiet-standing baseline (on the conditioned,
decimated signal) so scales are comparable across people and trials.

## The model (`model.py`)

`FootDropCNN`, a compact CNN → LSTM binary classifier (~10 k params). Full layer
shapes are in the [root README](../README.md); the training-relevant point is that the
**width knobs** are constructor arguments — spend FPGA headroom on **width, not depth**
(a 32-sample window has no deep hierarchy to exploit):

| Knob                | Meaning                                                        |
|---------------------|---------------------------------------------------------------|
| `c1, c2`            | conv filters per layer (16/32 baseline; 24/48, 32/48 wider)   |
| `lstm_hidden`       | LSTM hidden width                                             |
| `k1, k2`            | conv kernel sizes (keep **odd** so `padding=k//2` preserves length) |
| `dropout`           | LSTM-output regularization (helps cross-subject/LOSO generalization) |

## How windows are labeled (`extract_dataset_sliding.py`)

A fixed **32-sample (320 ms) window** slides with a **1-sample (10 ms) stride** at
100 Hz — exactly how inference streams on the device. Each window is labeled by its
overlap with the **intent region**, defined per gait cycle as:

```
intent_region = [ toe_off − LATE_STANCE_FRACTION × stance ,  toe_off − PRE_TOEOFF_MARGIN ]
```

i.e. the **late stance phase**, ending a small margin (50 ms) before toe-off.

- overlap ≥ `POSITIVE_OVERLAP_THRESHOLD` (0.6) → **label 1** (intent)
- overlap ≤ `NEGATIVE_OVERLAP_THRESHOLD` (0.1) → **label 0** (no intent)
- in between → discarded as ambiguous

Windows are kept only if they lie entirely within one activity mode and belong to a
physiologically plausible stride (stance 300–2000 ms). Standing windows provide clean
negatives; negatives are subsampled to at most **3:1** vs. positives. `LATE_STANCE_FRACTION`,
`PRE_TOEOFF_MARGIN_MS`, and the overlap thresholds control *how early* before toe-off
"intent" is called — earlier detection buys actuation lead time at the cost of more
false triggers.

## Training & model selection

**`train.py`** — leave-one-subject-out: holds `VAL_SUBJECT` out, trains on the rest.
`BCEWithLogitsLoss` with `pos_weight` (recall-favored — missing a step is worse than an
early fire), dropout + weight decay for cross-subject generalization. Saves the best-F1
checkpoint to `best_model.pt`.

**`sweep.py`** — joint grid over **envelope cutoff × model width**, extracting once per
cutoff (cached in `sweep_cache/`) and averaging F1 over a **panel** of held-out subjects.
Result: F1 was flat (~0.91 panel LOSO) across cutoffs 20–40 Hz and width — capacity is
not the bottleneck; cross-subject variance dominates. Chosen config, picked on causal lag
and model size:

> **40 Hz envelope · conv 16/32 · LSTM hidden 32** — top-tier F1, lowest causal lag
> (~11 ms), smallest model.

## Deployment DSP spec (what the FPGA front-end must replicate)

The model only sees in-distribution data if the device reproduces the *same* conditioning
as training. Per channel, causal and in this order:

- **EMG:** band-pass 20–350 Hz → notch 60/180/300 Hz → **rectify** (`|x|`) → causal
  low-pass **40 Hz** → decimate to 100 Hz. (Notch *before* rectify — rectification
  down-converts 60 Hz to 120 Hz and a post-rectify notch cannot remove it.)
- **Gyro:** causal low-pass **~30 Hz** → decimate to 100 Hz.

**Inference:** trailing 320 ms window (32 samples), slide 10 ms, one independent forward
pass per slide (LSTM state does **not** persist across slides). Add an
*N-consecutive-positive* debounce before firing; the ~50 ms pre-toe-off margin budgets
envelope lag + compute + stride + actuation.

## Golden vectors for HLS (`export_golden.py`)

Dumps, for a few sign-off input windows, the **per-layer input and golden output** plus
all weights, so each HLS block can be verified against a float reference:

```
golden_vectors/<layer>/                    layer ∈ {conv1, pool1, conv2, pool2, lstm, fc}
    <layer>_<case>_input.dat               input to the layer  (per case)
    <layer>_<case>_golden_output.dat       layer output        (per case)
    <layer>_weights.dat / _bias.dat        parameters (LSTM uses w_ih/w_hh/b_ih/b_hh)
    <layer>_spec.txt                       shapes, memory layout, reference math
```

Cases: `idx0`, `first_intent`, `max_range` (largest |x|), `synth`. Each layer's input is
the previous layer's output, so the HLS pipeline is checked stage by stage. These goldens
later become the fixed-point quantization reference on the HLS side.

---

## Setup & running

Python 3 with the packages in `requirements.txt` (PyTorch, NumPy, pandas, SciPy,
scikit-learn). Run from this `Python/` folder — all paths resolve relative to the scripts.

```powershell
# 1. Create + activate a virtual environment
py -3.14 -m venv footdrop_env
footdrop_env\Scripts\Activate.ps1        # Windows  (macOS/Linux: source footdrop_env/bin/activate)

# 2. Install dependencies
pip install -r requirements.txt

# 3. Build the dataset at the chosen 40 Hz envelope cutoff
python extract_dataset_sliding.py --env-cutoff 40 --out enabl3s_dataset_sliding

# 4. Train (leave-one-subject-out) → best_model.pt
python train.py

# 5. Export golden vectors for the HLS testbenches
python export_golden.py
```

Hyperparameter search instead: `python sweep.py` (see its header for options).

## Folder layout

| Path                         | What it is                                                          |
|------------------------------|--------------------------------------------------------------------|
| `extract_dataset_sliding.py` | CSV → causal/decimated windowed `.npy` dataset (config + CLI knobs) |
| `dataset.py`                 | PyTorch `Dataset` with leave-one-subject-out support               |
| `model.py`                   | `FootDropCNN` — CNN + LSTM (width knobs)                            |
| `train.py`                   | Training / validation loop → `best_model.pt`                       |
| `sweep.py`                   | Joint cutoff × width sweep, panel-averaged LOSO → `sweep_results.json` |
| `export_golden.py`           | Per-layer golden vectors + weights → `golden_vectors/`             |
| `enabl3s_dataset_sliding/`   | Built windowed dataset (`inputs`, `labels`, `subject_ids`, `meta.json`) — tracked |
| `golden_vectors/`            | Per-layer HLS reference vectors — tracked                          |
| `best_model.pt`              | Best trained weights (ported to HLS on the Red Pitaya)             |
| `Processed_data/`            | Raw gait CSVs — pipeline **input** (~9 GB, gitignored, kept on disk) |
| `Extra_data/`                | Per-subject raw signals/features/metadata (~9 GB, gitignored)      |
| `sweep_cache/`               | Per-cutoff extracted datasets (gitignored)                         |

### A note on circuit selection

`extract_dataset_sliding.py` includes an explicit per-subject list of circuit numbers
(`SUBJECT_CIRCUITS`). Some circuits are intentionally omitted — low EMG SNR, trips,
paused/mistimed mode transitions, protocol issues — with reasons documented inline. The
CSVs for excluded circuits still exist on disk; they are simply not referenced.
