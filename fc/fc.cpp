
#include "layer_dims.h"

// Linear(32 -> 1): the classifier head. One dot product + bias -> a single logit.
// This is the layer whose output decides the class; the metric that matters for
// the fixed-point sweep is whether sign(logit) matches float PyTorch, not the
// per-element error. It's one MAC of 32 terms -- cheap -- so keep it wide.
//
// weights are the Linear layer's weight row (out_features=1, in_features=32),
// so a flat 32-vector; bias is the single scalar bias.
void fc(const data_t inputs[FC_IN],
        const data_t weights[FC_IN],
        data_t bias,
        data_t outputs[FC_OUT]) {

    acc_t acc = bias;                                  // wide accumulator, same rationale as the convs
    FC_MAC: for (int j = 0; j < FC_IN; j++)
        acc += inputs[j] * weights[j];

    outputs[0] = (data_t)acc;
}
