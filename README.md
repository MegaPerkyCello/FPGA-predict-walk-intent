# Foot-Drop Intent Detection — CNN + LSTM

Training pipeline for a wearable **walking-intention detector**: it predicts, from two body-worn
sensor signals, the moment a person is *about to lift their foot off the ground* (the late-stance /
pre-swing phase, just before toe-off).

The model is trained here in **PyTorch**, but PyTorch is only the training environment. The end
target is a **Red Pitaya FPGA**, where the trained network is reimplemented in **HLS** for
ultra-low-latency, real-time inference on the device. Everything about the pipeline is chosen to be
**deployable in real time**: causal filtering (no peeking at future samples), a low sample rate, a
tiny window, and a small network that maps cleanly onto FPGA fabric.

The intended application is assistive: a device that must fire *before* toe-off to help people with foot drop clear their foot and
avoid tripping. Detecting *intent* — rather than reacting after the foot has already dragged — is
the whole point, so the label is defined on the window of gait that precedes toe-off.

Data comes from the public **ENABL3S** lower-limb gait dataset (able-bodied subjects `AB156`,
`AB185`, …), recorded with surface EMG (native 1000 Hz, 20–350 Hz band-pass + 60/180/300 Hz notches)
and IMUs (native 500 Hz, interpolated to 1000 Hz in the processed CSVs) during walking and standing.

---

## Pipeline at a glance

```
Processed_data/*.csv ─▶ extract_dataset_sliding.py ─▶ enabl3s_dataset_sliding/*.npy ─▶ train.py ─▶ best_model.pt ─▶ export_golden.py
   (raw gait CSVs)        (causal chain, decimate,        (N,2,32 tensors + labels)      (CNN+LSTM)    (weights)    (golden_vectors/ for HLS)
                           sliding-window labeling)
```

1. **`extract_dataset_sliding.py`** — conditions the two channels with a **causal, deployment-matched**
   filter chain, decimates 1000 → 100 Hz, and cuts labeled fixed-length windows.
2. **`dataset.py` / `model.py` / `train.py`** — load the windows, define the network, train with
   leave-one-subject-out validation, save `best_model.pt`.
3. **`sweep.py`** — joint hyperparameter sweep (envelope cutoff × model width) selected on
   panel-averaged LOSO F1.
4. **`export_golden.py`** — dumps per-layer golden input/output vectors + weights for HLS/RTL
   verification.

---

## Signal chain & sampling (deployment-matched)

The processed CSVs are 1000 Hz. We condition each channel with a **causal** filter at that native
rate, then **decimate by 10 to 100 Hz** — the rate the model actually runs at. This matters:

- **Causal, not zero-phase.** The device filters a live stream and cannot see future samples, so
  training uses a causal `lfilter` (Butterworth). Zero-phase `filtfilt` (the earlier approach) is
  non-causal and unrealizable on the FPGA — using it would create a train/deploy mismatch and hide a
  large group delay. A `CAUSAL` flag in the extractor can switch to `filtfilt` for offline comparison
  only.
- **Decimate to 100 Hz.** Both channels are band-limited well below the new 50 Hz Nyquist (EMG
  envelope ≤ 40 Hz, gyro ≤ ~25 Hz), so plain every-10th-sample decimation is alias-free. Running at
  100 Hz (not 1000) shrinks the window to 32 samples and the model ~10×, which is the whole reason
  it fits comfortably on the FPGA.

## The two input channels

Single-leg sensing, matching what the real device sees:

- **Channel 0 — TA EMG envelope**: full-wave rectify (`|x|`) → **causal** low-pass (default **40 Hz**,
  4th-order Butterworth) of the tibialis anterior EMG (the muscle that dorsiflexes / lifts the foot).
  The rectification creates the low-frequency activation envelope; the low-pass extracts it. Cutoff
  is the main tuning knob (see the sweep) — it trades onset lag (lower = smoother but more causal
  delay) against ripple.
- **Channel 1 — Shank gyroscope** (`Shank_Gy`): causal low-pass (default **30 Hz**) of the lower-leg
  angular velocity, to match its ~25 Hz information bandwidth and the deployment IMU bandlimit.

Both are z-scored to the subject's quiet-standing baseline (computed on the conditioned, decimated
signal) so the model sees comparable scales across people and trials.

## The model (`model.py`)

`FootDropCNN`, a compact CNN → LSTM binary classifier (~10 k params):

