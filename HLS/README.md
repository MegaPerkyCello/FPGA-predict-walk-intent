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
| `header/`       | —              | `layer_dims.h`: shared dims + `data_t`/`acc_t` types |

Each component holds `*.cpp` (DUT), `*_TB.cpp` (testbench), `hls_config.cfg`, and a
`*_goldens/` directory. Testbenches read the goldens by absolute path, run the DUT, and
report per-element error and structural invariants; pooling is checked bit-exact.

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

## Synthesis results (full network, xc7z020-clg400-1)

| Resource | Used | Available | Utilization |
|---|---:|---:|---:|
| LUT      | 16,000 | 53,200  | ~30% |
| FF       |  9,000 | 106,400 | ~8%  |
| DSP      |     76 | 220     | ~35% |
| BRAM_18K |      5 | 280     | ~2%  |

**Total inference latency ≈ 1.6 ms**, well inside the multi-millisecond pre-intent
budget — area, not latency, is the binding constraint, and the design leaves most of the
fabric free for the DMA, AXI glue, and preprocessing filter chain.

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
