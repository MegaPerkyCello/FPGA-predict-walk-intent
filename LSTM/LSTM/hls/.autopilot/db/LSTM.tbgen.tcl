set moduleName LSTM
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set isPipelined_legacy 0
set pipeline_type none
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
set C_modelName {LSTM}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict W_f { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict U_f { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict b_f { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict W_i { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict U_i { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict b_i { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict W_g { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict U_g { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict b_g { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict W_o { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict U_o { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict b_o { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict x { MEM_WIDTH 32 MEM_SIZE 1024 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict h { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict c { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ W_f int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ U_f int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ b_f int 32 regular {array 32 { 1 3 } 1 1 }  }
	{ W_i int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ U_i int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ b_i int 32 regular {array 32 { 1 3 } 1 1 }  }
	{ W_g int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ U_g int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ b_g int 32 regular {array 32 { 1 3 } 1 1 }  }
	{ W_o int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ U_o int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ b_o int 32 regular {array 32 { 1 3 } 1 1 }  }
	{ x int 32 regular {array 256 { 1 1 } 1 1 }  }
	{ h int 32 regular {array 32 { 2 1 } 1 1 }  }
	{ c int 32 regular {array 32 { 0 1 } 1 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "W_f", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "U_f", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "b_f", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "W_i", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "U_i", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "b_i", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "W_g", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "U_g", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "b_g", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "W_o", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "U_o", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "b_o", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "x", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "h", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "c", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} ]}
# RTL Port declarations: 
set portNum 87
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ W_f_address0 sc_out sc_lv 10 signal 0 } 
	{ W_f_ce0 sc_out sc_logic 1 signal 0 } 
	{ W_f_q0 sc_in sc_lv 32 signal 0 } 
	{ W_f_address1 sc_out sc_lv 10 signal 0 } 
	{ W_f_ce1 sc_out sc_logic 1 signal 0 } 
	{ W_f_q1 sc_in sc_lv 32 signal 0 } 
	{ U_f_address0 sc_out sc_lv 10 signal 1 } 
	{ U_f_ce0 sc_out sc_logic 1 signal 1 } 
	{ U_f_q0 sc_in sc_lv 32 signal 1 } 
	{ U_f_address1 sc_out sc_lv 10 signal 1 } 
	{ U_f_ce1 sc_out sc_logic 1 signal 1 } 
	{ U_f_q1 sc_in sc_lv 32 signal 1 } 
	{ b_f_address0 sc_out sc_lv 5 signal 2 } 
	{ b_f_ce0 sc_out sc_logic 1 signal 2 } 
	{ b_f_q0 sc_in sc_lv 32 signal 2 } 
	{ W_i_address0 sc_out sc_lv 10 signal 3 } 
	{ W_i_ce0 sc_out sc_logic 1 signal 3 } 
	{ W_i_q0 sc_in sc_lv 32 signal 3 } 
	{ W_i_address1 sc_out sc_lv 10 signal 3 } 
	{ W_i_ce1 sc_out sc_logic 1 signal 3 } 
	{ W_i_q1 sc_in sc_lv 32 signal 3 } 
	{ U_i_address0 sc_out sc_lv 10 signal 4 } 
	{ U_i_ce0 sc_out sc_logic 1 signal 4 } 
	{ U_i_q0 sc_in sc_lv 32 signal 4 } 
	{ U_i_address1 sc_out sc_lv 10 signal 4 } 
	{ U_i_ce1 sc_out sc_logic 1 signal 4 } 
	{ U_i_q1 sc_in sc_lv 32 signal 4 } 
	{ b_i_address0 sc_out sc_lv 5 signal 5 } 
	{ b_i_ce0 sc_out sc_logic 1 signal 5 } 
	{ b_i_q0 sc_in sc_lv 32 signal 5 } 
	{ W_g_address0 sc_out sc_lv 10 signal 6 } 
	{ W_g_ce0 sc_out sc_logic 1 signal 6 } 
	{ W_g_q0 sc_in sc_lv 32 signal 6 } 
	{ W_g_address1 sc_out sc_lv 10 signal 6 } 
	{ W_g_ce1 sc_out sc_logic 1 signal 6 } 
	{ W_g_q1 sc_in sc_lv 32 signal 6 } 
	{ U_g_address0 sc_out sc_lv 10 signal 7 } 
	{ U_g_ce0 sc_out sc_logic 1 signal 7 } 
	{ U_g_q0 sc_in sc_lv 32 signal 7 } 
	{ U_g_address1 sc_out sc_lv 10 signal 7 } 
	{ U_g_ce1 sc_out sc_logic 1 signal 7 } 
	{ U_g_q1 sc_in sc_lv 32 signal 7 } 
	{ b_g_address0 sc_out sc_lv 5 signal 8 } 
	{ b_g_ce0 sc_out sc_logic 1 signal 8 } 
	{ b_g_q0 sc_in sc_lv 32 signal 8 } 
	{ W_o_address0 sc_out sc_lv 10 signal 9 } 
	{ W_o_ce0 sc_out sc_logic 1 signal 9 } 
	{ W_o_q0 sc_in sc_lv 32 signal 9 } 
	{ W_o_address1 sc_out sc_lv 10 signal 9 } 
	{ W_o_ce1 sc_out sc_logic 1 signal 9 } 
	{ W_o_q1 sc_in sc_lv 32 signal 9 } 
	{ U_o_address0 sc_out sc_lv 10 signal 10 } 
	{ U_o_ce0 sc_out sc_logic 1 signal 10 } 
	{ U_o_q0 sc_in sc_lv 32 signal 10 } 
	{ U_o_address1 sc_out sc_lv 10 signal 10 } 
	{ U_o_ce1 sc_out sc_logic 1 signal 10 } 
	{ U_o_q1 sc_in sc_lv 32 signal 10 } 
	{ b_o_address0 sc_out sc_lv 5 signal 11 } 
	{ b_o_ce0 sc_out sc_logic 1 signal 11 } 
	{ b_o_q0 sc_in sc_lv 32 signal 11 } 
	{ x_address0 sc_out sc_lv 8 signal 12 } 
	{ x_ce0 sc_out sc_logic 1 signal 12 } 
	{ x_q0 sc_in sc_lv 32 signal 12 } 
	{ x_address1 sc_out sc_lv 8 signal 12 } 
	{ x_ce1 sc_out sc_logic 1 signal 12 } 
	{ x_q1 sc_in sc_lv 32 signal 12 } 
	{ h_address0 sc_out sc_lv 5 signal 13 } 
	{ h_ce0 sc_out sc_logic 1 signal 13 } 
	{ h_we0 sc_out sc_logic 1 signal 13 } 
	{ h_d0 sc_out sc_lv 32 signal 13 } 
	{ h_q0 sc_in sc_lv 32 signal 13 } 
	{ h_address1 sc_out sc_lv 5 signal 13 } 
	{ h_ce1 sc_out sc_logic 1 signal 13 } 
	{ h_q1 sc_in sc_lv 32 signal 13 } 
	{ c_address0 sc_out sc_lv 5 signal 14 } 
	{ c_ce0 sc_out sc_logic 1 signal 14 } 
	{ c_we0 sc_out sc_logic 1 signal 14 } 
	{ c_d0 sc_out sc_lv 32 signal 14 } 
	{ c_address1 sc_out sc_lv 5 signal 14 } 
	{ c_ce1 sc_out sc_logic 1 signal 14 } 
	{ c_q1 sc_in sc_lv 32 signal 14 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "W_f_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "W_f", "role": "address0" }} , 
 	{ "name": "W_f_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "W_f", "role": "ce0" }} , 
 	{ "name": "W_f_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "W_f", "role": "q0" }} , 
 	{ "name": "W_f_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "W_f", "role": "address1" }} , 
 	{ "name": "W_f_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "W_f", "role": "ce1" }} , 
 	{ "name": "W_f_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "W_f", "role": "q1" }} , 
 	{ "name": "U_f_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "U_f", "role": "address0" }} , 
 	{ "name": "U_f_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "U_f", "role": "ce0" }} , 
 	{ "name": "U_f_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "U_f", "role": "q0" }} , 
 	{ "name": "U_f_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "U_f", "role": "address1" }} , 
 	{ "name": "U_f_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "U_f", "role": "ce1" }} , 
 	{ "name": "U_f_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "U_f", "role": "q1" }} , 
 	{ "name": "b_f_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "b_f", "role": "address0" }} , 
 	{ "name": "b_f_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_f", "role": "ce0" }} , 
 	{ "name": "b_f_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "b_f", "role": "q0" }} , 
 	{ "name": "W_i_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "W_i", "role": "address0" }} , 
 	{ "name": "W_i_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "W_i", "role": "ce0" }} , 
 	{ "name": "W_i_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "W_i", "role": "q0" }} , 
 	{ "name": "W_i_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "W_i", "role": "address1" }} , 
 	{ "name": "W_i_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "W_i", "role": "ce1" }} , 
 	{ "name": "W_i_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "W_i", "role": "q1" }} , 
 	{ "name": "U_i_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "U_i", "role": "address0" }} , 
 	{ "name": "U_i_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "U_i", "role": "ce0" }} , 
 	{ "name": "U_i_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "U_i", "role": "q0" }} , 
 	{ "name": "U_i_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "U_i", "role": "address1" }} , 
 	{ "name": "U_i_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "U_i", "role": "ce1" }} , 
 	{ "name": "U_i_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "U_i", "role": "q1" }} , 
 	{ "name": "b_i_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "b_i", "role": "address0" }} , 
 	{ "name": "b_i_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_i", "role": "ce0" }} , 
 	{ "name": "b_i_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "b_i", "role": "q0" }} , 
 	{ "name": "W_g_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "W_g", "role": "address0" }} , 
 	{ "name": "W_g_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "W_g", "role": "ce0" }} , 
 	{ "name": "W_g_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "W_g", "role": "q0" }} , 
 	{ "name": "W_g_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "W_g", "role": "address1" }} , 
 	{ "name": "W_g_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "W_g", "role": "ce1" }} , 
 	{ "name": "W_g_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "W_g", "role": "q1" }} , 
 	{ "name": "U_g_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "U_g", "role": "address0" }} , 
 	{ "name": "U_g_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "U_g", "role": "ce0" }} , 
 	{ "name": "U_g_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "U_g", "role": "q0" }} , 
 	{ "name": "U_g_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "U_g", "role": "address1" }} , 
 	{ "name": "U_g_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "U_g", "role": "ce1" }} , 
 	{ "name": "U_g_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "U_g", "role": "q1" }} , 
 	{ "name": "b_g_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "b_g", "role": "address0" }} , 
 	{ "name": "b_g_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_g", "role": "ce0" }} , 
 	{ "name": "b_g_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "b_g", "role": "q0" }} , 
 	{ "name": "W_o_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "W_o", "role": "address0" }} , 
 	{ "name": "W_o_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "W_o", "role": "ce0" }} , 
 	{ "name": "W_o_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "W_o", "role": "q0" }} , 
 	{ "name": "W_o_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "W_o", "role": "address1" }} , 
 	{ "name": "W_o_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "W_o", "role": "ce1" }} , 
 	{ "name": "W_o_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "W_o", "role": "q1" }} , 
 	{ "name": "U_o_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "U_o", "role": "address0" }} , 
 	{ "name": "U_o_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "U_o", "role": "ce0" }} , 
 	{ "name": "U_o_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "U_o", "role": "q0" }} , 
 	{ "name": "U_o_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "U_o", "role": "address1" }} , 
 	{ "name": "U_o_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "U_o", "role": "ce1" }} , 
 	{ "name": "U_o_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "U_o", "role": "q1" }} , 
 	{ "name": "b_o_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "b_o", "role": "address0" }} , 
 	{ "name": "b_o_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_o", "role": "ce0" }} , 
 	{ "name": "b_o_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "b_o", "role": "q0" }} , 
 	{ "name": "x_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "x", "role": "address0" }} , 
 	{ "name": "x_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "x", "role": "ce0" }} , 
 	{ "name": "x_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "x", "role": "q0" }} , 
 	{ "name": "x_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "x", "role": "address1" }} , 
 	{ "name": "x_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "x", "role": "ce1" }} , 
 	{ "name": "x_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "x", "role": "q1" }} , 
 	{ "name": "h_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "h", "role": "address0" }} , 
 	{ "name": "h_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "h", "role": "ce0" }} , 
 	{ "name": "h_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "h", "role": "we0" }} , 
 	{ "name": "h_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "h", "role": "d0" }} , 
 	{ "name": "h_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "h", "role": "q0" }} , 
 	{ "name": "h_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "h", "role": "address1" }} , 
 	{ "name": "h_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "h", "role": "ce1" }} , 
 	{ "name": "h_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "h", "role": "q1" }} , 
 	{ "name": "c_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "c", "role": "address0" }} , 
 	{ "name": "c_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c", "role": "ce0" }} , 
 	{ "name": "c_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c", "role": "we0" }} , 
 	{ "name": "c_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "c", "role": "d0" }} , 
 	{ "name": "c_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "c", "role": "address1" }} , 
 	{ "name": "c_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c", "role": "ce1" }} , 
 	{ "name": "c_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "c", "role": "q1" }}  ]}

set ArgLastReadFirstWriteLatency {
	LSTM {
		W_f {Type I LastRead 16 FirstWrite -1}
		U_f {Type I LastRead 16 FirstWrite -1}
		b_f {Type I LastRead 0 FirstWrite -1}
		W_i {Type I LastRead 16 FirstWrite -1}
		U_i {Type I LastRead 16 FirstWrite -1}
		b_i {Type I LastRead 0 FirstWrite -1}
		W_g {Type I LastRead 16 FirstWrite -1}
		U_g {Type I LastRead 16 FirstWrite -1}
		b_g {Type I LastRead 0 FirstWrite -1}
		W_o {Type I LastRead 16 FirstWrite -1}
		U_o {Type I LastRead 16 FirstWrite -1}
		b_o {Type I LastRead 0 FirstWrite -1}
		x {Type I LastRead 16 FirstWrite -1}
		h {Type IO LastRead 16 FirstWrite 0}
		c {Type IO LastRead 0 FirstWrite 0}
		table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}
		table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}
		table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}}
	LSTM_Pipeline_INIT {
		h {Type O LastRead -1 FirstWrite 0}
		c {Type O LastRead -1 FirstWrite 0}}
	LSTM_step {
		W_f {Type I LastRead 16 FirstWrite -1}
		U_f {Type I LastRead 16 FirstWrite -1}
		b_f {Type I LastRead 0 FirstWrite -1}
		W_i {Type I LastRead 16 FirstWrite -1}
		U_i {Type I LastRead 16 FirstWrite -1}
		b_i {Type I LastRead 0 FirstWrite -1}
		W_g {Type I LastRead 16 FirstWrite -1}
		U_g {Type I LastRead 16 FirstWrite -1}
		b_g {Type I LastRead 0 FirstWrite -1}
		W_o {Type I LastRead 16 FirstWrite -1}
		U_o {Type I LastRead 16 FirstWrite -1}
		b_o {Type I LastRead 0 FirstWrite -1}
		x {Type I LastRead 16 FirstWrite -1}
		x1 {Type I LastRead 0 FirstWrite -1}
		h {Type IO LastRead 16 FirstWrite 76}
		c {Type IO LastRead 0 FirstWrite 11}
		table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}
		table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}
		table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}}
	LSTM_step_Pipeline_GATES {
		W_f {Type I LastRead 16 FirstWrite -1}
		U_f {Type I LastRead 16 FirstWrite -1}
		W_i {Type I LastRead 16 FirstWrite -1}
		U_i {Type I LastRead 16 FirstWrite -1}
		W_g {Type I LastRead 16 FirstWrite -1}
		U_g {Type I LastRead 16 FirstWrite -1}
		W_o {Type I LastRead 16 FirstWrite -1}
		U_o {Type I LastRead 16 FirstWrite -1}
		b_f {Type I LastRead 0 FirstWrite -1}
		empty_35 {Type I LastRead 0 FirstWrite -1}
		empty_36 {Type I LastRead 0 FirstWrite -1}
		empty_37 {Type I LastRead 0 FirstWrite -1}
		empty_38 {Type I LastRead 0 FirstWrite -1}
		empty_39 {Type I LastRead 0 FirstWrite -1}
		empty_40 {Type I LastRead 0 FirstWrite -1}
		empty_41 {Type I LastRead 0 FirstWrite -1}
		empty_42 {Type I LastRead 0 FirstWrite -1}
		empty_43 {Type I LastRead 0 FirstWrite -1}
		empty_44 {Type I LastRead 0 FirstWrite -1}
		empty_45 {Type I LastRead 0 FirstWrite -1}
		empty_46 {Type I LastRead 0 FirstWrite -1}
		empty_47 {Type I LastRead 0 FirstWrite -1}
		empty_48 {Type I LastRead 0 FirstWrite -1}
		empty_49 {Type I LastRead 0 FirstWrite -1}
		empty_50 {Type I LastRead 0 FirstWrite -1}
		empty_51 {Type I LastRead 0 FirstWrite -1}
		empty_52 {Type I LastRead 0 FirstWrite -1}
		empty_53 {Type I LastRead 0 FirstWrite -1}
		empty_54 {Type I LastRead 0 FirstWrite -1}
		empty_55 {Type I LastRead 0 FirstWrite -1}
		empty_56 {Type I LastRead 0 FirstWrite -1}
		empty_57 {Type I LastRead 0 FirstWrite -1}
		empty_58 {Type I LastRead 0 FirstWrite -1}
		empty_59 {Type I LastRead 0 FirstWrite -1}
		empty_60 {Type I LastRead 0 FirstWrite -1}
		empty_61 {Type I LastRead 0 FirstWrite -1}
		empty_62 {Type I LastRead 0 FirstWrite -1}
		empty_63 {Type I LastRead 0 FirstWrite -1}
		empty_64 {Type I LastRead 0 FirstWrite -1}
		empty_65 {Type I LastRead 0 FirstWrite -1}
		empty_66 {Type I LastRead 0 FirstWrite -1}
		empty_67 {Type I LastRead 0 FirstWrite -1}
		empty_68 {Type I LastRead 0 FirstWrite -1}
		empty_69 {Type I LastRead 0 FirstWrite -1}
		empty_70 {Type I LastRead 0 FirstWrite -1}
		empty_71 {Type I LastRead 0 FirstWrite -1}
		empty_72 {Type I LastRead 0 FirstWrite -1}
		empty_73 {Type I LastRead 0 FirstWrite -1}
		empty_74 {Type I LastRead 0 FirstWrite -1}
		empty_75 {Type I LastRead 0 FirstWrite -1}
		empty_76 {Type I LastRead 0 FirstWrite -1}
		empty_77 {Type I LastRead 0 FirstWrite -1}
		empty_78 {Type I LastRead 0 FirstWrite -1}
		empty_79 {Type I LastRead 0 FirstWrite -1}
		empty_80 {Type I LastRead 0 FirstWrite -1}
		empty_81 {Type I LastRead 0 FirstWrite -1}
		empty_82 {Type I LastRead 0 FirstWrite -1}
		empty_83 {Type I LastRead 0 FirstWrite -1}
		empty_84 {Type I LastRead 0 FirstWrite -1}
		empty_85 {Type I LastRead 0 FirstWrite -1}
		empty_86 {Type I LastRead 0 FirstWrite -1}
		empty_87 {Type I LastRead 0 FirstWrite -1}
		empty_88 {Type I LastRead 0 FirstWrite -1}
		empty_89 {Type I LastRead 0 FirstWrite -1}
		empty_90 {Type I LastRead 0 FirstWrite -1}
		empty_91 {Type I LastRead 0 FirstWrite -1}
		empty_92 {Type I LastRead 0 FirstWrite -1}
		empty_93 {Type I LastRead 0 FirstWrite -1}
		empty_94 {Type I LastRead 0 FirstWrite -1}
		empty_95 {Type I LastRead 0 FirstWrite -1}
		empty_96 {Type I LastRead 0 FirstWrite -1}
		empty_97 {Type I LastRead 0 FirstWrite -1}
		empty {Type I LastRead 0 FirstWrite -1}
		f {Type O LastRead -1 FirstWrite 352}
		b_i {Type I LastRead 0 FirstWrite -1}
		i {Type O LastRead -1 FirstWrite 353}
		b_g {Type I LastRead 0 FirstWrite -1}
		g {Type O LastRead -1 FirstWrite 386}
		b_o {Type I LastRead 0 FirstWrite -1}
		o {Type O LastRead -1 FirstWrite 354}
		table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}
		table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}
		table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}}
	LSTM_step_Pipeline_UPDATE {
		f {Type I LastRead 0 FirstWrite -1}
		c {Type IO LastRead 0 FirstWrite 11}
		i {Type I LastRead 0 FirstWrite -1}
		g {Type I LastRead 0 FirstWrite -1}
		o {Type I LastRead 70 FirstWrite -1}
		h {Type O LastRead -1 FirstWrite 76}
		table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}
		table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}
		table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}}
	generic_tanh_float_s {
		t_in {Type I LastRead 0 FirstWrite -1}
		table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}
		table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}
		table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}}
	exp_generic_double_s {
		x {Type I LastRead 0 FirstWrite -1}
		table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}
		table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}
		table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "8148", "Max" : "8148"}
	, {"Name" : "Interval", "Min" : "8149", "Max" : "8149"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	W_f { ap_memory {  { W_f_address0 mem_address 1 10 }  { W_f_ce0 mem_ce 1 1 }  { W_f_q0 mem_dout 0 32 }  { W_f_address1 MemPortADDR2 1 10 }  { W_f_ce1 MemPortCE2 1 1 }  { W_f_q1 MemPortDOUT2 0 32 } } }
	U_f { ap_memory {  { U_f_address0 mem_address 1 10 }  { U_f_ce0 mem_ce 1 1 }  { U_f_q0 mem_dout 0 32 }  { U_f_address1 MemPortADDR2 1 10 }  { U_f_ce1 MemPortCE2 1 1 }  { U_f_q1 MemPortDOUT2 0 32 } } }
	b_f { ap_memory {  { b_f_address0 mem_address 1 5 }  { b_f_ce0 mem_ce 1 1 }  { b_f_q0 mem_dout 0 32 } } }
	W_i { ap_memory {  { W_i_address0 mem_address 1 10 }  { W_i_ce0 mem_ce 1 1 }  { W_i_q0 mem_dout 0 32 }  { W_i_address1 MemPortADDR2 1 10 }  { W_i_ce1 MemPortCE2 1 1 }  { W_i_q1 MemPortDOUT2 0 32 } } }
	U_i { ap_memory {  { U_i_address0 mem_address 1 10 }  { U_i_ce0 mem_ce 1 1 }  { U_i_q0 mem_dout 0 32 }  { U_i_address1 MemPortADDR2 1 10 }  { U_i_ce1 MemPortCE2 1 1 }  { U_i_q1 MemPortDOUT2 0 32 } } }
	b_i { ap_memory {  { b_i_address0 mem_address 1 5 }  { b_i_ce0 mem_ce 1 1 }  { b_i_q0 mem_dout 0 32 } } }
	W_g { ap_memory {  { W_g_address0 mem_address 1 10 }  { W_g_ce0 mem_ce 1 1 }  { W_g_q0 mem_dout 0 32 }  { W_g_address1 MemPortADDR2 1 10 }  { W_g_ce1 MemPortCE2 1 1 }  { W_g_q1 MemPortDOUT2 0 32 } } }
	U_g { ap_memory {  { U_g_address0 mem_address 1 10 }  { U_g_ce0 mem_ce 1 1 }  { U_g_q0 mem_dout 0 32 }  { U_g_address1 MemPortADDR2 1 10 }  { U_g_ce1 MemPortCE2 1 1 }  { U_g_q1 MemPortDOUT2 0 32 } } }
	b_g { ap_memory {  { b_g_address0 mem_address 1 5 }  { b_g_ce0 mem_ce 1 1 }  { b_g_q0 mem_dout 0 32 } } }
	W_o { ap_memory {  { W_o_address0 mem_address 1 10 }  { W_o_ce0 mem_ce 1 1 }  { W_o_q0 mem_dout 0 32 }  { W_o_address1 MemPortADDR2 1 10 }  { W_o_ce1 MemPortCE2 1 1 }  { W_o_q1 MemPortDOUT2 0 32 } } }
	U_o { ap_memory {  { U_o_address0 mem_address 1 10 }  { U_o_ce0 mem_ce 1 1 }  { U_o_q0 mem_dout 0 32 }  { U_o_address1 MemPortADDR2 1 10 }  { U_o_ce1 MemPortCE2 1 1 }  { U_o_q1 MemPortDOUT2 0 32 } } }
	b_o { ap_memory {  { b_o_address0 mem_address 1 5 }  { b_o_ce0 mem_ce 1 1 }  { b_o_q0 mem_dout 0 32 } } }
	x { ap_memory {  { x_address0 mem_address 1 8 }  { x_ce0 mem_ce 1 1 }  { x_q0 mem_dout 0 32 }  { x_address1 MemPortADDR2 1 8 }  { x_ce1 MemPortCE2 1 1 }  { x_q1 MemPortDOUT2 0 32 } } }
	h { ap_memory {  { h_address0 mem_address 1 5 }  { h_ce0 mem_ce 1 1 }  { h_we0 mem_we 1 1 }  { h_d0 mem_din 1 32 }  { h_q0 mem_dout 0 32 }  { h_address1 MemPortADDR2 1 5 }  { h_ce1 MemPortCE2 1 1 }  { h_q1 MemPortDOUT2 0 32 } } }
	c { ap_memory {  { c_address0 mem_address 1 5 }  { c_ce0 mem_ce 1 1 }  { c_we0 mem_we 1 1 }  { c_d0 mem_din 1 32 }  { c_address1 MemPortADDR2 1 5 }  { c_ce1 MemPortCE2 1 1 }  { c_q1 MemPortDOUT2 0 32 } } }
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
