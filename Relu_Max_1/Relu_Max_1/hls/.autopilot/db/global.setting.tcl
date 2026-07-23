
set TopModule "relu_max_1"
set ClockPeriod 12
set ClockList ap_clk
set AxiliteClockList {}
set HasVivadoClockPeriod 0
set CombLogicFlag 0
set PipelineFlag 0
set DataflowTaskPipelineFlag 1
set TrivialPipelineFlag 0
set noPortSwitchingFlag 0
set FloatingPointFlag 1
set FftOrFirFlag 0
set NbRWValue 0
set intNbAccess 0
set NewDSPMapping 1
set HasDSPModule 0
set ResetLevelFlag 1
set ResetStyle control
set ResetSyncFlag 1
set ResetRegisterFlag 0
set ResetVariableFlag 0
set ResetRegisterNum 0
set FsmEncStyle onehot
set MaxFanout 0
set RtlPrefix {}
set RtlSubPrefix relu_max_1_
set ExtraCCFlags {}
set ExtraCLdFlags {}
set SynCheckOptions {}
set PresynOptions {}
set PreprocOptions {}
set SchedOptions {}
set BindOptions {}
set RtlGenOptions {}
set RtlWriterOptions {}
set CbcGenFlag {}
set CasGenFlag {}
set CasMonitorFlag {}
set AutoSimOptions {}
set ExportMCPathFlag 0
set SCTraceFileName mytrace
set SCTraceFileFormat vcd
set SCTraceOption all
set TargetInfo xc7z020:-clg400:-1
set SourceFiles {sc {} c ../../relu_max_1.cpp}
set SourceFlags {sc {} c -IC:/Users/cocol/Ruby_Proj/workspace/header}
set DirectiveFile {}
set TBFiles {verilog {C:/Users/cocol/Ruby_Proj/workspace/Relu_Max_1/pool1_goldens C:/Users/cocol/Ruby_Proj/workspace/Relu_Max_1/relu_max_1_TB.cpp} bc {C:/Users/cocol/Ruby_Proj/workspace/Relu_Max_1/pool1_goldens C:/Users/cocol/Ruby_Proj/workspace/Relu_Max_1/relu_max_1_TB.cpp} sc {C:/Users/cocol/Ruby_Proj/workspace/Relu_Max_1/pool1_goldens C:/Users/cocol/Ruby_Proj/workspace/Relu_Max_1/relu_max_1_TB.cpp} vhdl {C:/Users/cocol/Ruby_Proj/workspace/Relu_Max_1/pool1_goldens C:/Users/cocol/Ruby_Proj/workspace/Relu_Max_1/relu_max_1_TB.cpp} c {} cas {C:/Users/cocol/Ruby_Proj/workspace/Relu_Max_1/pool1_goldens C:/Users/cocol/Ruby_Proj/workspace/Relu_Max_1/relu_max_1_TB.cpp}}
set SpecLanguage C
set TVInFiles {bc {} c {} sc {} cas {} vhdl {} verilog {}}
set TVOutFiles {bc {} c {} sc {} cas {} vhdl {} verilog {}}
set TBTops {verilog {} bc {} sc {} vhdl {} c {} cas {}}
set TBInstNames {verilog {} bc {} sc {} vhdl {} c {} cas {}}
set XDCFiles {}
set ExtraGlobalOptions {"area_timing" 1 "clock_gate" 1 "impl_flow" map "power_gate" 0}
set TBTVFileNotFound {}
set AppFile {}
set ApsFile hls.aps
set AvePath ../../.
set DefaultPlatform DefaultPlatform
set multiClockList {}
set SCPortClockMap {}
set intNbAccess 0
set PlatformFiles {{DefaultPlatform {xilinx/zynq/zynq}}}
set HPFPO 0
