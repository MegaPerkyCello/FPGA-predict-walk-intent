set ModuleHierarchy {[{
"Name" : "LSTM", "RefName" : "LSTM","ID" : "0","Type" : "sequential",
"SubInsts" : [
	{"Name" : "grp_LSTM_Pipeline_INIT_fu_76", "RefName" : "LSTM_Pipeline_INIT","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "INIT","RefName" : "INIT","ID" : "2","Type" : "pipeline"},]},],
"SubLoops" : [
	{"Name" : "TIME","RefName" : "TIME","ID" : "3","Type" : "no",
	"SubInsts" : [
	{"Name" : "grp_LSTM_step_fu_84", "RefName" : "LSTM_step","ID" : "4","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_LSTM_step_Pipeline_GATES_fu_768", "RefName" : "LSTM_step_Pipeline_GATES","ID" : "5","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "GATES","RefName" : "GATES","ID" : "6","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "generic_tanh_float_s", "RefName" : "generic_tanh_float_s","ID" : "7","Type" : "pipeline",
						"SubInsts" : [
						{"Name" : "grp_exp_generic_double_s_fu_89", "RefName" : "exp_generic_double_s","ID" : "8","Type" : "pipeline"},]},]},]},
			{"Name" : "grp_LSTM_step_Pipeline_UPDATE_fu_870", "RefName" : "LSTM_step_Pipeline_UPDATE","ID" : "9","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "UPDATE","RefName" : "UPDATE","ID" : "10","Type" : "pipeline",
				"SubInsts" : [
				{"Name" : "generic_tanh_float_s", "RefName" : "generic_tanh_float_s","ID" : "11","Type" : "pipeline",
						"SubInsts" : [
						{"Name" : "grp_exp_generic_double_s_fu_89", "RefName" : "exp_generic_double_s","ID" : "12","Type" : "pipeline"},]},]},]},]},]},]
}]}