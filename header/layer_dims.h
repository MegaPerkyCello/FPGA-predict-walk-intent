#ifndef LAYER_DIMS_H
#define LAYER_DIMS_H

// Shared numeric type for the whole inference chain.
// Swap this one line for ap_fixed<W,I,AP_RND,AP_SAT> during the precision sweep.
typedef float data_t;

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

#endif // LAYER_DIMS_H
