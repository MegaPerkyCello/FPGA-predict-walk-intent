set moduleName conv2_1d
set isTopModule 1
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
set cdfgNum 2
set C_modelName {conv2_1d}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict inputs { MEM_WIDTH 32 MEM_SIZE 1024 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict outputs { MEM_WIDTH 32 MEM_SIZE 2048 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict weights { MEM_WIDTH 32 MEM_SIZE 6144 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict bias { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ inputs int 32 regular {array 256 { 1 1 } 1 1 }  }
	{ outputs int 32 regular {array 512 { 0 3 } 0 1 }  }
	{ weights int 32 regular {array 1536 { 1 1 } 1 1 }  }
	{ bias int 32 regular {array 32 { 1 3 } 1 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "inputs", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "outputs", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "weights", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "bias", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 25
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ inputs_address0 sc_out sc_lv 8 signal 0 } 
	{ inputs_ce0 sc_out sc_logic 1 signal 0 } 
	{ inputs_q0 sc_in sc_lv 32 signal 0 } 
	{ inputs_address1 sc_out sc_lv 8 signal 0 } 
	{ inputs_ce1 sc_out sc_logic 1 signal 0 } 
	{ inputs_q1 sc_in sc_lv 32 signal 0 } 
	{ outputs_address0 sc_out sc_lv 9 signal 1 } 
	{ outputs_ce0 sc_out sc_logic 1 signal 1 } 
	{ outputs_we0 sc_out sc_logic 1 signal 1 } 
	{ outputs_d0 sc_out sc_lv 32 signal 1 } 
	{ weights_address0 sc_out sc_lv 11 signal 2 } 
	{ weights_ce0 sc_out sc_logic 1 signal 2 } 
	{ weights_q0 sc_in sc_lv 32 signal 2 } 
	{ weights_address1 sc_out sc_lv 11 signal 2 } 
	{ weights_ce1 sc_out sc_logic 1 signal 2 } 
	{ weights_q1 sc_in sc_lv 32 signal 2 } 
	{ bias_address0 sc_out sc_lv 5 signal 3 } 
	{ bias_ce0 sc_out sc_logic 1 signal 3 } 
	{ bias_q0 sc_in sc_lv 32 signal 3 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "inputs_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "inputs", "role": "address0" }} , 
 	{ "name": "inputs_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs", "role": "ce0" }} , 
 	{ "name": "inputs_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "inputs", "role": "q0" }} , 
 	{ "name": "inputs_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "inputs", "role": "address1" }} , 
 	{ "name": "inputs_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "inputs", "role": "ce1" }} , 
 	{ "name": "inputs_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "inputs", "role": "q1" }} , 
 	{ "name": "outputs_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "outputs", "role": "address0" }} , 
 	{ "name": "outputs_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "outputs", "role": "ce0" }} , 
 	{ "name": "outputs_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "outputs", "role": "we0" }} , 
 	{ "name": "outputs_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "outputs", "role": "d0" }} , 
 	{ "name": "weights_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "weights", "role": "address0" }} , 
 	{ "name": "weights_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "weights", "role": "ce0" }} , 
 	{ "name": "weights_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "weights", "role": "q0" }} , 
 	{ "name": "weights_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "weights", "role": "address1" }} , 
 	{ "name": "weights_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "weights", "role": "ce1" }} , 
 	{ "name": "weights_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "weights", "role": "q1" }} , 
 	{ "name": "bias_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "bias", "role": "address0" }} , 
 	{ "name": "bias_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bias", "role": "ce0" }} , 
 	{ "name": "bias_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bias", "role": "q0" }}  ]}

set ArgLastReadFirstWriteLatency {
	conv2_1d {
		inputs {Type I LastRead 24 FirstWrite -1}
		outputs {Type O LastRead -1 FirstWrite 247}
		weights {Type I LastRead 25 FirstWrite -1}
		bias {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "12513", "Max" : "12513"}
	, {"Name" : "Interval", "Min" : "12514", "Max" : "12514"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	inputs { ap_memory {  { inputs_address0 mem_address 1 8 }  { inputs_ce0 mem_ce 1 1 }  { inputs_q0 mem_dout 0 32 }  { inputs_address1 MemPortADDR2 1 8 }  { inputs_ce1 MemPortCE2 1 1 }  { inputs_q1 MemPortDOUT2 0 32 } } }
	outputs { ap_memory {  { outputs_address0 mem_address 1 9 }  { outputs_ce0 mem_ce 1 1 }  { outputs_we0 mem_we 1 1 }  { outputs_d0 mem_din 1 32 } } }
	weights { ap_memory {  { weights_address0 mem_address 1 11 }  { weights_ce0 mem_ce 1 1 }  { weights_q0 mem_dout 0 32 }  { weights_address1 MemPortADDR2 1 11 }  { weights_ce1 MemPortCE2 1 1 }  { weights_q1 MemPortDOUT2 0 32 } } }
	bias { ap_memory {  { bias_address0 mem_address 1 5 }  { bias_ce0 mem_ce 1 1 }  { bias_q0 mem_dout 0 32 } } }
}

set maxi_interface_dict [dict create]

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
