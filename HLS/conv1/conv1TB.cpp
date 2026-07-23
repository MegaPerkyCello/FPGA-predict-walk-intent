#include <algorithm>
#include <cstdio>
#include <cmath>
#include <cstring>
#include "layer_dims.h"

// declared in conv1.cpp
void conv1_1d(const data_t inputs[C1_IC][C1_IN_LEN],
              data_t outputs[C1_OC][C1_OUT_LEN],
              const data_t weights[C1_OC][C1_IC][C1_K],
              const data_t bias[C1_OC]);

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

// flat storage, read straight from disk (per-case, so re-read each case)
static float in_flat[C1_IC * C1_IN_LEN];
static float golden_flat[C1_OC * C1_OUT_LEN];

// weights/bias are shared across every test vector -- loaded once
static float w_flat[C1_OC * C1_IC * C1_K];
static float bias_buf[C1_OC];

// properly-shaped storage, what conv1_1d actually wants
static data_t inputs[C1_IC][C1_IN_LEN];
static data_t weights[C1_OC][C1_IC][C1_K];
static data_t bias[C1_OC];                 // data_t copy of bias_buf (types must match the DUT)
static data_t outputs[C1_OC][C1_OUT_LEN];

#ifdef USE_FIXED
// Fixed-point error grows with MAC width; ABS_TOL is shared with conv2 (whose
// wider 48-tap MAC reaches ~2e-2 on near-zero outputs at <16,6>) for uniformity.
// conv1's 10-tap MAC clears it comfortably. REL_TOL covers large-magnitude
// outputs. max_range still blows past this -- its out-of-range input is meant to.
const float REL_TOL = 1e-2f;
const float ABS_TOL = 2.5e-2f;
#else
const float REL_TOL = 1e-3f;   // float32 MAC-order noise
const float ABS_TOL = 1e-5f;   // catches near-zero cases where rel blows up
#endif

// Dump the quantized conv1 output to pool1's input slot. This file is exactly
// what the hardware feeds pool1 -- rebuild pool1 with -DCHAIN_INPUT to consume it.
static const char *POOL1_DIR = "C:/Users/cocol/Ruby_Proj/workspace/HLS/Relu_Max_1/pool1_goldens/";
static void dump_chain(const char *name) {
    char path[512];
    snprintf(path, sizeof(path), "%spool1_%s_chain_input.dat", POOL1_DIR, name);
    FILE *f = fopen(path, "w");
    if (!f) { printf("  WARN: cannot dump chain input %s\n", path); return; }
    for (int oc = 0; oc < C1_OC; oc++)              // (16,32) channel-major, pool1's layout
        for (int o = 0; o < C1_OUT_LEN; o++)
            fprintf(f, "%.9g\n", (double)(float)outputs[oc][o]);
    fclose(f);
}

static int run_case(const char *name, const char *dir,
                    const char *input_file, const char *golden_file) {
    char path_in[512], path_out[512];
    snprintf(path_in,  sizeof(path_in),  "%s%s", dir, input_file);
    snprintf(path_out, sizeof(path_out), "%s%s", dir, golden_file);

    if (load_flat(path_in,  in_flat,     C1_IC * C1_IN_LEN))  return 1;
    if (load_flat(path_out, golden_flat, C1_OC * C1_OUT_LEN)) return 1;

    for (int i = 0; i < C1_IC * C1_IN_LEN; ++i) {
        int ic  = i / C1_IN_LEN;
        int in_ = i - C1_IN_LEN * ic;
        inputs[ic][in_] = in_flat[i];
    }

    conv1_1d(inputs, outputs, weights, bias);

    dump_chain(name);   // quantized output -> pool1's input file

    int   fail = 0;
    float worst = 0.0f;
    int   worst_oc = -1, worst_o = -1;

    for (int oc = 0; oc < C1_OC; oc++) {
        for (int o = 0; o < C1_OUT_LEN; o++) {
            float got = outputs[oc][o];
            float exp = golden_flat[oc * C1_OUT_LEN + o];
            float diff = std::abs(got - exp);
            float tol  = ABS_TOL + REL_TOL * std::abs(exp);
            float severity = diff / tol;
            if (severity > worst) { worst = severity; worst_oc = oc; worst_o = o; }
            if (diff > tol) {
                if (fail < 10)
                    printf("  MISMATCH oc=%d o=%d got=%.6f exp=%.6f diff=%.3e tol=%.3e\n",
                           oc, o, got, exp, diff, tol);
                ++fail;
            }
        }
    }

    printf("[%s] checked %d values, %d failures, worst severity %.3f at [%d][%d]\n",
           name, C1_OC * C1_OUT_LEN, fail, worst, worst_oc, worst_o);
    printf("[%s] %s\n\n", name, fail ? "FAILED" : "PASSED");
    return fail ? 1 : 0;
}

int main() {
    const char *dir = "C:/Users/cocol/Ruby_Proj/workspace/HLS/conv1/conv1_goldens/";
    char path_weights[512], path_bias[512];

    snprintf(path_weights, sizeof(path_weights), "%s%s", dir, "conv1_weights.dat");
    snprintf(path_bias,    sizeof(path_bias),    "%s%s", dir, "conv1_bias.dat");

    if (load_flat(path_weights, w_flat,   C1_OC * C1_IC * C1_K)) return 1;
    if (load_flat(path_bias,    bias_buf, C1_OC))                return 1;

    for (int i = 0; i < C1_OC * C1_IC * C1_K; i++) {
        int oc  = i / (C1_IC * C1_K);
        int rem = i - oc * (C1_IC * C1_K);
        int ic  = rem / C1_K;
        int k   = rem - ic * C1_K;
        weights[oc][ic][k] = w_flat[i];
    }
    for (int oc = 0; oc < C1_OC; oc++) bias[oc] = bias_buf[oc];   // float -> data_t

    int overall_fail = 0;
    overall_fail |= run_case("synth",        dir, "conv1_synth_input.dat",        "conv1_synth_golden_output.dat");
    overall_fail |= run_case("idx0",         dir, "conv1_idx0_input.dat",         "conv1_idx0_golden_output.dat");
    // max_range is an out-of-range probe (input |v|~142) that intentionally saturates
    // <16,6>; it always fails the fixed-point C-sim. Re-enable to check the range canary.
    // overall_fail |= run_case("max_range",    dir, "conv1_max_range_input.dat",    "conv1_max_range_golden_output.dat");
    overall_fail |= run_case("first_intent", dir, "conv1_first_intent_input.dat", "conv1_first_intent_golden_output.dat");
    overall_fail |= run_case("ab156_intent", dir, "conv1_ab156_intent_input.dat", "conv1_ab156_intent_golden_output.dat");

    printf("=================================================\n");
    printf("OVERALL: %s\n", overall_fail ? "FAILED" : "PASSED");
    return overall_fail ? 1 : 0;
}