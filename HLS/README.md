# HLS — Fixed-Point FPGA Implementation

Vitis HLS implementation of the trained `FootDropCNN` network, quantized to fixed
point and synthesized for the Red Pitaya's Zynq-7020 programmable logic. Each layer
is its own HLS component with a testbench that checks its output against the PyTorch
golden vectors exported by [`../Python`](../Python).

> Project overview and the model architecture are in the
> [repository root README](../README.md). This file covers the HLS **implementation,
> quantization, and synthesis results**.

## Components

| Folder          | Top function   | Layer                              |
|-----------------|----------------|------------------------------------|
| `conv1/`        | `conv1_1d`     | Conv1d 2→16, k=5                   |
| `Relu_Max_1/`   | `relu_max_1`   | ReLU + MaxPool/2 (fused)           |
| `conv2/`        | `conv2_1d`     | Conv1d 16→32, k=3                  |
| `Relu_Max_2/`   | `relu_max_2`   | ReLU + MaxPool/2 (fused)           |
| `LSTM/`         | `LSTM`         | LSTM, hidden 32, 8 timesteps       |
| `linear/`       | `fc`           | Linear 32→1 (the logit)            |
| `inference/`    | `inference_stream` | **Integrated top level** — the whole chain, weights baked in, sliding window inside |
| `header/`       | —              | `layer_dims.h`: shared dims + `data_t`/`acc_t` types; `footdrop_weights.h`: generated weight ROMs |

Each component holds `*.cpp` (DUT), `*_TB.cpp` (testbench), `hls_config.cfg`, and a
`*_goldens/` directory. Testbenches read the goldens by absolute path, run the DUT, and
report per-element error and structural invariants; pooling is checked bit-exact.

### The integrated top level (`inference/`)

Two functions, deliberately layered:

- **`inference(window[2][32], logit)`** — the pure chain. A function of a full window
  with no state, so it stays directly verifiable against the PyTorch goldens.
- **`inference_stream(emg, gyro, *logit)`** — the synthesis top. Holds the 32-sample
  window in a `static` array, slides it by one on every call, then calls `inference()`.

The wrapper exists so the IP boundary matches the physical system. The PL preprocessing
chain produces **one sample pair per 100 Hz tick**, not a window, so the hardware
interface is two 16-bit sample inputs, `ap_start`/`ap_done`, and the logit in an
AXI4-Lite register — no external window buffer, no address bus, no glue block.

The window has to exist *somewhere*: conv1 needs inputs `o-2 … o+2` to produce output
`o`, and the LSTM needs all 8 timesteps, so the network is a function of the entire
32-sample window and recomputes from scratch each slide (state does not persist between
slides). Putting that buffer inside the block is what buys the simple interface — it
cannot be removed, only relocated.

Control is `ap_ctrl_hs` rather than `s_axilite` on return, because the **PL** 100 Hz
strobe drives `ap_start`; an AXI-Lite return would hand start control to the PS.

#### The IP boundary (from synthesis — this is what Vivado sees)

```
ap_clk        in   1
ap_rst_n      in   1     SYNCHRONOUS, ACTIVE LOW  (forced by the AXI port)
ap_start      in   1     <- drive from the 100 Hz sample strobe
ap_done       out  1     -> interrupt source / "logit is fresh"
ap_idle       out  1     -> low means busy; use to detect overruns
ap_ready      out  1
emg_sample    in  16     ap_none: bare wires, no handshake
gyro_sample   in  16     ap_none: bare wires, no handshake
s_axi_ctrl         AXI4-Lite slave, 32-bit data, 5-bit address
```

There is **no `inputs_address0`** — the window is internal now, so no address bus, no
external buffer, no mux.

AXI-Lite register map:

| Offset | Register     | Access | Contents |
|---|---|---|---|
| `0x10` | `logit`      | R | the logit; **low 16 bits** are the `ap_fixed<16,6>` value |
| `0x14` | `logit_ctrl` | R | bit 0 = `logit_ap_vld` — set when the logit is valid |

Two things to get right when integrating:

