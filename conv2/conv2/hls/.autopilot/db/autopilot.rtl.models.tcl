set SynModuleInfo {
  {SRCNAME conv2_1d MODELNAME conv2_1d RTLNAME conv2_1d IS_TOP 1
    SUBMODULES {
      {MODELNAME conv2_1d_fadd_32ns_32ns_32_5_full_dsp_1 RTLNAME conv2_1d_fadd_32ns_32ns_32_5_full_dsp_1 BINDTYPE op TYPE fadd IMPL fulldsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME conv2_1d_fmul_32ns_32ns_32_4_max_dsp_1 RTLNAME conv2_1d_fmul_32ns_32ns_32_4_max_dsp_1 BINDTYPE op TYPE fmul IMPL maxdsp LATENCY 3 ALLOW_PRAGMA 1}
      {MODELNAME conv2_1d_flow_control_loop_delay_pipe RTLNAME conv2_1d_flow_control_loop_delay_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME conv2_1d_flow_control_loop_delay_pipe_U}
    }
  }
}
