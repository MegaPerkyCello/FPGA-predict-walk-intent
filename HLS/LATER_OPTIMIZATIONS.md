# Later Optimizations

Deferred optimizations for the FootDrop HLS chain. Correctness is verified and the
design **fits comfortably** (LSTM ~57 DSP / 220, ~3 ms vs a 10 ms per-inference
budget), so none of these are needed *now*. They're recorded so the tradeoffs are
captured while fresh. Apply them only against a specific pressure (area got tight,
latency budget shrank), and always with the testbenches as regression checks.

Current baseline (fixed-point `<16,6>`, all loops rolled, `pipeline_loops=0`):
- conv1/conv2/fc: ~1 shared multiplier each.
- LSTM: **57 DSP**, ~3 ms latency. Dominated by float `tanh`/`sigmoid` cores.

---

## 1. Share one tanh core + move activations to fixed-point  *(area lever)*

**What.** Today `tanh_act` synthesizes as Vitis's **float** tanh (~45 DSP, with a
**double**-precision `exp` buried inside) and `sigmoid` as a separate float `expf`
(~9 DSP). Two changes collapse this:

1. Compute tanh in fixed point: `hls::tanh(x)` on the `ap_fixed` value (CORDIC/LUT,
   a handful of DSP) instead of `hls::tanh((float)x)`.
2. Derive sigmoid from that same tanh via the **exact identity**
   `sigmoid(x) = 0.5 + 0.5*tanh(0.5*x)` — verified to 2.2e-16 (double machine eps),
   so it is algebraically exact, not an approximation. `0.5*` is a 1-bit shift and
   `+0.5` is exact in `ap_fixed` (2^-1 is representable), so the identity adds no
   rounding. This lets **one** tanh core serve all four gates (three sigmoids + the
   `g` tanh) plus the `h` update.

**Expected impact.** LSTM transcendental DSP from ~54 down to a handful; kills the
double-`exp` core entirely. Frees DSP for the DMA + preprocessing filter chain.

**The one real loss.** Not from the identity — from replacing an essentially-exact
float tanh (then quantized) with a fixed-point tanh (accurate to ~1 output LSB).
The gap is ~1 LSB, but it is nonzero.

**Validation required.** `hls::tanh` on `ap_fixed` is the exact overload that's
ambiguous under local g++, so this **cannot be validated in the local g++ harness** —
it needs a Vitis **C-sim + synthesis** to confirm (a) no fc logit sign flips across
the intent vectors, (b) the actual DSP drop. Guard the local path:
```cpp
static inline data_t tanh_act(data_t x) {
#ifdef LOCAL_GXX_SIM
    return (data_t)std::tanh((float)x);   // local sim only
#else
    return hls::tanh(x);                   // Vitis csim AND synth: fixed-point
#endif
}
static inline data_t sigmoid(data_t x) {
    return (data_t)0.5 + (data_t)0.5 * tanh_act((data_t)0.5 * x);
}
```
(Local g++ builds add `-DLOCAL_GXX_SIM`; Vitis defines neither, so csim and synth
stay consistent with each other — the property that actually matters.)

---

## 2. Reduce LSTM latency without the DSP blowup  *(latency lever, only if needed)*

The 300-DSP trap comes from **pipelining an *outer* loop**, which forces the tool to
*fully unroll* the inner 64-tap MAC into 64 multipliers. The knobs below decouple the
two: **unroll factor is the DSP dial; pipeline II is the latency dial.** Keep them
separate.

> **Note:** the cheapest lever — pipelining the *innermost* MAC reduction loop
> (`#pragma HLS PIPELINE II=1`), which overlaps taps through one multiplier with **no**
> DSP increase and needs no array partitioning — is **already applied** to the LSTM
> `k`/`m` reduction loops and to conv2's inner `k` loop. What remains below are the
> *further* levers, only if that isn't enough.

Ordered cheapest-DSP first:

1. **Partial unroll of the reduction: `#pragma HLS UNROLL factor=4` + matching
   `#pragma HLS ARRAY_PARTITION` (cyclic, factor 4) on W/U/x/h.** Gives *4* multipliers
   per MAC (not 64), ~4x throughput. Pick factor 2/4/8 to trade DSP for latency in
   controlled steps. (This is the strategy where partitioning IS required — the taps
   run in parallel, so a single BRAM can't feed them.)

2. **Flatten `ic`+`k` (conv) into one reduction before pipelining.** Pipelining a
   trip-3 inner loop pays fill/drain overhead on every enclosing iteration; a single
   flattened trip-48 pipelined loop amortizes that. Only worth it if conv latency
   matters — it doesn't today.

3. **Activation cores are already II=1 internally.** With the reductions pipelined
   they're no longer the bottleneck; sharing them (§1 of this doc) cuts their count.

**What stays serial no matter what:** the `TIME` loop (8 steps). `h`/`c` are
loop-carried, so step t+1 cannot begin until t finishes — inherent to the recurrence,
not a tuning choice. The parallelism lives *within* a step (the 32 units / 4 gates).

Rule of thumb: start with #1 (free DSP-wise). If still short, add #2 at factor 2, then
4. Re-check DSP after each — never jump straight to pipelining `GATES`.

---

## 3. Gate fusion + four-gate loop merge  *(from the handoff; mechanical)*

- **`i*g` fusion** and the **four-gate loop merge** (all four gates share one pair of
  `k`/`m` loops, reading `x[k]`/`h[m]` once instead of four times). Reduces redundant
  memory reads and control. Mechanical rewrites — apply with the LSTM testbench as the
  regression check. Deferred originally to keep the gates individually comparable to
  PyTorch during bring-up; that's done, so these are safe to take whenever convenient.

---

## Not worth touching
- **Pool layers** (relu_max_1/2): comparison + select only, already minimal.
- **conv1/conv2/fc**: one shared multiplier each after rolling. Fine.
