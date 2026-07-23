
#include "layer_dims.h"

// Conv1d(2 -> 16, k=5, pad=2). Raw convolution only --
// ReLU and pooling live in relu_max_1.
void conv1_1d(const data_t inputs[C1_IC][C1_IN_LEN],
              data_t outputs[C1_OC][C1_OUT_LEN],
              const data_t weights[C1_OC][C1_IC][C1_K],
              const data_t bias[C1_OC]) {
                
    // #pragma HLS array_partition variable=weights complete dim=3
    // #pragma HLS array_partition variable=inputs cyclic factor=5 dim=2
    // #pragma HLS PIPELINE II=2            
    
    for (int oc = 0; oc < C1_OC; ++oc) {
        for (int o = 0; o < C1_OUT_LEN; ++o) {
            data_t acc = bias[oc];

            for (int ic = 0; ic < C1_IC; ++ic) {
                for (int k = 0; k < C1_K; ++k) {

                    // #pragma HLS UNROLL

                    int idx = o - C1_PAD + k;
                    data_t v = (idx >= 0 && idx < C1_IN_LEN) ? inputs[ic][idx] : (data_t)0;
                    acc += v * weights[oc][ic][k];
                }
            }
            outputs[oc][o] = acc;
        }
    }
}