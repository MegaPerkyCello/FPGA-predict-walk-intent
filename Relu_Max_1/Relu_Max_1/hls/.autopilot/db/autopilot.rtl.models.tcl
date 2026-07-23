set SynModuleInfo {
  {SRCNAME relu_max_1 MODELNAME relu_max_1 RTLNAME relu_max_1 IS_TOP 1
    SUBMODULES {
      {MODELNAME relu_max_1_fcmp_32ns_32ns_1_2_no_dsp_1 RTLNAME relu_max_1_fcmp_32ns_32ns_1_2_no_dsp_1 BINDTYPE op TYPE fcmp IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME relu_max_1_flow_control_loop_pipe RTLNAME relu_max_1_flow_control_loop_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME relu_max_1_flow_control_loop_pipe_U}
    }
  }
}
