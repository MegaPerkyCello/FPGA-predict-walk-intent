# FootDrop AFO — Walking-Intent Detection for a Wearable Orthosis

Real-time walking-intent classifier for a wearable **ankle-foot orthosis (AFO)** that
assists people with foot drop. Two body-worn sensors — tibialis anterior surface EMG and
a shank gyroscope — feed a small CNN-LSTM that predicts foot-off **~50 ms before it
happens**, so the orthosis can pre-actuate dorsiflexion and clear the toe during swing.
Detecting *intent* (rather than reacting after the foot drags) is the whole point.

The model is trained in PyTorch and deployed as fixed-point HLS on the **programmable
logic of a Red Pitaya (Zynq-7020)** — all inference on-device, no host in the loop:

```
ADC → PL preprocessing → CNN-LSTM inference → CAN torque command
```

## Repository organization

| Folder | Purpose |
|---|---|
| [`Python/`](Python/) | PyTorch **training pipeline** — dataset conditioning, leave-one-subject-out training, a hyperparameter sweep, and golden-vector export. Produces `best_model.pt` and the per-layer reference vectors the HLS side verifies against. |
| [`HLS/`](HLS/) | Vitis HLS **fixed-point implementation** of the trained network — one component per layer, each with a testbench checked against the Python goldens, synthesized to the Z7020 fabric. |

End-to-end flow: **train** (`Python/`) → **export goldens** → **quantize + implement +
synthesize** (`HLS/`) → **deploy** to the Red Pitaya. Each folder has its own README with
the technical detail.

## The model — `FootDropCNN`

A 320 ms window at 100 Hz, 2 channels (TA EMG envelope, shank gyro), ~10 k params:

```
(2, 32)
  conv1(2→16, k=5, pad=2) + ReLU + MaxPool/2   → (16, 16)
  conv2(16→32, k=3, pad=1) + ReLU + MaxPool/2  → (32, 8)
  permute → (8, 32)
  LSTM(input=32, hidden=32, 1 layer) → final hₙ → (32,)
  Linear(32→1)                                  → 1 logit   (sign = decision)
```

Trained on the public **ENABL3S** gait dataset, leave-one-subject-out:
**F1 = 0.943, precision = 0.911, recall = 0.977**.

## Results

- **Quantization** (`ap_fixed<16,6>`): **0 decision flips** vs float PyTorch across intent
  vectors; logit drift ~5×10⁻³ through the full chain.
- **Synthesis** (xc7z020, integrated top level at 12 ns, weights baked in as on-chip ROM,
  sliding window held internally, half-precision transcendentals): **14,908 LUT (~28%),
  7,096 FF (~6%), 50 DSP (~22%), 22 BRAM_18K (~7%), ≈1.65 ms** latency — fits with ample
  headroom for the preprocessing filter chain.

## Notes

- The raw ENABL3S source CSVs (`Python/Processed_data/`, `Python/Extra_data/`, ~18 GB) are
  kept on disk but out of git; the processed windowed dataset and golden vectors are
  versioned.
- Platform: Red Pitaya STEMlab 125-14 (Zynq `xc7z020-clg400-1`). Tooling: PyTorch;
  Vitis HLS 2025.1.
