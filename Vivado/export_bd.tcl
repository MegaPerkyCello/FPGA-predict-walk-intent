# =============================================================================
# export_bd.tcl -- dump the CURRENT block design back out as Tcl, so edits made
# in the GUI can be folded into the tracked bd/footdrop_bd.tcl.
#
#   In the Vivado GUI Tcl Console, with the project open:
#       cd C:/Users/cocol/Ruby_Proj/workspace
#       source Vivado/export_bd.tcl
#
#   Headless against an existing project:
#       vivado -mode batch -source Vivado/export_bd.tcl -tclargs C:/fdv
#
# It writes to bd/_exported_bd.tcl -- deliberately NOT over footdrop_bd.tcl.
#
# Why not overwrite directly: write_bd_tcl emits machine-generated Tcl. It is
# correct but verbose, wraps everything in procs, and carries none of the
# comments explaining WHY the design is the way it is (the 50 MHz choice, the
# ap_start exactly-once semantics, the intc_ip {Auto} trap, the board-file
# hazard). Overwriting the curated file would trade all of that for a diff.
#
# The intended workflow is: export here, then diff _exported_bd.tcl against
# footdrop_bd.tcl and port the actual CHANGES into the curated file by hand.
# `git diff` on this file between exports shows exactly what the GUI edit did.
# =============================================================================

set proj_dir  "C:/fdv"
set proj_name "footdrop"

if {[info exists argv] && [llength $argv] > 0} {
    set proj_dir [lindex $argv 0]
}

set script_dir [file normalize [file dirname [info script]]]
set out "$script_dir/bd/_exported_bd.tcl"

# Open the project only if one is not already open (GUI console case).
if {[catch {current_project} _]} {
    open_project "$proj_dir/$proj_name/$proj_name.xpr"
}

set bd_files [get_files -quiet *.bd]
if {[llength $bd_files] == 0} {
    return -code error "no block design found in this project"
}
open_bd_design [lindex $bd_files 0]

write_bd_tcl -force $out

puts ""
puts "Exported block design -> $out"
puts ""
puts "Next: diff it against bd/footdrop_bd.tcl and port the changes across."
puts "  git diff --no-index Vivado/bd/footdrop_bd.tcl Vivado/bd/_exported_bd.tcl"
