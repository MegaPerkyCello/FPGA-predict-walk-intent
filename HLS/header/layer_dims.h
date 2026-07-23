#ifndef LAYER_DIMS_H
#define LAYER_DIMS_H

// Shared numeric types for the whole inference chain.
//
//   data_t = activations + weights (the thing that costs BRAM x every array)
//   acc_t  = MAC accumulator only (one register per MAC unit -- nearly free to widen)
//
// Fixed-point is the default build. USE_FIXED is defined HERE (not via a -D flag,
// which wasn't reliably reaching the Vitis compile) so that every testbench --
// which includes this header before its tolerance block -- automatically selects
// the fixed-point tolerances. To go back to float: comment out the two ap_fixed
// typedefs, uncomment the two float typedefs below, AND comment out this #define
// (so the testbenches revert to their tight float tolerances).
#ifndef USE_FIXED
#define USE_FIXED
#endif
#include <ap_fixed.h>
// <16,6> = 1 sign + 5 int + 10 frac -> range [-32,32), resolution 2^-10 ~= 1e-3.
// hls4ml's default; a starting point, not a standard -- size I empirically.
typedef ap_fixed<16, 6, AP_RND, AP_SAT> data_t;
// Wider accumulator: 8 int bits of headroom (real activations peak ~30, well
// inside +-128), 24 frac bits so ~sqrt(N) rounding over an N-term MAC stays below
// the data_t LSB. Left at the DEFAULT AP_TRN/AP_WRAP -- deliberately NOT AP_RND/
// AP_SAT: the accumulator can't overflow here, and applying saturation+rounding on
// every += rebuilds that logic on every (unrolled) tap and blocks DSP accumulation.
// Rounding + saturation happen ONCE, on the (data_t) cast of the final result.
typedef ap_fixed<32, 8> acc_t;

  // typedef float data_t; // use for floating point
  // typedef float acc_t;


// ---------------------------------------------------------------
// FootDropCNN layer dimensions.
// Chain: (2,32) -> conv1 -> (16,32) -> relu/pool -> (16,16)
//        -> conv2 -> (32,16) -> relu/pool -> (32,8)
//        -> permute -> (8,32) -> LSTM -> (32,) -> fc -> 1 logit
// ---------------------------------------------------------------

// --- conv1: Conv1d(2 -> 16, k=5, pad=2), length preserved 32 -> 32
constexpr int C1_IC      = 2;
constexpr int C1_IN_LEN  = 32;
constexpr int C1_OC      = 16;
constexpr int C1_OUT_LEN = 32;
constexpr int C1_K       = 5;
constexpr int C1_PAD     = C1_K / 2;

// --- pool1: ReLU + MaxPool1d(2), 16ch, 32 -> 16
constexpr int P1_C       = C1_OC;
constexpr int P1_IN_LEN  = C1_OUT_LEN;
constexpr int P1_OUT_LEN = P1_IN_LEN / 2;

// --- conv2: Conv1d(16 -> 32, k=3, pad=1), length preserved 16 -> 16
constexpr int C2_IC      = P1_C;
constexpr int C2_IN_LEN  = P1_OUT_LEN;
constexpr int C2_OC      = 32;
constexpr int C2_OUT_LEN = 16;
constexpr int C2_K       = 3;
constexpr int C2_PAD     = C2_K / 2;

// --- pool2: ReLU + MaxPool1d(2), 32ch, 16 -> 8
constexpr int P2_C       = C2_OC;
constexpr int P2_IN_LEN  = C2_OUT_LEN;
constexpr int P2_OUT_LEN = P2_IN_LEN / 2;

// --- LSTM: input_size = c2 = 32, hidden = 32, seq_len = 8 (post-permute)
constexpr int LSTM_T      = P2_OUT_LEN;   // 8 timesteps -- loop bound, NOT a weight dim
constexpr int LSTM_IN_DIM = P2_C;         // 32 features per timestep (== c2)
constexpr int LSTM_HIDDEN = 32;           // H

// --- fc: Linear(32 -> 1), single logit. The classification metric is sign(logit).
constexpr int FC_IN  = LSTM_HIDDEN;       // 32 (= final h_n width)
constexpr int FC_OUT = 1;

#endif // LAYER_DIMS_H