| Stage        | Detail                                                                    |
|--------------|---------------------------------------------------------------------------|
| Input        | `(batch, 2, 32)` — 2 channels × 32 samples (320 ms @ 100 Hz)               |
| Conv block 1 | Conv1d 2→16, kernel 5, pad 2 → ReLU → MaxPool/2  → `(16, 16)`              |
| Conv block 2 | Conv1d 16→32, kernel 3, pad 1 → ReLU → MaxPool/2 → `(32, 8)`              |
| Recurrent    | LSTM, hidden 32, over 8 timesteps (uses final hidden state)               |
| Output head  | Dropout → Linear 32→1 → single logit (intent vs. no-intent)               |

Odd kernels with `padding = k//2` preserve length exactly, giving clean `32 → 16 → 8` pooling. Width
knobs (`c1, c2, lstm_hidden, dropout`) are constructor arguments — spend FPGA headroom on **width, not
depth**; a 32-sample window has no deep hierarchy to exploit.

## How windows are labeled (`extract_dataset_sliding.py`)

A fixed **32-sample (320 ms) window** slides across each recording with a **1-sample (10 ms) stride**
at 100 Hz — exactly how inference streams on the device.

Each window is labeled by how much it overlaps the **intent region**, defined per gait cycle as:

```
intent_region = [ toe_off − LATE_STANCE_FRACTION × stance ,  toe_off − PRE_TOEOFF_MARGIN ]
```

i.e. the **late stance phase**, ending a small margin (50 ms) before toe-off.

- overlap ≥ `POSITIVE_OVERLAP_THRESHOLD` (0.6) → **label 1** (intent)
- overlap ≤ `NEGATIVE_OVERLAP_THRESHOLD` (0.1) → **label 0** (no intent)
- in between → **discarded** as ambiguous (`DISCARD_AMBIGUOUS = False` keeps them with a hard 0.5 cutoff)

Windows are kept only if they lie entirely within one activity mode (all walking or all standing) and
belong to a physiologically plausible stride (stance 300–2000 ms). Standing windows provide clean
negatives. Negatives are subsampled to at most **3:1** vs. positives. (Gait events / the intent mask
are computed at the native 1000 Hz — where 1 sample = 1 ms — then decimated with the signals.)

**Key labeling knobs** — `LATE_STANCE_FRACTION`, `PRE_TOEOFF_MARGIN_MS`, the overlap thresholds —
control *how early* before toe-off you call "intent": earlier detection buys lead time to actuate at
the cost of more false triggers.

### CLI knobs (for sweeps)

```bash
python extract_dataset_sliding.py --env-cutoff 40 --gyro-cutoff 30 --out enabl3s_dataset_sliding
```

`--env-cutoff` (envelope low-pass, Hz) is the main sweep parameter; `--out` lets each sweep point write
to its own directory. Cutoffs must be < 50 Hz (Nyquist at 100 Hz).

### Outputs (written to the `--out` directory)

| File               | Shape / type          | Contents                                            |
|--------------------|-----------------------|-----------------------------------------------------|
| `inputs.npy`       | `(N, 2, 32)` float32  | ch0 = TA envelope (causal), ch1 = Shank Gy (causal) |
| `labels.npy`       | `(N,)` int8           | 1 = intent, 0 = no intent                           |
| `subject_ids.npy`  | `(N,)` str            | subject ID per window (for leave-one-subject-out)   |
| `meta.json`        | JSON                  | full config (rates, cutoffs, causal flag) + counts  |

## Training & model selection

**`train.py`** — leave-one-subject-out: holds `VAL_SUBJECT` out for validation, trains on the rest.
`BCEWithLogitsLoss` with `pos_weight` (recall-favored — for an assistive trigger, missing a step is
worse than an early fire), plus dropout and weight decay for cross-subject generalization. Tracks
F1/precision/recall and saves the best-F1 checkpoint to `best_model.pt`. Model width and regularization
are config constants at the top of the file.

**`sweep.py`** — joint grid over **envelope cutoff × model width**, extracting once per cutoff (cached
in `sweep_cache/`) and averaging F1 over a **panel** of held-out subjects spanning difficulty (not a
single subject, which would overfit the choice). Writes `sweep_results.json`.

**Result of the sweep:** F1 was flat (~0.91 panel LOSO) across cutoffs 20–40 Hz and across width —
capacity is not the bottleneck; cross-subject variance dominates. The chosen config is therefore
picked on **causal lag and model size**, not a noisy F1 delta:

> **40 Hz envelope · conv 16/32 (`base`) · LSTM hidden 32** — top-tier F1, lowest causal lag (~11 ms),
> smallest model.

## Deployment DSP spec (what the FPGA front-end must replicate)

The model only sees in-distribution data if the device reproduces the *same* conditioning as training.
Per channel, causal and in this order:

