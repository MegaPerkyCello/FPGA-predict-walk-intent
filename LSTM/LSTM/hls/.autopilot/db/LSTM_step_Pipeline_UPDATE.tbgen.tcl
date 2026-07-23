set moduleName LSTM_step_Pipeline_UPDATE
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set isPipelined_legacy 1
set pipeline_type loop_auto_rewind
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 9
set C_modelName {LSTM_step_Pipeline_UPDATE}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict f { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict c { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict i { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict g { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict o { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict h { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ f float 32 regular {array 32 { 1 3 } 1 1 }  }
	{ c int 32 regular {array 32 { 0 1 } 1 1 }  }
	{ i float 32 regular {array 32 { 1 3 } 1 1 }  }
	{ g float 32 regular {array 32 { 1 3 } 1 1 }  }
	{ o float 32 regular {array 32 { 1 3 } 1 1 }  }
	{ h int 32 regular {array 32 { 0 3 } 0 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "f", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "c", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "i", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "g", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "o", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "h", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 48
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ f_address0 sc_out sc_lv 5 signal 0 } 
	{ f_ce0 sc_out sc_logic 1 signal 0 } 
	{ f_q0 sc_in sc_lv 32 signal 0 } 
	{ c_address0 sc_out sc_lv 5 signal 1 } 
	{ c_ce0 sc_out sc_logic 1 signal 1 } 
	{ c_we0 sc_out sc_logic 1 signal 1 } 
	{ c_d0 sc_out sc_lv 32 signal 1 } 
	{ c_address1 sc_out sc_lv 5 signal 1 } 
	{ c_ce1 sc_out sc_logic 1 signal 1 } 
	{ c_q1 sc_in sc_lv 32 signal 1 } 
	{ i_address0 sc_out sc_lv 5 signal 2 } 
	{ i_ce0 sc_out sc_logic 1 signal 2 } 
	{ i_q0 sc_in sc_lv 32 signal 2 } 
	{ g_address0 sc_out sc_lv 5 signal 3 } 
	{ g_ce0 sc_out sc_logic 1 signal 3 } 
	{ g_q0 sc_in sc_lv 32 signal 3 } 
	{ o_address0 sc_out sc_lv 5 signal 4 } 
	{ o_ce0 sc_out sc_logic 1 signal 4 } 
	{ o_q0 sc_in sc_lv 32 signal 4 } 
	{ h_address0 sc_out sc_lv 5 signal 5 } 
	{ h_ce0 sc_out sc_logic 1 signal 5 } 
	{ h_we0 sc_out sc_logic 1 signal 5 } 
	{ h_d0 sc_out sc_lv 32 signal 5 } 
	{ grp_fu_2508_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_2508_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_2508_p_opcode sc_out sc_lv 2 signal -1 } 
	{ grp_fu_2508_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_2508_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_2512_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_2512_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_2512_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_2512_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_2516_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_2516_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_2516_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_2516_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_2520_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_2520_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_2520_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_2520_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_generic_tanh_float_s_fu_2524_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_generic_tanh_float_s_fu_2524_p_dout0 sc_in sc_lv 32 signal -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "f_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "f", "role": "address0" }} , 
 	{ "name": "f_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "f", "role": "ce0" }} , 
 	{ "name": "f_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "f", "role": "q0" }} , 
 	{ "name": "c_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "c", "role": "address0" }} , 
 	{ "name": "c_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c", "role": "ce0" }} , 
 	{ "name": "c_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c", "role": "we0" }} , 
 	{ "name": "c_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "c", "role": "d0" }} , 
 	{ "name": "c_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "c", "role": "address1" }} , 
 	{ "name": "c_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c", "role": "ce1" }} , 
 	{ "name": "c_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "c", "role": "q1" }} , 
 	{ "name": "i_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "i", "role": "address0" }} , 
 	{ "name": "i_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "i", "role": "ce0" }} , 
 	{ "name": "i_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "i", "role": "q0" }} , 
 	{ "name": "g_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "g", "role": "address0" }} , 
 	{ "name": "g_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "g", "role": "ce0" }} , 
 	{ "name": "g_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "g", "role": "q0" }} , 
 	{ "name": "o_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "o", "role": "address0" }} , 
 	{ "name": "o_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "o", "role": "ce0" }} , 
 	{ "name": "o_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "o", "role": "q0" }} , 
 	{ "name": "h_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "h", "role": "address0" }} , 
 	{ "name": "h_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "h", "role": "ce0" }} , 
 	{ "name": "h_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "h", "role": "we0" }} , 
 	{ "name": "h_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "h", "role": "d0" }} , 
 	{ "name": "grp_fu_2508_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_2508_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_2508_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_2508_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_2508_p_opcode", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "grp_fu_2508_p_opcode", "role": "default" }} , 
 	{ "name": "grp_fu_2508_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_2508_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_2508_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_2508_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_2512_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_2512_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_2512_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_2512_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_2512_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_2512_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_2512_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_2512_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_2516_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_2516_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_2516_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_2516_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_2516_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_2516_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_2516_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_2516_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_2520_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_2520_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_2520_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_2520_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_2520_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_2520_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_2520_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_2520_p_ce", "role": "default" }} , 
 	{ "name": "grp_generic_tanh_float_s_fu_2524_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_generic_tanh_float_s_fu_2524_p_din1", "role": "default" }} , 
 	{ "name": "grp_generic_tanh_float_s_fu_2524_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_generic_tanh_float_s_fu_2524_p_dout0", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	LSTM_step_Pipeline_UPDATE {
		f {Type I LastRead 0 FirstWrite -1}
		c {Type IO LastRead 0 FirstWrite 11}
		i {Type I LastRead 0 FirstWrite -1}
		g {Type I LastRead 0 FirstWrite -1}
		o {Type I LastRead 70 FirstWrite -1}
		h {Type O LastRead -1 FirstWrite 76}
		table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}
		table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}
		table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "109", "Max" : "109"}
	, {"Name" : "Interval", "Min" : "109", "Max" : "109"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	f { ap_memory {  { f_address0 mem_address 1 5 }  { f_ce0 mem_ce 1 1 }  { f_q0 mem_dout 0 32 } } }
	c { ap_memory {  { c_address0 mem_address 1 5 }  { c_ce0 mem_ce 1 1 }  { c_we0 mem_we 1 1 }  { c_d0 mem_din 1 32 }  { c_address1 MemPortADDR2 1 5 }  { c_ce1 MemPortCE2 1 1 }  { c_q1 MemPortDOUT2 0 32 } } }
	i { ap_memory {  { i_address0 mem_address 1 5 }  { i_ce0 mem_ce 1 1 }  { i_q0 mem_dout 0 32 } } }
	g { ap_memory {  { g_address0 mem_address 1 5 }  { g_ce0 mem_ce 1 1 }  { g_q0 mem_dout 0 32 } } }
	o { ap_memory {  { o_address0 mem_address 1 5 }  { o_ce0 mem_ce 1 1 }  { o_q0 mem_dout 0 32 } } }
	h { ap_memory {  { h_address0 mem_address 1 5 }  { h_ce0 mem_ce 1 1 }  { h_we0 mem_we 1 1 }  { h_d0 mem_din 1 32 } } }
}
