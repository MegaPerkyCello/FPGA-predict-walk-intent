#include <hls_math.h>   // hls::tanh, hls::expf
#include "layer_dims.h"

// Transcendentals are evaluated in float on a quantized (data_t) argument, then
// re-quantized on return. Two reasons: (1) hls::tanh/expf on an ap_fixed argument
// is an ambiguous overload -- the operand converts equally well to float/double/
// int -- so the cast picks the float core explicitly; (2) this reproduces exactly
// what the validated float reference already did (float tanh/exp), so the goldens
// stay meaningful. The datapath (MACs, state) is what carries fixed-point.
static inline data_t sigmoid(data_t x) {
    float xf = (float)x;
    return (data_t)(1.0f / (1.0f + hls::expf(-xf)));
}

static inline data_t tanh_act(data_t x) {
    return (data_t)hls::tanh((float)x);
}

void LSTM_step(
    const data_t W_f[LSTM_HIDDEN][LSTM_IN_DIM], const data_t U_f[LSTM_HIDDEN][LSTM_HIDDEN], const data_t b_f[LSTM_HIDDEN],
    const data_t W_i[LSTM_HIDDEN][LSTM_IN_DIM], const data_t U_i[LSTM_HIDDEN][LSTM_HIDDEN], const data_t b_i[LSTM_HIDDEN],
    const data_t W_g[LSTM_HIDDEN][LSTM_IN_DIM], const data_t U_g[LSTM_HIDDEN][LSTM_HIDDEN], const data_t b_g[LSTM_HIDDEN],
    const data_t W_o[LSTM_HIDDEN][LSTM_IN_DIM], const data_t U_o[LSTM_HIDDEN][LSTM_HIDDEN], const data_t b_o[LSTM_HIDDEN],
    const data_t x[LSTM_IN_DIM],
    data_t h[LSTM_HIDDEN],     // in/out: short-term memory
    data_t c[LSTM_HIDDEN]      // in/out: long-term memory (cell state)
) {

    data_t f[LSTM_HIDDEN], i[LSTM_HIDDEN], g[LSTM_HIDDEN], o[LSTM_HIDDEN];

    GATES: for (int j = 0; j < LSTM_HIDDEN; j++) {

        // --- forget gate: f[j] = sigmoid( W_f[j]·x + U_f[j]·h + b_f[j] )
        acc_t acc_f = b_f[j];
        for (int k = 0; k < LSTM_IN_DIM; k++) acc_f += W_f[j][k] * x[k];
        for (int m = 0; m < LSTM_HIDDEN; m++) acc_f += U_f[j][m] * h[m];
        f[j] = sigmoid((data_t)acc_f);

        // --- input gate: i[j] = sigmoid( W_i[j]·x + U_i[j]·h + b_i[j] )
        acc_t acc_i = b_i[j];
        for (int k = 0; k < LSTM_IN_DIM; k++) acc_i += W_i[j][k] * x[k];
        for (int m = 0; m < LSTM_HIDDEN; m++) acc_i += U_i[j][m] * h[m];
        i[j] = sigmoid((data_t)acc_i);

        // --- candidate: g[j] = tanh( W_g[j]·x + U_g[j]·h + b_g[j] )
        acc_t acc_g = b_g[j];
        for (int k = 0; k < LSTM_IN_DIM; k++) acc_g += W_g[j][k] * x[k];
        for (int m = 0; m < LSTM_HIDDEN; m++) acc_g += U_g[j][m] * h[m];
        g[j] = tanh_act((data_t)acc_g);

        // --- output gate: o[j] = sigmoid( W_o[j]·x + U_o[j]·h + b_o[j] )
        acc_t acc_o = b_o[j];
        for (int k = 0; k < LSTM_IN_DIM; k++) acc_o += W_o[j][k] * x[k];
        for (int m = 0; m < LSTM_HIDDEN; m++) acc_o += U_o[j][m] * h[m];
        o[j] = sigmoid((data_t)acc_o);
    }

    // --- state update: elementwise, AFTER all gates have read the old h
    UPDATE: for (int j = 0; j < LSTM_HIDDEN; j++) {
        c[j] = f[j] * c[j] + i[j] * g[j];
        h[j] = o[j] * tanh_act(c[j]);
    }
}

void LSTM(
    const data_t W_f[LSTM_HIDDEN][LSTM_IN_DIM], const data_t U_f[LSTM_HIDDEN][LSTM_HIDDEN], const data_t b_f[LSTM_HIDDEN],
    const data_t W_i[LSTM_HIDDEN][LSTM_IN_DIM], const data_t U_i[LSTM_HIDDEN][LSTM_HIDDEN], const data_t b_i[LSTM_HIDDEN],
    const data_t W_g[LSTM_HIDDEN][LSTM_IN_DIM], const data_t U_g[LSTM_HIDDEN][LSTM_HIDDEN], const data_t b_g[LSTM_HIDDEN],
    const data_t W_o[LSTM_HIDDEN][LSTM_IN_DIM], const data_t U_o[LSTM_HIDDEN][LSTM_HIDDEN], const data_t b_o[LSTM_HIDDEN],
    const data_t x[LSTM_T][LSTM_IN_DIM],
    data_t h[LSTM_HIDDEN],     // out: final hidden state (h_n)
    data_t c[LSTM_HIDDEN]      // out: final cell state
) {

    // PyTorch defaults h_0 = c_0 = 0 when not supplied; match that.
    INIT: for (int j = 0; j < LSTM_HIDDEN; j++) {
        h[j] = 0;
        c[j] = 0;
    }

    TIME: for (int t = 0; t < LSTM_T; t++) {
        LSTM_step(W_f, U_f, b_f,
                  W_i, U_i, b_i,
                  W_g, U_g, b_g,
                  W_o, U_o, b_o,
                  x[t], h, c);
    }

    // final output vector is in h
}