- **Reset is active low** (`ap_rst_n`), because any AXI port forces synchronous
  active-low reset. The pre-wrapper build had active-high `ap_rst`. Wire this backwards
  and the block simply never leaves reset.
- **The logit register is 32 bits wide but the value is 16.** Sign-extend from bit 15 and
  scale by 2⁻¹⁰ to recover the real number. Only `sign(logit)` drives the decision, so
  for the classifier you just need bit 15 — but read the scaling right before logging or
  thresholding on magnitude.

`logit_ctrl` bit 0 means the PS can *poll* for a fresh result instead of taking the
`ap_done` interrupt, or use it to confirm one. Both paths are available.

Two more things differ from the per-layer components:

- **Weights are not arguments.** They are `static const` ROMs in the generated
  `header/footdrop_weights.h`, so Vitis bakes them into the bitstream instead of
  exposing 18 `ap_memory` ports that external BRAM would have to feed. Nothing loads
  weights at runtime, so nothing can load them wrongly.
- **The permute is a real step.** `relu_max_2` emits channel-major (32, 8); the LSTM
  consumes timestep-major (8, 32). This is `x.permute(0,2,1)` from `model.py`. Omitting
  it compiles and runs — it just feeds the recurrence a transposed sequence.

Its testbench checks only the logit, because that is the only observable: **sign
agreement with float PyTorch is fatal, magnitude drift (~5×10⁻³) is reported but not.**
It runs every case twice — once through the pure core with the whole window, once
through `inference_stream` fed 32 sample pairs oldest-first. Both must produce the same
logit. That second pass is what proves the shift direction: feeding the window reversed
turns the intent cases from +4.90 into −9.35, so the check fails loudly rather than
drifting.

#### Cosimulation

**C/RTL co-simulation: PASS** (xsim, Verilog). Measured RTL latency **132,474 cycles avg**
(min 132,445 / max 132,505) = **≈1.59 ms at 12 ns** — slightly better than the 137,585-cycle
synthesis estimate, which is normal since C-synthesis reports a worst case.

Cosim is run from a **separate, deliberately tiny testbench of 3 invocations**, not the
golden-vector one. Cosim compares RTL against C automatically for whatever stimulus it is
given, so it does not need the goldens — correctness versus PyTorch is settled by C-sim.
The full testbench would be 132 inferences ≈ 18M cycles of RTL simulation (hours) for no
extra confidence.

What those 3 invocations *do* prove, and nothing else can: **the `static` window survives
between invocations in hardware.** Three back-to-back calls produced three distinct and
increasing-magnitude logits, identical in C and in RTL. Had HLS reset that memory between
runs, the calls would have been independent and the C/RTL comparison would have diverged.

> ⚠ **Windows path limit.** Cosim and IP packaging generate the deepest paths in the whole
> flow (`.../.autopilot/db/ip_tmp/prj.srcs/sources_1/ip/<long_ip_name>/<long_ip_name>.xci`,
> ~210 characters on its own). Run them from a **short** working directory or they fail with
> `[Common 17-680] Path length exceeds 260-Byte maximum`. This is a tooling constraint, not
> a design problem.

