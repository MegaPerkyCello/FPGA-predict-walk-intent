# =============================================================================
# create_project.tcl -- recreates the FootDrop Vivado project from scratch.
#
# This script (plus bd/footdrop_bd.tcl) IS the source of truth. The generated
# project directory is a build artifact and is not tracked -- same discipline as
# the HLS components, where .cpp + hls_config.cfg are source and the nested
# build folder is regenerated.
#
#   Headless:  vivado -mode batch -source Vivado/create_project.tcl
#   With a custom project location:
#              vivado -mode batch -source Vivado/create_project.tcl -tclargs C:/fdv
#   In the GUI Tcl Console:
#              cd C:/Users/cocol/Ruby_Proj/workspace
#              source Vivado/create_project.tcl
#
# See README.md in this folder for the full workflow.
# =============================================================================

# --- where the project gets built -------------------------------------------
# OUTSIDE the repo, and SHORT. Vivado implementation plus IP Integrator generate
# very deep paths and Windows still enforces a 260-character limit; cosim in this
# project already hit it once from a long directory. Keep this short.
set proj_dir  "C:/fdv"
set proj_name "footdrop"

if {[info exists argv] && [llength $argv] > 0} {
    set proj_dir [lindex $argv 0]
}

# --- locate the repo from this script's own location -------------------------
set script_dir [file normalize [file dirname [info script]]]
set repo_root  [file normalize "$script_dir/.."]

set hls_ip_repo "$repo_root/HLS/inference/inference/hls/impl/ip"

puts "repo root     : $repo_root"
puts "project dir   : $proj_dir/$proj_name"
puts "HLS IP repo   : $hls_ip_repo"

# --- sanity-check the HLS IP before doing anything expensive -----------------
# The packaged IP lives in gitignored HLS build output, so a fresh clone will not
# have it: re-run C Synthesis then Package on the inference component first.
if {![file exists "$hls_ip_repo/component.xml"] } {
    puts "ERROR: no packaged HLS IP at $hls_ip_repo"
    puts "       In Vitis, run C SYNTHESIS then PACKAGE on the 'inference' component."
    return -code error "missing HLS IP"
}
# Guard against the stale-IP trap: Vitis packages whatever was last SYNTHESIZED,
# not whatever hls_config.cfg currently says, so an out-of-date package looks
# perfectly valid until its ports turn out to be the previous design's.
if {![file exists "$hls_ip_repo/hdl/verilog/inference_stream.v"]} {
    puts "ERROR: the packaged IP does not contain inference_stream.v -- it is STALE"
    puts "       (probably the older 'inference' top with an ap_memory window port)."
    puts "       Re-run C SYNTHESIS, then PACKAGE, on the inference component."
    return -code error "stale HLS IP"
}

# --- board files -------------------------------------------------------------
# Vendored in this repo (board_files/) rather than relying on what happens to be
# installed in Vivado, because the difference is NOT cosmetic:
#
#   redpitaya-125-14      -> xc7z010clg400-1   (STEMlab 125-14, base)
#   redpitaya-125-14-z20  -> xc7z020clg400-1   (STEMlab 125-14 Pro)  <-- this board
#
# Vivado ships/installs only the base one here, and `set_property board_part`
# OVERRIDES the -part given to create_project. So selecting the wrong board file
# silently retargets the whole design to a 7010 with no warning -- and the design
# is 28% LUT on a 7020 versus 85% on a 7010, i.e. the difference between
# comfortable and not fitting the system at all.
set_param board.repoPaths [list "$script_dir/board_files"]

# --- create the project ------------------------------------------------------
file mkdir $proj_dir
create_project $proj_name "$proj_dir/$proj_name" -part xc7z020clg400-1 -force
set_property board_part redpitaya.com:redpitaya-125-14-z20:part0:1.0 [current_project]

# Verify the board file did not retarget us. This exact failure already happened
# once; it costs one line to make it impossible to miss.
set dev [get_property PART [current_project]]
if {![string match "xc7z020*" $dev]} {
    puts "ERROR: project part is '$dev', expected xc7z020clg400-1."
    puts "       The board_part setting has overridden the target device."
    return -code error "wrong device: $dev"
}
puts "device        : $dev  (verified)"

# IP repository: where Vivado finds xilinx.com:hls:inference_stream:1.0.
# Add the dspsandbox Redpitaya-125-14-adc / -clk IP paths here too when the
# v2 front end lands.
set_property ip_repo_paths [list $hls_ip_repo] [current_project]
update_ip_catalog -rebuild

# --- block design ------------------------------------------------------------
source "$script_dir/bd/footdrop_bd.tcl"

# --- HDL wrapper, set as top -------------------------------------------------
set bd_file [get_files "${bd_name}.bd"]
make_wrapper -files $bd_file -top
add_files -norecurse "$proj_dir/$proj_name/${proj_name}.gen/sources_1/bd/${bd_name}/hdl/${bd_name}_wrapper.v"
set_property top "${bd_name}_wrapper" [current_fileset]
update_compile_order -fileset sources_1

puts ""
puts "=========================================================="
puts "Project created: $proj_dir/$proj_name/$proj_name.xpr"
puts ""
puts "Next:"
puts "  launch_runs impl_1 -to_step write_bitstream -jobs 4"
puts "  wait_on_run impl_1"
puts "  write_hw_platform -fixed -include_bit -force $proj_dir/footdrop.xsa"
puts ""
puts "No PL pin constraints are needed for this bring-up design -- it uses only"
puts "the PS7 (FIXED_IO/DDR come from the board preset). sdc/redpitaya-125-14.xdc"
puts "from the dspsandbox repo is required once the ADC front end is added."
puts "=========================================================="
