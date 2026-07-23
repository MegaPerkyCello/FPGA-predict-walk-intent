set SynModuleInfo {
  {SRCNAME LSTM_Pipeline_INIT MODELNAME LSTM_Pipeline_INIT RTLNAME LSTM_LSTM_Pipeline_INIT
    SUBMODULES {
      {MODELNAME LSTM_flow_control_loop_pipe_sequential_init RTLNAME LSTM_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME LSTM_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME exp_generic<double> MODELNAME exp_generic_double_s RTLNAME LSTM_exp_generic_double_s
    SUBMODULES {
      {MODELNAME LSTM_mul_13s_71s_71_5_0 RTLNAME LSTM_mul_13s_71s_71_5_0 BINDTYPE op TYPE mul IMPL auto LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME LSTM_mul_43ns_36ns_79_2_0 RTLNAME LSTM_mul_43ns_36ns_79_2_0 BINDTYPE op TYPE mul IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME LSTM_mul_49ns_44ns_93_2_0 RTLNAME LSTM_mul_49ns_44ns_93_2_0 BINDTYPE op TYPE mul IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME LSTM_mul_50ns_50ns_99_2_0 RTLNAME LSTM_mul_50ns_50ns_99_2_0 BINDTYPE op TYPE mul IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME LSTM_sparsemux_9_3_64_1_0 RTLNAME LSTM_sparsemux_9_3_64_1_0 BINDTYPE op TYPE sparsemux IMPL onehotencoding_realdef}
      {MODELNAME LSTM_mac_muladd_16s_15ns_19s_31_4_0 RTLNAME LSTM_mac_muladd_16s_15ns_19s_31_4_0 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3}
      {MODELNAME LSTM_exp_generic_double_s_table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_arbkb RTLNAME LSTM_exp_generic_double_s_table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_arbkb BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME LSTM_exp_generic_double_s_table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_arracud RTLNAME LSTM_exp_generic_double_s_table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_arracud BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME LSTM_exp_generic_double_s_table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_arradEe RTLNAME LSTM_exp_generic_double_s_table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_arradEe BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME generic_tanh<float> MODELNAME generic_tanh_float_s RTLNAME LSTM_generic_tanh_float_s
    SUBMODULES {
      {MODELNAME LSTM_fadd_32ns_32ns_32_5_full_dsp_1 RTLNAME LSTM_fadd_32ns_32ns_32_5_full_dsp_1 BINDTYPE op TYPE fadd IMPL fulldsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME LSTM_fsub_32ns_32ns_32_5_full_dsp_1 RTLNAME LSTM_fsub_32ns_32ns_32_5_full_dsp_1 BINDTYPE op TYPE fsub IMPL fulldsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME LSTM_fmul_32ns_32ns_32_4_max_dsp_1 RTLNAME LSTM_fmul_32ns_32ns_32_4_max_dsp_1 BINDTYPE op TYPE fmul IMPL maxdsp LATENCY 3 ALLOW_PRAGMA 1}
      {MODELNAME LSTM_fdiv_32ns_32ns_32_12_no_dsp_1 RTLNAME LSTM_fdiv_32ns_32ns_32_12_no_dsp_1 BINDTYPE op TYPE fdiv IMPL fabric LATENCY 11 ALLOW_PRAGMA 1}
      {MODELNAME LSTM_fptrunc_64ns_32_2_no_dsp_1 RTLNAME LSTM_fptrunc_64ns_32_2_no_dsp_1 BINDTYPE op TYPE fptrunc IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME LSTM_fpext_32ns_64_2_no_dsp_1 RTLNAME LSTM_fpext_32ns_64_2_no_dsp_1 BINDTYPE op TYPE fpext IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME LSTM_fcmp_32ns_32ns_1_2_no_dsp_1 RTLNAME LSTM_fcmp_32ns_32ns_1_2_no_dsp_1 BINDTYPE op TYPE fcmp IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME LSTM_dadd_64ns_64ns_64_5_full_dsp_1 RTLNAME LSTM_dadd_64ns_64ns_64_5_full_dsp_1 BINDTYPE op TYPE dadd IMPL fulldsp LATENCY 4 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME LSTM_step_Pipeline_GATES MODELNAME LSTM_step_Pipeline_GATES RTLNAME LSTM_LSTM_step_Pipeline_GATES
    SUBMODULES {
      {MODELNAME LSTM_fexp_32ns_32ns_32_9_full_dsp_1 RTLNAME LSTM_fexp_32ns_32ns_32_9_full_dsp_1 BINDTYPE op TYPE fexp IMPL fulldsp LATENCY 8 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME LSTM_step_Pipeline_UPDATE MODELNAME LSTM_step_Pipeline_UPDATE RTLNAME LSTM_LSTM_step_Pipeline_UPDATE}
  {SRCNAME LSTM_step MODELNAME LSTM_step RTLNAME LSTM_LSTM_step
    SUBMODULES {
      {MODELNAME LSTM_LSTM_step_f_RAM_AUTO_1R1W RTLNAME LSTM_LSTM_step_f_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME LSTM MODELNAME LSTM RTLNAME LSTM IS_TOP 1}
}
