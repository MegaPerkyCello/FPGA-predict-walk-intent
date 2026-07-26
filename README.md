# FootDrop AFO — Walking-Intent Detection for a Wearable Orthosis

> ### 👉 For Ruby — next step
>
> Flash the Vivado bitstream to the FPGA, load it with a **PYNQ overlay** the way it's
> taught in [FPGA Notes for Scientists](https://github.com/dspsandbox/FPGA-Notes-for-Scientists),
> then **do a golden-vector check**.
>
> 1. Build the bitstream — [`Vivado/README.md`](Vivado/README.md). In the Vivado Tcl Console:
>    `cd C:/Users/cocol/Ruby_Proj/workspace` then `source Vivado/create_project.tcl`,
>    then `source Vivado/build_bitstream.tcl`. Produces `footdrop.bit` + `footdrop.hwh`.
> 2. Copy that **pair** (identical basenames, same folder) to the Red Pitaya and
>    `Overlay("footdrop.bit")`.
> 3. **Golden-vector check** — this is the point of the whole bring-up design. Feed one of
>    the sign-off windows from `Python/golden_vectors/inference_goldens/` in one sample
>    pair at a time (oldest first, 32 of them) and confirm the logit comes back matching.
>    For `idx0`, PyTorch says **+4.898** and the hardware should agree in sign and to
>    within ~1.5×10⁻².
>
> | Address | What |
> |---|---|
> | `0x4001_0000` | write packed `{gyro[31:16], emg[15:0]}` |
> | `0x4001_0008` | pulse bit 0 = `ap_start` — **exactly once per sample** |
> | `0x4000_0014` | poll bit 0 = logit valid |
> | `0x4000_0010` | read logit — low 16 bits, sign-extend, × 2⁻¹⁰ |
>
> Samples must be scaled as `ap_fixed<16,6>` (integer = value × 2¹⁰) and the goldens are
> already z-scored. If the sign matches on all four vectors, the silicon reproduces
> PyTorch and the model is verified end to end.

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
| [`Python/`](Python/) | PyTorch **training pipeline** — dataset conditioning, leave-one-subject-out training, a hyperparameter sweep, and golden-vector export. Produces `best_model.pt`, the per-layer reference vectors the HLS side verifies against, and the generated weight-ROM header the FPGA compiles in. |
| [`HLS/`](HLS/) | Vitis HLS **fixed-point implementation** of the trained network — one component per layer, each with a testbench checked against the Python goldens, plus the integrated `inference/` top level that becomes the packaged IP. |
| [`Vivado/`](Vivado/) | **Block design and bitstream.** Tcl scripts that build the Vivado project (Zynq PS + the inference IP + AXI), run implementation, and emit the `.bit` / `.hwh` overlay pair for PYNQ. The scripts are the source of truth; the project directory is a disposable build artifact. |

End-to-end flow: **train** (`Python/`) → **export goldens + weight header** → **quantize,
synthesize, cosimulate, package** (`HLS/`) → **block design, implement, bitstream**
(`Vivado/`) → **deploy** to the Red Pitaya. Each folder has its own README with the
technical detail.

Verification is staged, and every stage is checked against the one before it: PyTorch
goldens → HLS C-simulation → C/RTL cosimulation → post-route timing → and finally the
golden-vector check on real silicon described at the top of this file. The metric
throughout is **the sign of the logit**, not per-layer error — a magnitude drift that
never crosses zero changes no decision.

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
- **Implementation** (Vivado post-route on xc7z020, the whole system — inference IP with
  weights as on-chip ROM, sliding window, AXI plumbing and PS7): **5,707 LUT (11%),
  4,683 FF (4%), 49 DSP (22%), 11 BRAM tiles (8%)**, all timing constraints met with
  **+10.1 ns slack** at 50 MHz. Inference completes in ~2.75 ms against a 10 ms budget.
  The fabric is ~90% free for the preprocessing filter chain.

## Notes

- The raw ENABL3S source CSVs (`Python/Processed_data/`, `Python/Extra_data/`, ~18 GB) are
  kept on disk but out of git; the processed windowed dataset and golden vectors are
  versioned.
- Platform: Red Pitaya **STEMlab 125-14 Pro**, Zynq `xc7z020-clg400-1`. The board file
  matters: Vivado ships only the base `redpitaya-125-14`, which targets a **7010** and
  silently retargets the design — the correct z20 board file is vendored in
  [`Vivado/board_files/`](Vivado/board_files/).
- Tooling: PyTorch; Vitis HLS 2025.1; Vivado 2025.1. The board runs a **PYNQ image** from
  [FPGA Notes for Scientists](https://github.com/dspsandbox/FPGA-Notes-for-Scientists),
  not the stock Red Pitaya OS.
- **What is not built yet:** the PL preprocessing chain. The current bitstream is a
  bring-up design where the PS injects samples over AXI GPIO, which is exactly what makes
  the golden-vector check possible. Replacing that stimulus with the real front end — ADC,
  filters, z-scoring — is the next hardware milestone; see the end of
  [`Vivado/README.md`](Vivado/README.md).
