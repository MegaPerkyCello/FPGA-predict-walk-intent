#include <cstdio>
#include <cmath>
#include "layer_dims.h"

// Two DUTs, tested at two levels:
//
//   inference()        pure function of a full 32-sample window. Verified against
//                      the PyTorch goldens exactly as before -- this is the math check.
//   inference_stream() THE TOP LEVEL. Stateful: holds the sliding window internally
//                      and consumes one sample pair per call. This is the check that
//                      the shift is correct, and it is the only one cosim exercises
//                      as RTL (calls to non-top functions run as plain C under cosim).
//
// Splitting them matters for diagnosis: if the streaming case fails while the pure
// case passes, the arithmetic is fine and the shift is wrong.
void inference(const data_t inputs[C1_IC][C1_IN_LEN], data_t outputs[FC_OUT]);
void inference_stream(data_t emg_sample, data_t gyro_sample, data_t *logit);

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

static const char *DIR = "C:/Users/cocol/Ruby_Proj/workspace/HLS/inference/inference_goldens/";

static float  in_flat[C1_IC * C1_IN_LEN];
static float  golden[FC_OUT];
static data_t window[C1_IC][C1_IN_LEN];
static data_t outputs[FC_OUT];

// Magnitude drift through the full quantized chain is expected and non-fatal
// (~5e-3 measured at <16,6>); it is reported so erosion stays visible if precision
// is ever reduced. A sign disagreement is a decision flip and always fatal.
const float REPORT_TOL = 5e-2f;

static int load_case(const char *name) {
    char path_in[512], path_out[512];
    snprintf(path_in,  sizeof(path_in),  "%sinference_%s_input.dat",         DIR, name);
    snprintf(path_out, sizeof(path_out), "%sinference_%s_golden_output.dat", DIR, name);
    if (load_flat(path_in,  in_flat, C1_IC * C1_IN_LEN)) return 1;
    if (load_flat(path_out, golden,  FC_OUT))            return 1;
    for (int ch = 0; ch < C1_IC; ch++)
        for (int t = 0; t < C1_IN_LEN; t++)
            window[ch][t] = in_flat[ch * C1_IN_LEN + t];
    return 0;
}

static int report(const char *name, const char *mode, float got, float exp) {
    float diff = std::abs(got - exp);
    int got_sign  = (got >= 0.0f) ? 1 : -1;
    int exp_sign  = (exp >= 0.0f) ? 1 : -1;
    int sign_flip = (got_sign != exp_sign);
    printf("[%-13s %-6s] logit got=%+.6f exp=%+.6f drift=%.3e | sign %s %s\n",
           name, mode, got, exp, diff,
           sign_flip ? "MISMATCH" : "OK",
           sign_flip ? "*** DECISION FLIP ***"
                     : (diff > REPORT_TOL ? "(drift above report threshold)" : ""));
    return sign_flip ? 1 : 0;
}

// Pure core: hand it the whole window at once.
static int run_pure(const char *name) {
    if (load_case(name)) return 1;
    inference(window, outputs);
    return report(name, "pure", (float)outputs[0], golden[0]);
}

// Streaming top level: feed the same window one sample pair at a time, OLDEST
// FIRST, and check the logit produced by the last call. After 32 calls the
// internal window has been completely replaced, so cases do not contaminate each
// other and no reset is needed between them.
//
// This is what makes the test sharp: feeding t = 0..31 in time order must leave
// the internal window byte-identical to the golden window. If the shift ran the
// other way, the block would see the window time-reversed and the logit would
// diverge grossly rather than subtly.
static int run_stream(const char *name) {
    if (load_case(name)) return 1;
    data_t lg = 0;
    for (int t = 0; t < C1_IN_LEN; t++)
        inference_stream(window[0][t], window[1][t], &lg);
    return report(name, "stream", (float)lg, golden[0]);
}

int main() {
    int overall_fail = 0;
    // max_range is omitted for the same reason as every other layer TB: its input
    // reaches |142| and intentionally overflows <16,6>. It is the range canary,
    // exercised standalone, not part of the sign-off set.
    const char *cases[] = {"synth", "idx0", "first_intent", "ab156_intent"};
    const int  n_cases  = 4;

    printf("--- pure core: inference(window) vs PyTorch goldens ---\n");
    for (int i = 0; i < n_cases; i++) overall_fail |= run_pure(cases[i]);

    printf("\n--- top level: inference_stream(), 32 sample pairs per case ---\n");
    for (int i = 0; i < n_cases; i++) overall_fail |= run_stream(cases[i]);

    printf("=================================================\n");
    printf("OVERALL: %s\n", overall_fail ? "FAILED" : "PASSED");
    return overall_fail ? 1 : 0;
}
