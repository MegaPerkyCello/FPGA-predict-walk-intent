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


## 0. I still need to implement 60, 180, 300, 420 Hz notch filters then rectify the signal.

## 1. ~~Share one tanh core + move activations to fixed-point~~ — **DONE (2026-07-25), but NOT as written below**

> **APPLIED, with a correction. Read this box before the original text, which is wrong
> in its central claim.**
>
> The sigmoid identity was right and is in use. The *fixed-point tanh* was not: the
> `hls::tanh(ap_fixed)` overload this section recommends is **unusable in Vitis 2025.1**.
> Measured, not assumed:
>
> 1. **`hls::tanh(x)` on `data_t` does not compile — inside Vitis, not just under local
>    g++.** The text below blames the local harness; that is incorrect. The real cause is
>    that the CORDIC overload is declared `template<int W,int I> ap_fixed<W,I>
>    tanh(ap_fixed<W,I>)`, which only deduces against the DEFAULT `AP_TRN/AP_WRAP` modes.
>    `data_t` carries `AP_RND/AP_SAT`, so deduction fails, that overload silently leaves
>    the candidate set, and the `double`/`float`/`half`/integer overloads are all reachable
>    by conversion → *"call to 'tanh' is ambiguous"*.
> 2. Routing through a plain-mode alias reaches the CORDIC, which then shows **two library
>    defects**: it returns **`tanh(|x|)`** — the wrong sign for every negative input
>    (`tanh(-1.0)` → `+0.760742`) — and it **faults with an integer divide-by-zero** around
>    `x ≈ +11.8`, in the positive range, which no sign correction would avoid. That fault
>    was the cause of the otherwise unexplained C-sim crash of the full chain.
>
> **What is actually implemented: `hls::tanh(x.to_half())`.** Half precision has an
> unambiguous overload and an 11-bit significand against `data_t`'s 10 fractional bits,
> and it is *not* the float path, so the double-precision `exp` core is gone. Verified by
> an exhaustive sweep of all 65,536 representable `ap_fixed<16,6>` values: worst error
> **1.30e-3** (~1.33 LSB) vs float's 9.77e-4, zero values outside 2e-3, no faults.
> Use `x.to_half()` and not `(half)x` — the cast is legal but warns on every conversion,
> and this runs ~1,280 times per inference.
>
> **Measured result** (`inference_stream` top, 12 ns, vs the float baseline):
>
> | | float tanh + expf | half tanh + identity |
> |---|---:|---:|
> | DSP | 76 (35%) | **50 (22%)** |
> | LUT | 16,471 | **14,908** |
> | FF | 8,861 | **7,096** |
> | BRAM_18K | 24 | **22** |
> | Cycles | 132,144 | 137,585 |
> | Latency | 1.59 ms | 1.65 ms |
> | Slack | 0.01 ns | 0.01 ns |
>
> **26 DSP freed (a third of the design's total, 12% of the device)** for the preprocessing
> filter chain — this was always an area lever and it delivered.
>
> **But it did NOT improve timing, and the reasoning that predicted it would was wrong.**
> Slack is 0.01 ns before *and* after. With the float cores gone, `sigmoid`/`tanh_act` now
> report 0.10 ns slack while `LSTM_step` itself reports 0.01 — the critical path was never
> the transcendentals, it is in `LSTM_step`'s own logic (the gate accumulation / state
> update). More fundamentally: **HLS schedules to fill whatever clock period it is given**,
> packing operations per cycle until slack approaches zero, so a near-zero slack is the
> expected outcome at *any* target and is weak evidence about real timing. That also
> explains the 20 ns experiment, where slack only reached 0.25 ns. **Vivado post-route
> timing is the only arbiter.**

### Original text (retained for context — see the correction above)

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
