# FootDrop AFO — HLS Implementation Handoff

Context for an agent picking this up cold. Covers the model, the HLS layer
implementations, the testbench pattern, and the fixed-point conversion plan.

---

## 1. Project

Wearable ankle-foot orthosis for a family member with **bilateral foot drop**
(motor neuropathies). Surface EMG + IMU detect walking intent and drive
mechanical dorsiflexion assistance *before* foot-off.

- **Platform:** Red Pitaya STEMlab 125-14 PRO — Zynq `xc7z020clg400-1`,
  53,200 LUTs, 220 DSPs, speed grade -1.
- **Tooling:** Vitis HLS 2025.1 on Windows, `flow_target=vivado`,
  output format `ip_catalog` (NOT the Vitis kernel/`.xo` flow — that's for
  XRT/Alveo and does not apply here; PYNQ wants a plain bitstream + `.hwh`).
- **Pipeline:** ADC → PL preprocessing → AXI DMA → PS inference → CAN torque cmd.
- **Actuator:** CubeMars AK70-10 KV100 over CAN (Zynq **hard-IP** CAN in the PS,
  ~0 fabric cost; needs a TJA1050/SN65HVD230 transceiver + 120Ω termination).

### Two-stage actuation (why latency budget is loose)
1. ML pre-intent fires ~50 ms before toe-off → small 2–3° "spark"
2. Classical Gy threshold (>100 deg/s within 80–100 ms) confirms → full assist
3. State machine: IDLE → INITIAL_SPARK → FULL_ASSIST / CANCEL → REFRACTORY (400 ms)

Inference budget is milliseconds, not microseconds. **Do not optimize for
latency at the cost of area.** Area is the binding constraint.

---

## 2. Model — `FootDropCNN` (canonical reference)

```
(B, 2, 32)                      320 ms window @ 100 Hz; ch0 = TA EMG envelope, ch1 = shank Gy
  conv1(2→16, k=5, pad=2) + ReLU + MaxPool/2   → (B, 16, 16)
  conv2(16→32, k=3, pad=1) + ReLU + MaxPool/2  → (B, 32, 8)
  permute(0,2,1)                                → (B, 8, 32)
  LSTM(input_size=32, hidden=32, 1 layer)       → take final h_n → (B, 32)
  Dropout(0.3) → Linear(32→1)                   → single logit
```

### ⚠ CRITICAL SHAPE FACT — this was a repeated, costly error

In the LSTM, **`8` is the sequence length (timesteps / loop bound), NOT the
input feature dimension.**

- `LSTM_T = 8` — timesteps, appears *only* as a loop trip count, never in a weight shape
- `LSTM_IN_DIM = 32` — `input_size`, equals `c2`
- `LSTM_HIDDEN = 32` — `H`

Therefore per gate: `W_* = 32×32` (in→hidden), `U_* = 32×32` (recurrent),
`b_* = 32`. Total LSTM params = **8,320**.

`W` and `U` are both square **only because `c2 == lstm_hidden`**. If `c2` widens
to 48, `W` becomes 32×48 while `U` stays 32×32. **Never conflate `IN_DIM` and
`HIDDEN`.** `layer_dims.h` chains these so widening `C2_OC` propagates correctly.

### PyTorch weight export conventions
- Gate order in `weight_ih_l0` / `weight_hh_l0` is **i, f, g, o** (rows 0:32 =
  input gate, 32:64 = forget, 64:96 = candidate, 96:128 = output). Note this is
  *not* the f,i,g,o order used in most textbook diagrams — swapping f and i
  produces a plausible-looking but wrong result.
- PyTorch has **two** bias vectors (`bias_ih_l0`, `bias_hh_l0`) for CuDNN legacy
  reasons. They are mathematically redundant at inference — **fold them**
  (`b = bias_ih + bias_hh`) at export. The HLS carries one `b_*` per gate.