- **EMG:** band-pass 20–350 Hz → notch 60/180/300 Hz → **rectify** (full-wave `|x|`) → causal
  low-pass **40 Hz** (envelope) → decimate to 100 Hz.
  (The ENABL3S CSVs are already band-passed + notched; a real front-end must do it. Notch *before*
  rectify — rectification down-converts 60 Hz to 120 Hz and a post-rectify notch cannot remove it.)
- **Gyro:** causal low-pass **~30 Hz** → decimate to 100 Hz.

**Inference:** trailing 320 ms window (32 samples), slide 10 ms (1 sample), one independent forward
pass per slide (the LSTM state does **not** persist across slides — it resets and unrolls over the 8
in-window timesteps). Add an *N-consecutive-positive* debounce before firing; the ~50 ms pre-toe-off
margin is the budget for envelope lag + compute + stride + actuation.

## Golden vectors for HLS (`export_golden.py`)

Dumps, for a few sign-off input windows, the **per-layer input and golden output** plus all weights,
so each HLS block can be verified against a float reference:

```
golden_vectors/<layer>/                    layer ∈ {conv1, pool1, conv2, pool2, lstm, fc}
    <layer>_<case>_input.dat               input to the layer  (per case)
    <layer>_<case>_golden_output.dat       layer output        (per case)
    <layer>_weights.dat / _bias.dat        parameters (convs, fc; LSTM uses w_ih/w_hh/b_ih/b_hh)
    <layer>_spec.txt                       shapes, memory layout, reference math
```

Cases: `idx0`, `first_intent`, `max_range` (largest |x| — accumulator stress), `synth`. Each layer's
input is the previous layer's output, so the HLS pipeline can be checked stage by stage. Compare in
float with a ~1e-3 tolerance (not bit-exact — MAC ordering differs); the same goldens later become the
fixed-point quantization reference. `<layer>_spec.txt` documents the LSTM gate order and recurrence in
full (it's the trickiest block to port).

---

## Setup & running

Requires Python 3 with the packages in `requirements.txt` (PyTorch, NumPy, pandas, SciPy,
scikit-learn).

```bash
# 1. Create + activate a virtual environment
python -m venv footdrop_env
footdrop_env\Scripts\activate          # Windows  (macOS/Linux: source footdrop_env/bin/activate)

# 2. Install dependencies
pip install -r requirements.txt

# 3. Build the dataset at the chosen 40 Hz envelope cutoff
python extract_dataset_sliding.py --env-cutoff 40 --out enabl3s_dataset_sliding

# 4. Train (leave-one-subject-out) → best_model.pt
python train.py

# 5. Export golden vectors for the HLS testbench
python export_golden.py
```

To re-run the hyperparameter search instead: `python sweep.py` (see its header for options).
All paths resolve **relative to the script location**, so the repo runs unchanged wherever it is cloned.

---

## Repository layout

| Path                         | What it is                                                          |
|------------------------------|--------------------------------------------------------------------|
| `extract_dataset_sliding.py` | CSV → causal/decimated windowed `.npy` dataset (config + CLI knobs) |
| `dataset.py`                 | PyTorch `Dataset` with leave-one-subject-out support               |
| `model.py`                   | `FootDropCNN` — CNN + LSTM (width knobs)                            |
| `train.py`                   | Training / validation loop → `best_model.pt`                       |
| `sweep.py`                   | Joint cutoff × width sweep, panel-averaged LOSO → `sweep_results.json` |
| `export_golden.py`           | Per-layer golden vectors + weights → `golden_vectors/`             |
| `enabl3s_dataset_sliding/`   | Built dataset (`inputs`, `labels`, `subject_ids`, `meta.json`)     |
| `golden_vectors/`            | Per-layer HLS/RTL reference vectors                                |
| `sweep_cache/`               | Per-cutoff extracted datasets (gitignored)                         |
| `Processed_data/`            | Input processed gait CSVs (`ProcessedN/ABxxx_Circuit_YYY_post.csv`)|
| `Extra_data/`                | Per-subject raw signals, features, MVC, metadata (EMG SNR, notes)  |
| `best_model.pt`              | Best trained weights (ported to HLS on the Red Pitaya)             |
| `requirements.txt`           | Python dependencies                                                |

### A note on circuit selection

`extract_dataset_sliding.py` includes an explicit per-subject list of circuit numbers
(`SUBJECT_CIRCUITS`). Some circuits are intentionally omitted — low EMG SNR, trips, paused or
mistimed mode transitions, protocol issues. The reasons are documented inline next to the lists. The
CSVs for excluded circuits still exist on disk; they are simply not referenced.
