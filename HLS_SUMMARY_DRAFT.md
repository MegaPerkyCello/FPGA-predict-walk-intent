<!-- TEMPORARY DRAFT: HLS/synthesis section for the merged README. Not the final README. -->

# FootDrop AFO — On-Device CNN-LSTM Inference (Zynq-7020)

HLS implementation of a walking-intent classifier for a wearable **ankle-foot
orthosis (AFO)** targeting bilateral foot drop. Surface EMG (tibialis anterior)
and a shank IMU are read in real time; the network predicts foot-off **before it
happens** so the orthosis can pre-actuate dorsiflexion assistance and clear the
toe during swing.

## Why the Red Pitaya / Zynq-7020

The whole inference pipeline runs **on the device**, in the programmable logic of
a Red Pitaya STEMlab 125-14 (Zynq `xc7z020-clg400-1`, Gen-1 board):

```
ADC → PL preprocessing → CNN-LSTM inference (this repo) → CAN torque command
```

Keeping inference in the PL means a self-contained, low-power wearable with a
deterministic few-millisecond response and no host PC in the loop. The Z7020 is a
small part (53k LUT / 220 DSP), so the design is built to **fit in the fabric with
headroom** for the surrounding DMA, AXI glue, and preprocessing filter chain.

## Network — `FootDropCNN`

Input is a 320 ms window at 100 Hz (2 channels: TA EMG envelope, shank gyro).

```
(2, 32)
  conv1(2→16, k=5, pad=2) + ReLU + MaxPool/2   → (16, 16)
  conv2(16→32, k=3, pad=1) + ReLU + MaxPool/2  → (32, 8)
  permute → (8, 32)
  LSTM(input=32, hidden=32, 1 layer) → final hₙ → (32,)
  Linear(32→1)                                  → 1 logit  (sign = decision)
```

A CNN front-end extracts features; a single-layer LSTM integrates them over the
8-step sequence; a linear head produces one logit whose **sign** is the
walking-intent decision. Trained on the ENABL3S dataset (10 subjects,
leave-one-subject-out): **F1 = 0.943, precision = 0.911, recall = 0.977**.

## Quantization

The datapath is fixed-point `ap_fixed<16,6>` for activations and weights, with a
wider `ap_fixed<32,8>` MAC accumulator. Verified against the float PyTorch
reference on real intent windows:

- **0 decision flips** — the quantized logit sign matches float on every intent
  vector; the classification is unchanged.
- Logit drift of only **~5×10⁻³** through the full quantized chain
  (conv1 → pool → conv2 → pool → LSTM → linear).
- Per-layer error ≈ 1 LSB RMS; pooling is bit-exact (compare/select only).

In short: `<16,6>` reproduces the float model's intent decisions exactly, at a
fraction of the area of a float implementation.

## Synthesis results (full network, xc7z020-clg400-1)

| Resource | Used | Available | Utilization |
|---|---:|---:|---:|
| LUT      | 16,000 | 53,200  | ~30% |
| FF       |  9,000 | 106,400 | ~8%  |
| DSP      |     76 | 220     | ~35% |
| BRAM_18K |      5 | 280     | ~2%  |

**Total inference latency ≈ 1.6 ms** — well inside the multi-millisecond
pre-intent budget (the ML "spark" fires ~50 ms before toe-off, so latency is not
the binding constraint; area is, and the design leaves the majority of the fabric
free for the rest of the system).

## Repo layout (HLS side)

Each layer is its own HLS component (`conv1/`, `Relu_Max_1/`, `conv2/`,
`Relu_Max_2/`, `LSTM/`, `fc/`) with a testbench that checks the fixed-point output
against exported PyTorch goldens. Shared dimensions and the `data_t`/`acc_t` types
live in `header/layer_dims.h`.

See `HANDOFF.md` for full design rationale and `LATER_OPTIMIZATIONS.md` for
deferred area/latency levers.
