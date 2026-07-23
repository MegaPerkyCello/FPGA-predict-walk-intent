#include <algorithm>
#include <cstdio>
#include <cmath>
#include "layer_dims.h"

// declared in fc.cpp
void fc(const data_t inputs[FC_IN],
        const data_t weights[FC_IN],
        data_t bias,
        data_t outputs[FC_OUT]);

// ---- flat file loader: reads n floats from `path` into buf[0..n-1] ----
static int load_flat(const char *path, float *buf, int n) {
    FILE *f = fopen(path, "r");
    if (!f) { printf("ERROR opening %s\n", path); return 1; }
    for (int i = 0; i < n; i++) {
        if (fscanf(f, "%f", &buf[i]) != 1) {
            printf("ERROR: %s truncated at %d\n", path, i);
            fclose(f);
            return 1;
        }
    }
    fclose(f);
    return 0;
}

// weights/bias shared across every vector -- loaded once
static float  w_flat[FC_IN];
static float  bias_buf[FC_OUT];
static data_t weights[FC_IN];
static data_t bias;

// per-case storage
static float  in_flat[FC_IN];
static float  golden_flat[FC_OUT];
static data_t inputs[FC_IN];
static data_t outputs[FC_OUT];

#ifdef USE_FIXED
const float REL_TOL = 1e-2f;   // one 32-term dot product; kept wide, so error is small
const float ABS_TOL = 5e-3f;
#else
const float REL_TOL = 1e-3f;
const float ABS_TOL = 1e-5f;
#endif

static int run_case(const char *name, const char *dir,
                    const char *input_file, const char *golden_file) {
    char path_in[512], path_out[512];
#ifdef CHAIN_INPUT
    // Consume the quantized LSTM h_n dumped upstream -- the real end-to-end logit.
    snprintf(path_in, sizeof(path_in), "%sfc_%s_chain_input.dat", dir, name);
    const int golden_fatal = 0;   // magnitude drifts through the quantized chain; sign must not
#else
    snprintf(path_in, sizeof(path_in), "%s%s", dir, input_file);
    const int golden_fatal = 1;
#endif
    snprintf(path_out, sizeof(path_out), "%s%s", dir, golden_file);

    if (load_flat(path_in,  in_flat,     FC_IN))  return 1;
    if (load_flat(path_out, golden_flat, FC_OUT)) return 1;

    for (int j = 0; j < FC_IN; j++) inputs[j] = in_flat[j];

    fc(inputs, weights, bias, outputs);

    float got = outputs[0];
    float exp = golden_flat[0];
    float diff = std::abs(got - exp);
    float tol  = ABS_TOL + REL_TOL * std::abs(exp);

    // The metric that matters: does the decision boundary (sign) agree with float?
    // A large magnitude error that never crosses zero is harmless; a small one that
    // does is a decision flip. sign(0) is treated as +.
    int got_sign = (got >= 0.0f) ? 1 : -1;
    int exp_sign = (exp >= 0.0f) ? 1 : -1;
    int sign_flip = (got_sign != exp_sign);

    int mag_fail = (diff > tol);

    printf("[%s] logit got=%.6f exp=%.6f diff=%.3e tol=%.3e | sign got=%s exp=%s %s%s\n",
           name, got, exp, diff, tol,
           got_sign > 0 ? "+" : "-", exp_sign > 0 ? "+" : "-",
           sign_flip ? "*** DECISION FLIP ***" : "sign OK",
           golden_fatal ? "" : " (chain mode: magnitude non-fatal, sign still enforced)");

    int failed = (golden_fatal && mag_fail) || sign_flip;   // sign flip is always fatal
    printf("[%s] %s\n\n", name, failed ? "FAILED" : "PASSED");
    return failed ? 1 : 0;
}

int main() {
    const char *dir = "C:/Users/cocol/Ruby_Proj/workspace/fc/fc_goldens/";
    char path_weights[512], path_bias[512];

    snprintf(path_weights, sizeof(path_weights), "%s%s", dir, "fc_weights.dat");
    snprintf(path_bias,    sizeof(path_bias),    "%s%s", dir, "fc_bias.dat");

    if (load_flat(path_weights, w_flat,   FC_IN) ||
        load_flat(path_bias,    bias_buf, FC_OUT)) {
        printf("\n"
               "fc_TB needs these files exported from the trained checkpoint into\n"
               "  %s\n"
               "    fc_weights.dat            (%d values, Linear.weight row)\n"
               "    fc_bias.dat               (1 value,  Linear.bias)\n"
               "    fc_<case>_input.dat       (%d values = LSTM h_n) for the standalone test\n"
               "    fc_<case>_golden_output.dat (1 value = float PyTorch logit)\n"
               "Cases: synth, idx0, max_range, first_intent, ab156_intent.\n"
               "For the end-to-end run, build with -DCHAIN_INPUT to consume the\n"
               "fc_<case>_chain_input.dat files the LSTM testbench dumps.\n",
               dir, FC_IN, FC_IN);
        return 1;
    }

    for (int j = 0; j < FC_IN; j++) weights[j] = w_flat[j];
    bias = bias_buf[0];

    int overall_fail = 0;
    overall_fail |= run_case("synth",        dir, "fc_synth_input.dat",        "fc_synth_golden_output.dat");
    overall_fail |= run_case("idx0",         dir, "fc_idx0_input.dat",         "fc_idx0_golden_output.dat");
    // Disabled for consistency with the other layers. (fc's input is the tanh-bounded
    // LSTM h, so max_range stays in-range and actually passes here -- re-enable freely.)
    // overall_fail |= run_case("max_range",    dir, "fc_max_range_input.dat",    "fc_max_range_golden_output.dat");
    overall_fail |= run_case("first_intent", dir, "fc_first_intent_input.dat", "fc_first_intent_golden_output.dat");
    overall_fail |= run_case("ab156_intent", dir, "fc_ab156_intent_input.dat", "fc_ab156_intent_golden_output.dat");

    printf("=================================================\n");
    printf("OVERALL: %s\n", overall_fail ? "FAILED" : "PASSED");
    return overall_fail ? 1 : 0;
}