- `h_0 = c_0 = 0` (PyTorch default, since `forward` doesn't pass them). The HLS
  `LSTM()` zeroes both at entry to match.

### Training
ENABL3S dataset (10 subjects), leave-one-subject-out CV, `BCEWithLogitsLoss`
with `pos_weight`, Adam lr=1e-3. Deployment model (AB185 held out):
**F1 = 0.943, P = 0.911, R = 0.977**.

---

## 3. Current HLS state

### Files (all validated, all pass C-sim against PyTorch goldens)

| File | Top function | Shape |
|---|---|---|
| `layer_dims.h` | — | `data_t` typedef + all layer constants |
| `conv1.cpp` | `conv1_1d` | (2,32) → (16,32) |
| `relu_max_1.cpp` | `relu_max_1` | (16,32) → (16,16) |
| `conv2.cpp` | `conv2_1d` | (16,16) → (32,16) |
| `relu_max_2.cpp` | `relu_max_2` | (32,16) → (32,8) |
| `lstm.cpp` | `LSTM_step`, `LSTM` | (8,32) → (32,) |
| **MISSING** | `fc` / `Linear(32→1)` | (32,) → 1 logit |

Plus `conv1_tb.cpp`, `pool1_tb.cpp`, `conv2_tb.cpp`, `pool2_tb.cpp`, `lstm_tb.cpp`.

**All six DUTs link into one binary without symbol collision** — verified.
Function names were deliberately made unique (`conv1_1d` / `conv2_1d`, not both
`conv1d`) and constants are per-layer prefixed (`C1_`, `P1_`, `C2_`, `P2_`,
`LSTM_`) precisely so the top-level integration doesn't hit redefinitions.

### `layer_dims.h` include setup in Vitis
One copy at `workspace/common/layer_dims.h`. Each component's `hls_config.cfg`
needs the include path for **both** synthesis and simulation:
```
[hls]
syn.cflags=-IC:/Users/cocol/Ruby_Proj/workspace/common
tb.cflags=-IC:/Users/cocol/Ruby_Proj/workspace/common
```
Use **forward slashes** — backslashes get eaten as escape characters by the
GCC-family front end. If the flag spelling doesn't take, set it once via the GUI
(Synthesis → CFLAGS, C Simulation → CSIMFLAGS), then read back the key that
Vitis wrote into `hls_config.cfg` and copy that spelling to the other components.
Fallback that always works: `#include "../common/layer_dims.h"` in the source.

### Established implementation decisions (don't relitigate)
- `hls_math.h` for `hls::tanh` / `hls::expf`; **sigmoid is hand-written**
  (`1/(1+exp(-x))`) — HLS has no sigmoid.
- Two-function LSTM structure: `LSTM_step` (one timestep) + `LSTM` (loop over T=8).
  Kept separate for per-function latency reports and so a single step can be
  debugged against PyTorch in isolation.
- Gates `f[]`, `i[]`, `g[]`, `o[]` are kept as **separate arrays, unfused**, so
  each can be compared against PyTorch individually during bring-up. The `i*g`
  fusion and the four-gate loop merge are mechanical optimizations to apply
  *later*, with the testbenches as regression checks.
- `UPDATE` loop is separate from `GATES` because every gate at every `j` reads
  the **entire old `h` vector**. Writing `h[j]` inside `GATES` corrupts the
  recurrence.
- Loop variables are `j`/`k`/`m` **only** — `i` would shadow the `i[]` gate array
  and compile silently.
- ReLU+pool are fused and **pool-first**: `max(relu(a),relu(b)) == relu(max(a,b))`
  since both are monotonic. Halves ReLU ops and removes a 2 KB BRAM temp buffer.
- Conv layers emit **raw convolution only**; ReLU/pool live in the `relu_max_*`
  layers.
- Prefers inline `#pragma HLS` in source over GUI directive files (version control).
- Clock 8 ns / 125 MHz, uncertainty left at default 27%.

### Synthesis status (float, unoptimized)
LSTM float synth: ~34,782 LUTs, 134 DSPs, 9 BRAM, slack −1.27 ns at 8 ns target.

**Read this correctly:** the LUT count is a *float artifact*, not a floor.
Zynq-7 has no hard FPU, so every `fadd`/`fmul`/`expf`/`tanh` is soft logic
(a float32 multiply alone is ~3 DSP48E1s). Negative slack traces to the float
accumulator dependency chain. Both should improve substantially under
`ap_fixed`. **Do not judge the area budget against the float numbers.**

### Resource budget notes
- CAN (PS hard IP) and IMU SPI (PS controller) cost ~**0 fabric LUTs**.
- FSRs are analog through the ADC — negligible PL cost.
- The real uncounted PL consumers are **AXI DMA (~2–4k LUTs)**, AXI interconnect
  glue (~1–2k), and the **preprocessing filter chain** (notch 60/180/300 Hz,
  350 Hz LPF, 25 Hz IMU filter — plausibly 3–5k LUTs plus DSPs).
- Watch **DSP as hard as LUT** — 134/220 for the float LSTM alone is 61%.
- Because the dataflow is strictly sequential (conv1 → pool1 → conv2 → pool2 →
  LSTM → fc, each consuming the previous layer's full output), the stages never
  run concurrently and HLS can **time-share** DSPs across them. Synthesize the
  chain integrated; summing per-layer reports overcounts.

### On keeping loops rolled
There is **no "roll" pragma — rolled is the default.** HLS does not unroll on
its own at top level. Risks are (a) writing `UNROLL` yourself, (b) `PIPELINE`,
which forces nested loops to unroll, (c) the global
`config_compile -pipeline_loops` auto-pipelining setting.

To pin it defensively: `#pragma HLS PIPELINE off` on `TIME` / `GATES`.

**BRAM usage is evidence FOR rolling, not against it.** Arrays map to BRAM by
default; `ARRAY_PARTITION`/`UNROLL` *reduce* BRAM by splitting arrays into
registers (trading BRAM for LUTs). Seeing BRAM with no partition pragma is the
signature of the un-parallelized design.

Quickest check: a **rolled** loop appears in the synthesis loop table with a
trip count and II. An unrolled loop *disappears* (absorbed into the parent).
Also read the DSP count — fully rolled should be a small handful of multipliers.

The `TIME` loop **cannot usefully be pipelined** regardless: `h`/`c` are
loop-carried, so iteration t+1 can't start until t finishes.

---

## 4. Testbench pattern

Every layer follows the same structure. Reuse it for `fc`.

- `load_flat(path, buf, n)` — reads n floats from whitespace-delimited text,
  errors loudly on truncation.
- `run_case(name, dir, input_file, golden_file)` — loads, reshapes, runs the
  DUT, compares elementwise, returns 0/1.
- `main()` OR-accumulates into `overall_fail` and **returns it**. Vitis C-sim
  pass/fail is exactly `main()`'s return value: **0 = pass**.
- Severity metric: `diff / tol`. 1.0 = right at the boundary, >1 = failure.
  Reports the worst location even when passing — useful for watching margin
  erode during the fixed-point sweep.

### Tolerances
| Layer | REL_TOL | ABS_TOL | Why |
|---|---|---|---|
| conv1, conv2 | 1e-3 | 1e-5 | float32 MAC-order noise |
| LSTM | 1e-3 | 1e-5 | same, compounded over 8 recurrent steps |
| pool1, pool2 | **1e-6** | **1e-7** | pooling does **no arithmetic** — compare/select only. Bit-exact in any format, including `ap_fixed`. A tight tolerance here is a free canary. |

### Invariant checks (beyond golden comparison)
Golden comparison has a blind spot: if the export script and the testbench share
a wrong layout assumption, they agree and both are wrong. Invariants don't
consult the goldens:

- **pool1/pool2 `selfcheck()`** — re-derives `max(relu(a),relu(b))` from the
  still-resident input. Cheap because pool semantics fit in 3 lines. *Not* worth
  doing for conv (you'd be writing a second conv that shares your bugs).
- **pool2 negative count** — no output may be < 0.
- **LSTM bounds check** — `|h[j]| ≤ 1` (it's `o * tanh(c)`). Passes trivially in
  float; exists for the `ap_fixed` sweep, where a saturating gate trips it and
  tells you *which gate* rather than handing you a scrambled `h`.

Useful additions when quantizing: `f`, `i`, `o` ∈ [0,1]; `g` ∈ [−1,1].

### Golden file formats
| File | Count | Layout |
|---|---|---|
| `conv1_weights.dat` | 160 | (16,2,5) `oc*10 + ic*5 + k` |
| `conv1_bias.dat` | 16 | |
| `conv1_<case>_input.dat` | 64 | (2,32) channel-major |
| `conv1_<case>_golden_output.dat` | 512 | (16,32) channel-major |
| `pool1_<case>_input.dat` | 512 | (16,32) — raw conv1 out, pre-ReLU |
| `pool1_<case>_golden_output.dat` | 256 | (16,16) |
| `conv2_weights.dat` | 1536 | (32,16,3) `oc*48 + ic*3 + k` |
| `conv2_bias.dat` | 32 | |
| `conv2_<case>_input.dat` | 256 | (16,16) channel-major |
| `conv2_<case>_golden_output.dat` | 512 | (32,16) channel-major |
| `pool2_<case>_input.dat` | 512 | (32,16) — raw conv2 out, pre-ReLU |
| `pool2_<case>_golden_output.dat` | 256 | (32,8) |
| `lstm_w_ih_<gate>.dat` | 1024 | 32×32 row-major, gate ∈ {i,f,g,o} |
| `lstm_w_hh_<gate>.dat` | 1024 | 32×32 row-major |
| `lstm_b_<gate>.dat` | 32 | **folded** `bias_ih + bias_hh` |
| `lstm_<case>_input.dat` | 256 | (8,32) timestep-major, **post-permute** |
| `lstm_<case>_golden_output.dat` | 32 | final `h` only (no `c`) |

Cases: `synth`, `idx0`, `max_range`, `first_intent`, `ab156_intent`.

Golden directories (Windows):
```
C:\Users\cocol\Ruby_Proj\conv1\conv1\conv1_goldens\
C:\Users\cocol\Ruby_Proj\workspace\Relu_Max_1\pool1_goldens\
C:\Users\cocol\Ruby_Proj\workspace\conv2\conv2_goldens\
C:\Users\cocol\Ruby_Proj\workspace\Relu_Max_2\pool2_goldens\
C:\Users\cocol\Ruby_Proj\lstm\lstm\lstm_goldens\
```

⚠ Note pool1 and pool2 both have 512-in/256-out but **different shapes**
((16,32)→(16,16) vs (32,16)→(32,8)). A transposed export passes the element
count check and fails on values.

---

## 5. Fixed-point conversion — the plan

### Notation
`ap_fixed<W, I>` = W total bits, I integer bits **including the sign bit**.
`<16,6>` = 1 sign + 5 integer + 10 fractional → range [−32, 32), resolution 2⁻¹⁰ ≈ 0.00098.

**`<16,6>` is not a standard.** It is hls4ml's default and nothing more. It works
as a starting point because 6 integer bits is generous headroom for typical
normalized NN activations. Size `I` empirically instead of trusting it.

### Sizing `I` from data
Measure `max|v|` per tensor on the **real trained checkpoint with real ENABL3S
windows**, then `I ≥ ceil(log2(max|v|)) + 1` (the +1 is the sign bit).

Reference run on *random untrained* weights (method illustration only — regenerate
on real weights):

| Tensor | max\|v\| | min I |
|---|---|---|
| input x | 4.02 | 4 |
| conv1 out | 2.61 | 3 |
| pool1 out | 2.59 | 3 |
| conv2 out | 1.64 | 2 |
| pool2 out | 1.64 | 2 |
| lstm h_n | 0.26 | 0 |
| lstm c_n | 0.58 | 1 |
| logit | 0.18 | −1 |
| all weights | < 0.32 | ≤ 0 |
| conv1 partial acc | 2.61 | 3 |
| lstm gate pre-act | 1.10 | 2 |

Getting `I` right (range/overflow) matters **more** than squeezing the last
fractional bit. Overflow is catastrophic; precision loss is graceful.

### Accumulator width — and why
Use a wider `acc_t` than `data_t`. The dominant reason is **fractional
precision, not integer range**. Integer growth in these MACs is modest (weights
are small and terms partially cancel — measured above). But every `+=` in a
64-term MAC rounds to the accumulator LSB, and 64 roundings accumulate as ~√64 =
8× LSB. At 10 fractional bits that's ~0.008 injected into a gate pre-activation
— comparable to the precision being protected. Six to eight extra fractional
bits pushes it below the output LSB.

This is nearly free: the accumulator is **one register per MAC unit**, not a
replicated array. Widening `data_t` multiplies across every BRAM; widening
`acc_t` does not.

```cpp
typedef ap_fixed<16,6, AP_RND, AP_SAT> data_t;   // activations, weights
typedef ap_fixed<32,8, AP_RND, AP_SAT> acc_t;    // MAC accumulator
```

### Quantization modes
**Always specify `AP_RND, AP_SAT` explicitly.** The `ap_fixed` defaults are
`AP_TRN` (truncate) + `AP_WRAP`:
- Truncation biases every operation toward −∞. In a recurrence that bias
  compounds across timesteps into a DC offset rather than averaging out.
- Wrapping turns an overflow into a wild wrong value; saturation clips to max —
  a graceful failure instead of a catastrophic one.

Costs a few LUTs per op. Worth it.

### Accuracy expectations (emulated, random weights — re-verify on real data)
| Config | max abs err on h |
|---|---|
| `<16,6>` | 1.8e-3 |
| `<12,6>` | 2.6e-2 |
| `<10,6>` | 1.6e-1 ← cliff |
| `<8,6>` | 2.6e-1 (broken) |

Across 500 random sequences at `<16,6>`: worst logit error 1.3e-3, **0/500
decision flips**. Usable floor looks like ~12 bits; 16 gives margin.

### Why error compounds — and where
In a feedforward stack, quantization error mostly *adds* layer to layer,
sub-linearly if errors are uncorrelated. Gentle. **The LSTM is the dangerous
part** — not because it's downstream, but because `h`/`c` feed back for 8
timesteps, so error can accumulate *within* the layer and potentially amplify.

Consequence: **do not size LSTM precision in isolation with float inputs.** Its
real input is the *quantized* output of pool2, and its own state is quantized.

**Pool layers contribute exactly zero quantization error** — comparison and
selection only, no arithmetic. Error passes through unchanged. One less variable.

### Step-by-step

1. **Parameterize.** Add `#include <ap_fixed.h>` and the two typedefs to
   `layer_dims.h`. In each conv: `acc_t acc = bias[oc];` … `outputs[oc][o] =
   (data_t)acc;`. In the LSTM gates: `acc_t acc_f = b_f[j];` …
   `f[j] = sigmoid((data_t)acc_f);`.

2. **Loosen tolerances.** Fixed-point error is ~2⁻¹⁰ ≈ 1e-3 *absolute*, so
   `ABS_TOL` → a few LSBs (~5e-3). **Keep pool tolerances tight** — they must
   stay exact, and will.

3. **conv1 first, then propagate quantized outputs.** Run conv1 C-sim. Add a few
   lines to its testbench dumping `outputs[][]` to a `.dat`. That file becomes
   pool1's input file — *quantized*, exactly what the hardware sees. Repeat down
   the chain: pool1 → conv2 → pool2 → LSTM. This dumping step is what makes it a
   real chain test rather than five independent ones.

4. **The metric is the logit, not per-layer error.** Write the `Linear(32,1)`
   head, then check whether the final logit's **sign** matches float PyTorch
   across the intent vectors. Per-layer MSE is diagnostic; sign agreement is the
   requirement. A 5% logit error that never crosses the boundary is harmless; a
   0.5% error that does is not.

5. **Only then synthesize.** Read LUT/DSP for the winning config. If it fits,
   stop. If not, drop to `<12,6>`, re-run the whole chain, watch for the first
   flip. Sweep in C-sim (seconds), synthesize only the 2–3 finalists (minutes each).

6. **Let layers have different widths.** Convs are feedforward and forgiving
   (maybe 12 bits). The LSTM wants 16 for recurrence headroom. The fc head is
   one dot product — keep it wide, it's cheap. There is no rule requiring one
   `data_t` for the whole design.

**Keep the float path working in parallel** (git branch or `#ifdef USE_FIXED`).
When a fixed-point result looks wrong the first question is always "wrong
arithmetic or wrong precision," and a one-line flip answers it immediately.

---

## 6. Next steps

**Immediate**
1. Write `fc.cpp` (`Linear(32→1)`) + testbench — the missing layer, and the one
   whose output determines the classification.
2. Re-run the range measurement on the **real trained checkpoint** with real
   ENABL3S windows to size `I` per layer.
3. Execute the fixed-point sweep above.

**Then**
4. Top-level chain function + AXI4-Lite (control) / AXI4-Stream (data, matches
   the DMA) at the outermost level only.
5. Apply deferred optimizations with the testbenches as regression checks:
   `i*g` fusion, then the four-gate loop merge (all four gates share one pair of
   `k`/`m` loops, reading `x[k]`/`h[m]` once instead of four times).
6. Cosimulation.
7. Vivado block design integration, bitstream, PYNQ deployment.

**Beyond HLS**
- Deployment filter chain — notch (60/180/300 Hz) **before rectification**
  (unrectified hum folds to DC bias through rectification), 350 Hz LPF, 25 Hz
  IMU filter. Must reproduce the ENABL3S training distribution.
- Self-labeling data collection: log ML/classical disagreements to SD card as
  fine-tuning data.
- Second device build (bilateral condition).
- Fine-tuning: freeze CNN, fine-tune LSTM + head on calibration data with
  per-session EMG normalization.

---

## 7. Open risks

1. **Label causality leakage** — windows may contain post-toe-off Gy samples,
   potentially inflating the reported F1.
2. **Domain gap** — fine-tuning frozen CNN weights from an able-bodied pretrain
   to a foot-drop patient.
3. **`input_size=8` stale snippet** — a code fragment with `nn.LSTM(input_size=8,
   ...)` hardcoded exists somewhere separate from `model.py` (which correctly
   uses `input_size=c2`). If that's a live file it would train fine and be a
   *different network* than the one validated at F1 0.943. Worth reconciling.

---

## 8. Working style

- Iterative, hands-on; explanations grounded in this project rather than toy examples.
- Has RTL/digital design background (RISC-V pipeline, forwarding, initiation
  intervals) — HLS concepts map onto that directly; no need to explain pipelining
  from first principles.
- Prefers understanding a concept deeply before moving on; asks pointed questions
  and pushes back when an explanation doesn't fit. **Take pushback seriously** —
  the `input_size` shape error above persisted for several turns because an
  incorrect premise was defended instead of the premise being re-checked. When
  the user disagrees repeatedly, verify the assumption rather than re-deriving
  from it.
- Optimization deferred until correctness is verified: float first then
  fixed-point; unfused gates first then fused — always with tests as regression
  checks.

## 9. References

- AMD **UG1399** — Design Principles, Loops, Arrays, Data Types, Interfaces
- **Khoda et al. 2023** (hls4ml RNN paper) — primary HLS-LSTM reference
- **Coser et al. 2025** — benchmark showing LSTM-alone performs poorly on
  EMG-only data; the CNN front-end is essential for tractability
- **ENABL3S** dataset (Figshare), 10 subjects
- Produced artifacts: `extract_dataset_sliding.py`, `dataset.py`, `model.py`,
  `train.py`; `footdrop_ml_pipeline.docx`, `foot_drop_research_reference.docx`,
  `footdrop_twostage_architecture.docx`
