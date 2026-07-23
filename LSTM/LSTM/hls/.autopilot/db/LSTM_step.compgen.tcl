# This script segment is generated automatically by AutoPilot

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler LSTM_LSTM_step_f_RAM_AUTO_1R1W BINDTYPE {storage} TYPE {ram} IMPL {auto} LATENCY 2 ALLOW_PRAGMA 1
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 170 \
    name W_f \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename W_f \
    op interface \
    ports { W_f_address0 { O 10 vector } W_f_ce0 { O 1 bit } W_f_q0 { I 32 vector } W_f_address1 { O 10 vector } W_f_ce1 { O 1 bit } W_f_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'W_f'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 171 \
    name U_f \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename U_f \
    op interface \
    ports { U_f_address0 { O 10 vector } U_f_ce0 { O 1 bit } U_f_q0 { I 32 vector } U_f_address1 { O 10 vector } U_f_ce1 { O 1 bit } U_f_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'U_f'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 172 \
    name b_f \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename b_f \
    op interface \
    ports { b_f_address0 { O 5 vector } b_f_ce0 { O 1 bit } b_f_q0 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'b_f'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 173 \
    name W_i \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename W_i \
    op interface \
    ports { W_i_address0 { O 10 vector } W_i_ce0 { O 1 bit } W_i_q0 { I 32 vector } W_i_address1 { O 10 vector } W_i_ce1 { O 1 bit } W_i_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'W_i'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 174 \
    name U_i \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename U_i \
    op interface \
    ports { U_i_address0 { O 10 vector } U_i_ce0 { O 1 bit } U_i_q0 { I 32 vector } U_i_address1 { O 10 vector } U_i_ce1 { O 1 bit } U_i_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'U_i'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 175 \
    name b_i \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename b_i \
    op interface \
    ports { b_i_address0 { O 5 vector } b_i_ce0 { O 1 bit } b_i_q0 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'b_i'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 176 \
    name W_g \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename W_g \
    op interface \
    ports { W_g_address0 { O 10 vector } W_g_ce0 { O 1 bit } W_g_q0 { I 32 vector } W_g_address1 { O 10 vector } W_g_ce1 { O 1 bit } W_g_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'W_g'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 177 \
    name U_g \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename U_g \
    op interface \
    ports { U_g_address0 { O 10 vector } U_g_ce0 { O 1 bit } U_g_q0 { I 32 vector } U_g_address1 { O 10 vector } U_g_ce1 { O 1 bit } U_g_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'U_g'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 178 \
    name b_g \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename b_g \
    op interface \
    ports { b_g_address0 { O 5 vector } b_g_ce0 { O 1 bit } b_g_q0 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'b_g'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 179 \
    name W_o \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename W_o \
    op interface \
    ports { W_o_address0 { O 10 vector } W_o_ce0 { O 1 bit } W_o_q0 { I 32 vector } W_o_address1 { O 10 vector } W_o_ce1 { O 1 bit } W_o_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'W_o'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 180 \
    name U_o \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename U_o \
    op interface \
    ports { U_o_address0 { O 10 vector } U_o_ce0 { O 1 bit } U_o_q0 { I 32 vector } U_o_address1 { O 10 vector } U_o_ce1 { O 1 bit } U_o_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'U_o'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 181 \
    name b_o \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename b_o \
    op interface \
    ports { b_o_address0 { O 5 vector } b_o_ce0 { O 1 bit } b_o_q0 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'b_o'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 182 \
    name x \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename x \
    op interface \
    ports { x_address0 { O 8 vector } x_ce0 { O 1 bit } x_q0 { I 32 vector } x_address1 { O 8 vector } x_ce1 { O 1 bit } x_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'x'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 184 \
    name h \
    reset_level 1 \
    sync_rst true \
    dir IO \
    corename h \
    op interface \
    ports { h_address0 { O 5 vector } h_ce0 { O 1 bit } h_we0 { O 1 bit } h_d0 { O 32 vector } h_q0 { I 32 vector } h_address1 { O 5 vector } h_ce1 { O 1 bit } h_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'h'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 185 \
    name c \
    reset_level 1 \
    sync_rst true \
    dir IO \
    corename c \
    op interface \
    ports { c_address0 { O 5 vector } c_ce0 { O 1 bit } c_we0 { O 1 bit } c_d0 { O 32 vector } c_address1 { O 5 vector } c_ce1 { O 1 bit } c_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'c'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 183 \
    name x1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_x1 \
    op interface \
    ports { x1 { I 3 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


