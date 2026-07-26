# =============================================================================
# build_bitstream.tcl -- synthesis, implementation, bitstream, and the .bit/.hwh
# pair PYNQ needs. Run AFTER create_project.tcl.
#
#   vivado -mode batch -source Vivado/build_bitstream.tcl
#   vivado -mode batch -source Vivado/build_bitstream.tcl -tclargs C:/fdv
#
# Takes 10-40 minutes. Post-route timing here is the ONLY real arbiter of whether
# the design closes -- the HLS slack figure is not, because HLS schedules to fill
# whatever clock period it is given and so always reports near-zero slack.
# =============================================================================

set proj_dir  "C:/fdv"
set proj_name "footdrop"
set bd_name   "footdrop_bd"

if {[info exists argv] && [llength $argv] > 0} {
    set proj_dir [lindex $argv 0]
}

open_project "$proj_dir/$proj_name/$proj_name.xpr"

launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

if {[get_property PROGRESS [get_runs impl_1]] != "100%"} {
    puts "ERROR: implementation did not complete. See the run log."
    return -code error "impl_1 failed"
}

open_run impl_1

# --- timing: report it loudly, do not let it pass silently -------------------
set wns [get_property SLACK [get_timing_paths -delay_type max]]
set whs [get_property SLACK [get_timing_paths -delay_type min]]
puts ""
puts "=========================================================="
puts "POST-ROUTE TIMING   WNS = $wns ns   WHS = $whs ns"
if {$wns < 0 || $whs < 0} {
    puts "*** TIMING NOT MET ***"
    puts "Options, cheapest first:"
    puts "  1. Lower FCLK_CLK0 in Vivado/bd/footdrop_bd.tcl (currently 50 MHz)."
    puts "     Latency budget is 10 ms and the design needs ~2.75 ms at 50 MHz,"
    puts "     so there is a lot of room to slow down."
    puts "  2. Raise the HLS clock target and re-synthesize the IP."
} else {
    puts "timing met"
}
puts "=========================================================="

report_utilization -file "$proj_dir/utilization.rpt"
report_timing_summary -file "$proj_dir/timing.rpt"

# --- artifacts for PYNQ ------------------------------------------------------
# PYNQ wants a .bit and a .hwh with IDENTICAL basenames, side by side.
set bit_src "$proj_dir/$proj_name/$proj_name.runs/impl_1/${bd_name}_wrapper.bit"
set hwh_src "$proj_dir/$proj_name/$proj_name.gen/sources_1/bd/${bd_name}/hw_handoff/${bd_name}.hwh"

file mkdir "$proj_dir/overlay"
if {[file exists $bit_src]} { file copy -force $bit_src "$proj_dir/overlay/footdrop.bit" } else { puts "WARNING: .bit not found at $bit_src" }
if {[file exists $hwh_src]} { file copy -force $hwh_src "$proj_dir/overlay/footdrop.hwh" } else { puts "WARNING: .hwh not found at $hwh_src" }

write_hw_platform -fixed -include_bit -force "$proj_dir/footdrop.xsa"

puts ""
puts "Overlay files -> $proj_dir/overlay/footdrop.{bit,hwh}"
puts "XSA           -> $proj_dir/footdrop.xsa"
puts "Copy the overlay pair to the Red Pitaya and load with pynq.Overlay()."