`footdrop_weights.h` is generated — regenerate with `cd Python && python export_golden.py`,
never hand-edit. It is emitted from `best_model.pt` in the same run that writes the
goldens (and carries that checkpoint's sha256), so the ROM contents and the vectors the
testbenches check against cannot come from different checkpoints. That same run also
mirrors `Python/golden_vectors/` into each component's `*_goldens/` directory.

## Quantization

Datapath is `ap_fixed<16,6>` (activations + weights) with a wider `ap_fixed<32,8>` MAC
accumulator. A `USE_FIXED` switch in `header/layer_dims.h` selects fixed vs. float;
build the whole chain either way from one line. Verified against float PyTorch on real
intent windows:

- **0 decision flips** — the quantized logit sign matches float on every intent vector;
  the classification is unchanged.
- Logit drift **~5×10⁻³** through the full quantized chain (conv1 → … → linear).
- Per-layer error ≈ 1 LSB RMS; pooling contributes zero quantization error.

`<16,6>` reproduces the float model's decisions exactly, at a fraction of the area of a
float implementation.

## Synthesis results (`inference_stream` top, 12 ns clock, xc7z020-clg400-1)

Weights, the sliding window, and half-precision transcendentals included — these are the
numbers for the whole IP as it will be instantiated, not a sum of per-component reports:

| Resource | Used | Available | Utilization |
|---|---:|---:|---:|
| LUT      | 14,908 | 53,200  | ~28% |
| FF       |  7,096 | 106,400 | ~6%  |
| DSP      |     50 | 220     | ~22% |
| BRAM_18K |     22 | 280     | ~7%  |

**Latency 137,585 cycles ≈ 1.65 ms**, well inside the 10 ms inter-inference budget —
area, not latency, is the binding constraint, and the design leaves most of the fabric
free for the preprocessing filter chain.

### How it got here

| | float tanh, 12 ns | float tanh, 20 ns | **half tanh, 12 ns** |
|---|---:|---:|---:|
| Cycles   | 132,144 | 111,857 | 137,585 |
| Latency  | 1.59 ms | 2.24 ms | **1.65 ms** |
| Slack    | 0.01 ns | 0.25 ns | 0.01 ns |
| LUT      | 16,471  | 15,615  | **14,908** |
| FF       | 8,861   | 5,618   | 7,096 |
| DSP      | 76      | 76      | **50** |
| BRAM_18K | 24      | 25      | **22** |

Two counter-intuitive results worth keeping:

- **At 20 ns the cycle count went *down*.** Given a longer period HLS packs more logic
  per cycle and needs fewer of them, which is also why FF fell 37% — fewer pipeline
  registers. Latency still rose, just less than the period ratio implies.
- **Slack sits near zero at every clock target.** HLS schedules to *fill* whatever period
  it is given, so ~0 slack is the expected outcome, not evidence of a timing problem.
  Relaxing 12 → 20 ns only moved it 0.01 → 0.25 ns. **Vivado post-route timing is the
  only real arbiter.**

Replacing the float transcendentals with half precision
([`LATER_OPTIMIZATIONS.md`](LATER_OPTIMIZATIONS.md) §1) freed **26 DSP — a third of the
design's total, 12% of the device** — for the preprocessing filter chain. It did *not*
improve timing: with the float cores gone, `sigmoid`/`tanh_act` report 0.10 ns slack
while `LSTM_step` itself reports 0.01, so the critical path was never the transcendentals.
It was always an area lever, and it delivered as one.

Two more things are worth reading off these numbers, because both contradict an earlier
expectation:

- **BRAM went 5 → 24 when the weights were baked in.** The 5 in the per-layer reports
  counted only inter-layer buffers; the ~20 KB of weight ROM is the rest. Raw capacity
  says ~9 BRAM_18K would hold it, but the weights are 18 separate arrays (plus conv2's
  `ARRAY_PARTITION` splitting one of them three ways), and each ROM rounds up to whole
  blocks rather than packing together. Still under 10% — the cost of never loading a
  weight at runtime is cheap.
- **DSP did not drop below the per-component sum.** Each layer is a separate
  non-inlined RTL module, and HLS does not share multipliers across module instances,
  so sequential dataflow alone does not buy DSP reuse. 76 is the real integrated figure.

Loops are kept rolled (`pipeline_loops=0` + `PIPELINE off`) with only the innermost MAC
reductions pipelined `II=1`, so multipliers are shared rather than replicated — the main
reason the fixed-point design is small.

## Building

Each component builds in Vitis HLS 2025.1 (`vitis_hls` C-sim / synthesis) using its
`hls_config.cfg`. The config's `-I` include path and the testbench golden paths are
absolute and point at this `HLS/` tree; if the repo moves, update those prefixes.

## Further reading

- [`HANDOFF.md`](HANDOFF.md) — full design rationale (shape facts, LSTM gate order,
  fixed-point plan, resource notes).
- [`LATER_OPTIMIZATIONS.md`](LATER_OPTIMIZATIONS.md) — deferred area/latency levers
  (shared fixed-point tanh, gate fusion, partial-unroll tradeoffs).
