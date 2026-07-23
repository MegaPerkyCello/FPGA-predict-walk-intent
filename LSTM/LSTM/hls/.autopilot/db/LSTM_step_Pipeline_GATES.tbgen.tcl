set moduleName LSTM_step_Pipeline_GATES
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
set C_modelName {LSTM_step_Pipeline_GATES}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict W_f { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict U_f { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict W_i { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict U_i { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict W_g { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict U_g { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict W_o { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict U_o { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict b_f { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict f { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict b_i { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict i { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict b_g { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict g { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict b_o { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict o { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
set C_modelArgList {
	{ W_f int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ U_f int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ W_i int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ U_i int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ W_g int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ U_g int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ W_o int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ U_o int 32 regular {array 1024 { 1 1 } 1 1 }  }
	{ b_f int 32 regular {array 32 { 1 3 } 1 1 }  }
	{ empty_35 float 32 regular  }
	{ empty_36 float 32 regular  }
	{ empty_37 float 32 regular  }
	{ empty_38 float 32 regular  }
	{ empty_39 float 32 regular  }
	{ empty_40 float 32 regular  }
	{ empty_41 float 32 regular  }
	{ empty_42 float 32 regular  }
	{ empty_43 float 32 regular  }
	{ empty_44 float 32 regular  }
	{ empty_45 float 32 regular  }
	{ empty_46 float 32 regular  }
	{ empty_47 float 32 regular  }
	{ empty_48 float 32 regular  }
	{ empty_49 float 32 regular  }
	{ empty_50 float 32 regular  }
	{ empty_51 float 32 regular  }
	{ empty_52 float 32 regular  }
	{ empty_53 float 32 regular  }
	{ empty_54 float 32 regular  }
	{ empty_55 float 32 regular  }
	{ empty_56 float 32 regular  }
	{ empty_57 float 32 regular  }
	{ empty_58 float 32 regular  }
	{ empty_59 float 32 regular  }
	{ empty_60 float 32 regular  }
	{ empty_61 float 32 regular  }
	{ empty_62 float 32 regular  }
	{ empty_63 float 32 regular  }
	{ empty_64 float 32 regular  }
	{ empty_65 float 32 regular  }
	{ empty_66 float 32 regular  }
	{ empty_67 float 32 regular  }
	{ empty_68 float 32 regular  }
	{ empty_69 float 32 regular  }
	{ empty_70 float 32 regular  }
	{ empty_71 float 32 regular  }
	{ empty_72 float 32 regular  }
	{ empty_73 float 32 regular  }
	{ empty_74 float 32 regular  }
	{ empty_75 float 32 regular  }
	{ empty_76 float 32 regular  }
	{ empty_77 float 32 regular  }
	{ empty_78 float 32 regular  }
	{ empty_79 float 32 regular  }
	{ empty_80 float 32 regular  }
	{ empty_81 float 32 regular  }
	{ empty_82 float 32 regular  }
	{ empty_83 float 32 regular  }
	{ empty_84 float 32 regular  }
	{ empty_85 float 32 regular  }
	{ empty_86 float 32 regular  }
	{ empty_87 float 32 regular  }
	{ empty_88 float 32 regular  }
	{ empty_89 float 32 regular  }
	{ empty_90 float 32 regular  }
	{ empty_91 float 32 regular  }
	{ empty_92 float 32 regular  }
	{ empty_93 float 32 regular  }
	{ empty_94 float 32 regular  }
	{ empty_95 float 32 regular  }
	{ empty_96 float 32 regular  }
	{ empty_97 float 32 regular  }
	{ empty float 32 regular  }
	{ f float 32 regular {array 32 { 0 3 } 0 1 }  }
	{ b_i int 32 regular {array 32 { 1 3 } 1 1 }  }
	{ i float 32 regular {array 32 { 0 3 } 0 1 }  }
	{ b_g int 32 regular {array 32 { 1 3 } 1 1 }  }
	{ g float 32 regular {array 32 { 0 3 } 0 1 }  }
	{ b_o int 32 regular {array 32 { 1 3 } 1 1 }  }
	{ o float 32 regular {array 32 { 0 3 } 0 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "W_f", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "U_f", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "W_i", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "U_i", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "W_g", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "U_g", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "W_o", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "U_o", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "b_f", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_35", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_36", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_37", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_38", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_39", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_40", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_41", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_42", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_43", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_44", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_45", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_46", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_47", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_48", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_49", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_50", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_51", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_52", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_53", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_54", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_55", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_56", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_57", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_58", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_59", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_60", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_61", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_62", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_63", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_64", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_65", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_66", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_67", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_68", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_69", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_70", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_71", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_72", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_73", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_74", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_75", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_76", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_77", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_78", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_79", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_80", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_81", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_82", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_83", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_84", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_85", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_86", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_87", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_88", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_89", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_90", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_91", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_92", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_93", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_94", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_95", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_96", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty_97", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "empty", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "f", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "b_i", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "i", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "b_g", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "g", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "b_o", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "o", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 165
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
	{ W_i_address0 sc_out sc_lv 10 signal 2 } 
	{ W_i_ce0 sc_out sc_logic 1 signal 2 } 
	{ W_i_q0 sc_in sc_lv 32 signal 2 } 
	{ W_i_address1 sc_out sc_lv 10 signal 2 } 
	{ W_i_ce1 sc_out sc_logic 1 signal 2 } 
	{ W_i_q1 sc_in sc_lv 32 signal 2 } 
	{ U_i_address0 sc_out sc_lv 10 signal 3 } 
	{ U_i_ce0 sc_out sc_logic 1 signal 3 } 
	{ U_i_q0 sc_in sc_lv 32 signal 3 } 
	{ U_i_address1 sc_out sc_lv 10 signal 3 } 
	{ U_i_ce1 sc_out sc_logic 1 signal 3 } 
	{ U_i_q1 sc_in sc_lv 32 signal 3 } 
	{ W_g_address0 sc_out sc_lv 10 signal 4 } 
	{ W_g_ce0 sc_out sc_logic 1 signal 4 } 
	{ W_g_q0 sc_in sc_lv 32 signal 4 } 
	{ W_g_address1 sc_out sc_lv 10 signal 4 } 
	{ W_g_ce1 sc_out sc_logic 1 signal 4 } 
	{ W_g_q1 sc_in sc_lv 32 signal 4 } 
	{ U_g_address0 sc_out sc_lv 10 signal 5 } 
	{ U_g_ce0 sc_out sc_logic 1 signal 5 } 
	{ U_g_q0 sc_in sc_lv 32 signal 5 } 
	{ U_g_address1 sc_out sc_lv 10 signal 5 } 
	{ U_g_ce1 sc_out sc_logic 1 signal 5 } 
	{ U_g_q1 sc_in sc_lv 32 signal 5 } 
	{ W_o_address0 sc_out sc_lv 10 signal 6 } 
	{ W_o_ce0 sc_out sc_logic 1 signal 6 } 
	{ W_o_q0 sc_in sc_lv 32 signal 6 } 
	{ W_o_address1 sc_out sc_lv 10 signal 6 } 
	{ W_o_ce1 sc_out sc_logic 1 signal 6 } 
	{ W_o_q1 sc_in sc_lv 32 signal 6 } 
	{ U_o_address0 sc_out sc_lv 10 signal 7 } 
	{ U_o_ce0 sc_out sc_logic 1 signal 7 } 
	{ U_o_q0 sc_in sc_lv 32 signal 7 } 
	{ U_o_address1 sc_out sc_lv 10 signal 7 } 
	{ U_o_ce1 sc_out sc_logic 1 signal 7 } 
	{ U_o_q1 sc_in sc_lv 32 signal 7 } 
	{ b_f_address0 sc_out sc_lv 5 signal 8 } 
	{ b_f_ce0 sc_out sc_logic 1 signal 8 } 
	{ b_f_q0 sc_in sc_lv 32 signal 8 } 
	{ empty_35 sc_in sc_lv 32 signal 9 } 
	{ empty_36 sc_in sc_lv 32 signal 10 } 
	{ empty_37 sc_in sc_lv 32 signal 11 } 
	{ empty_38 sc_in sc_lv 32 signal 12 } 
	{ empty_39 sc_in sc_lv 32 signal 13 } 
	{ empty_40 sc_in sc_lv 32 signal 14 } 
	{ empty_41 sc_in sc_lv 32 signal 15 } 
	{ empty_42 sc_in sc_lv 32 signal 16 } 
	{ empty_43 sc_in sc_lv 32 signal 17 } 
	{ empty_44 sc_in sc_lv 32 signal 18 } 
	{ empty_45 sc_in sc_lv 32 signal 19 } 
	{ empty_46 sc_in sc_lv 32 signal 20 } 
	{ empty_47 sc_in sc_lv 32 signal 21 } 
	{ empty_48 sc_in sc_lv 32 signal 22 } 
	{ empty_49 sc_in sc_lv 32 signal 23 } 
	{ empty_50 sc_in sc_lv 32 signal 24 } 
	{ empty_51 sc_in sc_lv 32 signal 25 } 
	{ empty_52 sc_in sc_lv 32 signal 26 } 
	{ empty_53 sc_in sc_lv 32 signal 27 } 
	{ empty_54 sc_in sc_lv 32 signal 28 } 
	{ empty_55 sc_in sc_lv 32 signal 29 } 
	{ empty_56 sc_in sc_lv 32 signal 30 } 
	{ empty_57 sc_in sc_lv 32 signal 31 } 
	{ empty_58 sc_in sc_lv 32 signal 32 } 
	{ empty_59 sc_in sc_lv 32 signal 33 } 
	{ empty_60 sc_in sc_lv 32 signal 34 } 
	{ empty_61 sc_in sc_lv 32 signal 35 } 
	{ empty_62 sc_in sc_lv 32 signal 36 } 
	{ empty_63 sc_in sc_lv 32 signal 37 } 
	{ empty_64 sc_in sc_lv 32 signal 38 } 
	{ empty_65 sc_in sc_lv 32 signal 39 } 
	{ empty_66 sc_in sc_lv 32 signal 40 } 
	{ empty_67 sc_in sc_lv 32 signal 41 } 
	{ empty_68 sc_in sc_lv 32 signal 42 } 
	{ empty_69 sc_in sc_lv 32 signal 43 } 
	{ empty_70 sc_in sc_lv 32 signal 44 } 
	{ empty_71 sc_in sc_lv 32 signal 45 } 
	{ empty_72 sc_in sc_lv 32 signal 46 } 
	{ empty_73 sc_in sc_lv 32 signal 47 } 
	{ empty_74 sc_in sc_lv 32 signal 48 } 
	{ empty_75 sc_in sc_lv 32 signal 49 } 
	{ empty_76 sc_in sc_lv 32 signal 50 } 
	{ empty_77 sc_in sc_lv 32 signal 51 } 
	{ empty_78 sc_in sc_lv 32 signal 52 } 
	{ empty_79 sc_in sc_lv 32 signal 53 } 
	{ empty_80 sc_in sc_lv 32 signal 54 } 
	{ empty_81 sc_in sc_lv 32 signal 55 } 
	{ empty_82 sc_in sc_lv 32 signal 56 } 
	{ empty_83 sc_in sc_lv 32 signal 57 } 
	{ empty_84 sc_in sc_lv 32 signal 58 } 
	{ empty_85 sc_in sc_lv 32 signal 59 } 
	{ empty_86 sc_in sc_lv 32 signal 60 } 
	{ empty_87 sc_in sc_lv 32 signal 61 } 
	{ empty_88 sc_in sc_lv 32 signal 62 } 
	{ empty_89 sc_in sc_lv 32 signal 63 } 
	{ empty_90 sc_in sc_lv 32 signal 64 } 
	{ empty_91 sc_in sc_lv 32 signal 65 } 
	{ empty_92 sc_in sc_lv 32 signal 66 } 
	{ empty_93 sc_in sc_lv 32 signal 67 } 
	{ empty_94 sc_in sc_lv 32 signal 68 } 
	{ empty_95 sc_in sc_lv 32 signal 69 } 
	{ empty_96 sc_in sc_lv 32 signal 70 } 
	{ empty_97 sc_in sc_lv 32 signal 71 } 
	{ empty sc_in sc_lv 32 signal 72 } 
	{ f_address0 sc_out sc_lv 5 signal 73 } 
	{ f_ce0 sc_out sc_logic 1 signal 73 } 
	{ f_we0 sc_out sc_logic 1 signal 73 } 
	{ f_d0 sc_out sc_lv 32 signal 73 } 
	{ b_i_address0 sc_out sc_lv 5 signal 74 } 
	{ b_i_ce0 sc_out sc_logic 1 signal 74 } 
	{ b_i_q0 sc_in sc_lv 32 signal 74 } 
	{ i_address0 sc_out sc_lv 5 signal 75 } 
	{ i_ce0 sc_out sc_logic 1 signal 75 } 
	{ i_we0 sc_out sc_logic 1 signal 75 } 
	{ i_d0 sc_out sc_lv 32 signal 75 } 
	{ b_g_address0 sc_out sc_lv 5 signal 76 } 
	{ b_g_ce0 sc_out sc_logic 1 signal 76 } 
	{ b_g_q0 sc_in sc_lv 32 signal 76 } 
	{ g_address0 sc_out sc_lv 5 signal 77 } 
	{ g_ce0 sc_out sc_logic 1 signal 77 } 
	{ g_we0 sc_out sc_logic 1 signal 77 } 
	{ g_d0 sc_out sc_lv 32 signal 77 } 
	{ b_o_address0 sc_out sc_lv 5 signal 78 } 
	{ b_o_ce0 sc_out sc_logic 1 signal 78 } 
	{ b_o_q0 sc_in sc_lv 32 signal 78 } 
	{ o_address0 sc_out sc_lv 5 signal 79 } 
	{ o_ce0 sc_out sc_logic 1 signal 79 } 
	{ o_we0 sc_out sc_logic 1 signal 79 } 
	{ o_d0 sc_out sc_lv 32 signal 79 } 
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
 	{ "name": "b_f_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "b_f", "role": "address0" }} , 
 	{ "name": "b_f_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_f", "role": "ce0" }} , 
 	{ "name": "b_f_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "b_f", "role": "q0" }} , 
 	{ "name": "empty_35", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_35", "role": "default" }} , 
 	{ "name": "empty_36", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_36", "role": "default" }} , 
 	{ "name": "empty_37", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_37", "role": "default" }} , 
 	{ "name": "empty_38", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_38", "role": "default" }} , 
 	{ "name": "empty_39", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_39", "role": "default" }} , 
 	{ "name": "empty_40", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_40", "role": "default" }} , 
 	{ "name": "empty_41", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_41", "role": "default" }} , 
 	{ "name": "empty_42", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_42", "role": "default" }} , 
 	{ "name": "empty_43", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_43", "role": "default" }} , 
 	{ "name": "empty_44", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_44", "role": "default" }} , 
 	{ "name": "empty_45", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_45", "role": "default" }} , 
 	{ "name": "empty_46", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_46", "role": "default" }} , 
 	{ "name": "empty_47", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_47", "role": "default" }} , 
 	{ "name": "empty_48", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_48", "role": "default" }} , 
 	{ "name": "empty_49", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_49", "role": "default" }} , 
 	{ "name": "empty_50", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_50", "role": "default" }} , 
 	{ "name": "empty_51", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_51", "role": "default" }} , 
 	{ "name": "empty_52", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_52", "role": "default" }} , 
 	{ "name": "empty_53", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_53", "role": "default" }} , 
 	{ "name": "empty_54", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_54", "role": "default" }} , 
 	{ "name": "empty_55", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_55", "role": "default" }} , 
 	{ "name": "empty_56", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_56", "role": "default" }} , 
 	{ "name": "empty_57", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_57", "role": "default" }} , 
 	{ "name": "empty_58", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_58", "role": "default" }} , 
 	{ "name": "empty_59", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_59", "role": "default" }} , 
 	{ "name": "empty_60", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_60", "role": "default" }} , 
 	{ "name": "empty_61", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_61", "role": "default" }} , 
 	{ "name": "empty_62", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_62", "role": "default" }} , 
 	{ "name": "empty_63", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_63", "role": "default" }} , 
 	{ "name": "empty_64", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_64", "role": "default" }} , 
 	{ "name": "empty_65", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_65", "role": "default" }} , 
 	{ "name": "empty_66", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_66", "role": "default" }} , 
 	{ "name": "empty_67", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_67", "role": "default" }} , 
 	{ "name": "empty_68", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_68", "role": "default" }} , 
 	{ "name": "empty_69", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_69", "role": "default" }} , 
 	{ "name": "empty_70", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_70", "role": "default" }} , 
 	{ "name": "empty_71", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_71", "role": "default" }} , 
 	{ "name": "empty_72", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_72", "role": "default" }} , 
 	{ "name": "empty_73", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_73", "role": "default" }} , 
 	{ "name": "empty_74", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_74", "role": "default" }} , 
 	{ "name": "empty_75", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_75", "role": "default" }} , 
 	{ "name": "empty_76", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_76", "role": "default" }} , 
 	{ "name": "empty_77", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_77", "role": "default" }} , 
 	{ "name": "empty_78", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_78", "role": "default" }} , 
 	{ "name": "empty_79", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_79", "role": "default" }} , 
 	{ "name": "empty_80", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_80", "role": "default" }} , 
 	{ "name": "empty_81", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_81", "role": "default" }} , 
 	{ "name": "empty_82", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_82", "role": "default" }} , 
 	{ "name": "empty_83", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_83", "role": "default" }} , 
 	{ "name": "empty_84", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_84", "role": "default" }} , 
 	{ "name": "empty_85", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_85", "role": "default" }} , 
 	{ "name": "empty_86", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_86", "role": "default" }} , 
 	{ "name": "empty_87", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_87", "role": "default" }} , 
 	{ "name": "empty_88", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_88", "role": "default" }} , 
 	{ "name": "empty_89", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_89", "role": "default" }} , 
 	{ "name": "empty_90", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_90", "role": "default" }} , 
 	{ "name": "empty_91", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_91", "role": "default" }} , 
 	{ "name": "empty_92", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_92", "role": "default" }} , 
 	{ "name": "empty_93", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_93", "role": "default" }} , 
 	{ "name": "empty_94", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_94", "role": "default" }} , 
 	{ "name": "empty_95", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_95", "role": "default" }} , 
 	{ "name": "empty_96", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_96", "role": "default" }} , 
 	{ "name": "empty_97", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty_97", "role": "default" }} , 
 	{ "name": "empty", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "empty", "role": "default" }} , 
 	{ "name": "f_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "f", "role": "address0" }} , 
 	{ "name": "f_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "f", "role": "ce0" }} , 
 	{ "name": "f_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "f", "role": "we0" }} , 
 	{ "name": "f_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "f", "role": "d0" }} , 
 	{ "name": "b_i_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "b_i", "role": "address0" }} , 
 	{ "name": "b_i_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_i", "role": "ce0" }} , 
 	{ "name": "b_i_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "b_i", "role": "q0" }} , 
 	{ "name": "i_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "i", "role": "address0" }} , 
 	{ "name": "i_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "i", "role": "ce0" }} , 
 	{ "name": "i_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "i", "role": "we0" }} , 
 	{ "name": "i_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "i", "role": "d0" }} , 
 	{ "name": "b_g_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "b_g", "role": "address0" }} , 
 	{ "name": "b_g_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_g", "role": "ce0" }} , 
 	{ "name": "b_g_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "b_g", "role": "q0" }} , 
 	{ "name": "g_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "g", "role": "address0" }} , 
 	{ "name": "g_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "g", "role": "ce0" }} , 
 	{ "name": "g_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "g", "role": "we0" }} , 
 	{ "name": "g_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "g", "role": "d0" }} , 
 	{ "name": "b_o_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "b_o", "role": "address0" }} , 
 	{ "name": "b_o_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_o", "role": "ce0" }} , 
 	{ "name": "b_o_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "b_o", "role": "q0" }} , 
 	{ "name": "o_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "o", "role": "address0" }} , 
 	{ "name": "o_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "o", "role": "ce0" }} , 
 	{ "name": "o_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "o", "role": "we0" }} , 
 	{ "name": "o_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "o", "role": "d0" }} , 
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
		table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array {Type I LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "884", "Max" : "884"}
	, {"Name" : "Interval", "Min" : "884", "Max" : "884"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	W_f { ap_memory {  { W_f_address0 mem_address 1 10 }  { W_f_ce0 mem_ce 1 1 }  { W_f_q0 mem_dout 0 32 }  { W_f_address1 MemPortADDR2 1 10 }  { W_f_ce1 MemPortCE2 1 1 }  { W_f_q1 MemPortDOUT2 0 32 } } }
	U_f { ap_memory {  { U_f_address0 mem_address 1 10 }  { U_f_ce0 mem_ce 1 1 }  { U_f_q0 mem_dout 0 32 }  { U_f_address1 MemPortADDR2 1 10 }  { U_f_ce1 MemPortCE2 1 1 }  { U_f_q1 MemPortDOUT2 0 32 } } }
	W_i { ap_memory {  { W_i_address0 mem_address 1 10 }  { W_i_ce0 mem_ce 1 1 }  { W_i_q0 mem_dout 0 32 }  { W_i_address1 MemPortADDR2 1 10 }  { W_i_ce1 MemPortCE2 1 1 }  { W_i_q1 MemPortDOUT2 0 32 } } }
	U_i { ap_memory {  { U_i_address0 mem_address 1 10 }  { U_i_ce0 mem_ce 1 1 }  { U_i_q0 mem_dout 0 32 }  { U_i_address1 MemPortADDR2 1 10 }  { U_i_ce1 MemPortCE2 1 1 }  { U_i_q1 MemPortDOUT2 0 32 } } }
	W_g { ap_memory {  { W_g_address0 mem_address 1 10 }  { W_g_ce0 mem_ce 1 1 }  { W_g_q0 mem_dout 0 32 }  { W_g_address1 MemPortADDR2 1 10 }  { W_g_ce1 MemPortCE2 1 1 }  { W_g_q1 MemPortDOUT2 0 32 } } }
	U_g { ap_memory {  { U_g_address0 mem_address 1 10 }  { U_g_ce0 mem_ce 1 1 }  { U_g_q0 mem_dout 0 32 }  { U_g_address1 MemPortADDR2 1 10 }  { U_g_ce1 MemPortCE2 1 1 }  { U_g_q1 MemPortDOUT2 0 32 } } }
	W_o { ap_memory {  { W_o_address0 mem_address 1 10 }  { W_o_ce0 mem_ce 1 1 }  { W_o_q0 mem_dout 0 32 }  { W_o_address1 MemPortADDR2 1 10 }  { W_o_ce1 MemPortCE2 1 1 }  { W_o_q1 MemPortDOUT2 0 32 } } }
	U_o { ap_memory {  { U_o_address0 mem_address 1 10 }  { U_o_ce0 mem_ce 1 1 }  { U_o_q0 mem_dout 0 32 }  { U_o_address1 MemPortADDR2 1 10 }  { U_o_ce1 MemPortCE2 1 1 }  { U_o_q1 MemPortDOUT2 0 32 } } }
	b_f { ap_memory {  { b_f_address0 mem_address 1 5 }  { b_f_ce0 mem_ce 1 1 }  { b_f_q0 mem_dout 0 32 } } }
	empty_35 { ap_none {  { empty_35 in_data 0 32 } } }
	empty_36 { ap_none {  { empty_36 in_data 0 32 } } }
	empty_37 { ap_none {  { empty_37 in_data 0 32 } } }
	empty_38 { ap_none {  { empty_38 in_data 0 32 } } }
	empty_39 { ap_none {  { empty_39 in_data 0 32 } } }
	empty_40 { ap_none {  { empty_40 in_data 0 32 } } }
	empty_41 { ap_none {  { empty_41 in_data 0 32 } } }
	empty_42 { ap_none {  { empty_42 in_data 0 32 } } }
	empty_43 { ap_none {  { empty_43 in_data 0 32 } } }
	empty_44 { ap_none {  { empty_44 in_data 0 32 } } }
	empty_45 { ap_none {  { empty_45 in_data 0 32 } } }
	empty_46 { ap_none {  { empty_46 in_data 0 32 } } }
	empty_47 { ap_none {  { empty_47 in_data 0 32 } } }
	empty_48 { ap_none {  { empty_48 in_data 0 32 } } }
	empty_49 { ap_none {  { empty_49 in_data 0 32 } } }
	empty_50 { ap_none {  { empty_50 in_data 0 32 } } }
	empty_51 { ap_none {  { empty_51 in_data 0 32 } } }
	empty_52 { ap_none {  { empty_52 in_data 0 32 } } }
	empty_53 { ap_none {  { empty_53 in_data 0 32 } } }
	empty_54 { ap_none {  { empty_54 in_data 0 32 } } }
	empty_55 { ap_none {  { empty_55 in_data 0 32 } } }
	empty_56 { ap_none {  { empty_56 in_data 0 32 } } }
	empty_57 { ap_none {  { empty_57 in_data 0 32 } } }
	empty_58 { ap_none {  { empty_58 in_data 0 32 } } }
	empty_59 { ap_none {  { empty_59 in_data 0 32 } } }
	empty_60 { ap_none {  { empty_60 in_data 0 32 } } }
	empty_61 { ap_none {  { empty_61 in_data 0 32 } } }
	empty_62 { ap_none {  { empty_62 in_data 0 32 } } }
	empty_63 { ap_none {  { empty_63 in_data 0 32 } } }
	empty_64 { ap_none {  { empty_64 in_data 0 32 } } }
	empty_65 { ap_none {  { empty_65 in_data 0 32 } } }
	empty_66 { ap_none {  { empty_66 in_data 0 32 } } }
	empty_67 { ap_none {  { empty_67 in_data 0 32 } } }
	empty_68 { ap_none {  { empty_68 in_data 0 32 } } }
	empty_69 { ap_none {  { empty_69 in_data 0 32 } } }
	empty_70 { ap_none {  { empty_70 in_data 0 32 } } }
	empty_71 { ap_none {  { empty_71 in_data 0 32 } } }
	empty_72 { ap_none {  { empty_72 in_data 0 32 } } }
	empty_73 { ap_none {  { empty_73 in_data 0 32 } } }
	empty_74 { ap_none {  { empty_74 in_data 0 32 } } }
	empty_75 { ap_none {  { empty_75 in_data 0 32 } } }
	empty_76 { ap_none {  { empty_76 in_data 0 32 } } }
	empty_77 { ap_none {  { empty_77 in_data 0 32 } } }
	empty_78 { ap_none {  { empty_78 in_data 0 32 } } }
	empty_79 { ap_none {  { empty_79 in_data 0 32 } } }
	empty_80 { ap_none {  { empty_80 in_data 0 32 } } }
	empty_81 { ap_none {  { empty_81 in_data 0 32 } } }
	empty_82 { ap_none {  { empty_82 in_data 0 32 } } }
	empty_83 { ap_none {  { empty_83 in_data 0 32 } } }
	empty_84 { ap_none {  { empty_84 in_data 0 32 } } }
	empty_85 { ap_none {  { empty_85 in_data 0 32 } } }
	empty_86 { ap_none {  { empty_86 in_data 0 32 } } }
	empty_87 { ap_none {  { empty_87 in_data 0 32 } } }
	empty_88 { ap_none {  { empty_88 in_data 0 32 } } }
	empty_89 { ap_none {  { empty_89 in_data 0 32 } } }
	empty_90 { ap_none {  { empty_90 in_data 0 32 } } }
	empty_91 { ap_none {  { empty_91 in_data 0 32 } } }
	empty_92 { ap_none {  { empty_92 in_data 0 32 } } }
	empty_93 { ap_none {  { empty_93 in_data 0 32 } } }
	empty_94 { ap_none {  { empty_94 in_data 0 32 } } }
	empty_95 { ap_none {  { empty_95 in_data 0 32 } } }
	empty_96 { ap_none {  { empty_96 in_data 0 32 } } }
	empty_97 { ap_none {  { empty_97 in_data 0 32 } } }
	empty { ap_none {  { empty in_data 0 32 } } }
	f { ap_memory {  { f_address0 mem_address 1 5 }  { f_ce0 mem_ce 1 1 }  { f_we0 mem_we 1 1 }  { f_d0 mem_din 1 32 } } }
	b_i { ap_memory {  { b_i_address0 mem_address 1 5 }  { b_i_ce0 mem_ce 1 1 }  { b_i_q0 mem_dout 0 32 } } }
	i { ap_memory {  { i_address0 mem_address 1 5 }  { i_ce0 mem_ce 1 1 }  { i_we0 mem_we 1 1 }  { i_d0 mem_din 1 32 } } }
	b_g { ap_memory {  { b_g_address0 mem_address 1 5 }  { b_g_ce0 mem_ce 1 1 }  { b_g_q0 mem_dout 0 32 } } }
	g { ap_memory {  { g_address0 mem_address 1 5 }  { g_ce0 mem_ce 1 1 }  { g_we0 mem_we 1 1 }  { g_d0 mem_din 1 32 } } }
	b_o { ap_memory {  { b_o_address0 mem_address 1 5 }  { b_o_ce0 mem_ce 1 1 }  { b_o_q0 mem_dout 0 32 } } }
	o { ap_memory {  { o_address0 mem_address 1 5 }  { o_ce0 mem_ce 1 1 }  { o_we0 mem_we 1 1 }  { o_d0 mem_din 1 32 } } }
}
