# =============================================================================
# footdrop_bd.tcl -- block design for the FootDrop AFO inference IP.
#
# Sourced by ../create_project.tcl. Can also be run on its own inside an already
# open project:   source Vivado/bd/footdrop_bd.tcl
#
# THIS IS THE BRING-UP DESIGN (v1). The PS drives everything:
#
#     PS7 --AXI-Lite--> AXI GPIO --> {emg_sample, gyro_sample, ap_start}
#     PS7 --AXI-Lite--> inference_stream/s_axi_ctrl  (read logit + valid flag)
#
# There is no ADC or preprocessing chain here yet, and that is deliberate. This
# design exists so the PS can INJECT known windows -- the golden vectors -- and
# read back the logit, i.e. reproduce inference_TB on real silicon. Without that
# path, the first wrong classification in the field leaves you guessing between
# the model, the preprocessing, and the accelerator.
#
# v2 replaces the AXI GPIO stimulus with the real PL front end: the ADC IP from
# dspsandbox/FPGA-Notes-for-Scientists -> filter chain -> z-scoring -> sample
# pair + 100 Hz strobe. The inference IP's connections do not change; only what
# drives emg_sample/gyro_sample/ap_start does. Keeping a mux between the two is
# what preserves golden-vector testing after the front end lands.
# =============================================================================

set bd_name "footdrop_bd"

create_bd_design $bd_name
current_bd_design $bd_name

# ---------------------------------------------------------------------------
# Zynq PS. The board preset supplies the DDR3 model, MIO assignments and clock
# tree -- roughly a hundred properties that are miserable to set by hand and
# brick the boot if wrong. This is why the redpitaya-125-14 board file matters.
# ---------------------------------------------------------------------------
set ps7 [create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7 ps7]
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 \
    -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable"} \
    $ps7

# FCLK_CLK0 = 50 MHz, NOT the 83.3 MHz the 12 ns HLS target would allow.
#
# Deliberately conservative: C-synthesis reported 0.01 ns slack at 12 ns, and
# slack that small is HLS having filled the period rather than a real margin
# measurement. At 50 MHz the design takes 137,585 x 20 ns = 2.75 ms against a
# 10 ms budget, so the cost is nothing and Vivado gets room to route.
# Raise it here once post-route timing shows real margin.
set_property -dict [list \
    CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {50} \
    CONFIG.PCW_USE_M_AXI_GP0 {1} \
] $ps7

# ---------------------------------------------------------------------------
# The inference accelerator.
# ---------------------------------------------------------------------------
set infer [create_bd_cell -type ip -vlnv xilinx.com:hls:inference_stream:1.0 inference_stream_0]

# ---------------------------------------------------------------------------
# Stimulus GPIO (bring-up only).
#   channel 1: 32 bits out = {gyro_sample[15:0], emg_sample[15:0]}
#   channel 2:  1 bit  out = ap_start
#
# ap_start means "exactly one new sample has arrived" -- the wrapper shifts its
# window on every invocation -- so PS-side code must pulse it once per sample,
# never twice, or the window desynchronizes silently.
# ---------------------------------------------------------------------------
set gpio [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio gpio_stim]
set_property -dict [list \
    CONFIG.C_GPIO_WIDTH {32}  CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_IS_DUAL {1} \
    CONFIG.C_GPIO2_WIDTH {1} CONFIG.C_ALL_OUTPUTS_2 {1} \
] $gpio

# Split the packed 32-bit word into the two 16-bit ap_fixed<16,6> samples.
set sl_emg [create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice slice_emg]
set_property -dict [list CONFIG.DIN_WIDTH {32} CONFIG.DIN_FROM {15} CONFIG.DIN_TO {0}  CONFIG.DOUT_WIDTH {16}] $sl_emg

set sl_gyro [create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice slice_gyro]
set_property -dict [list CONFIG.DIN_WIDTH {32} CONFIG.DIN_FROM {31} CONFIG.DIN_TO {16} CONFIG.DOUT_WIDTH {16}] $sl_gyro

connect_bd_net [get_bd_pins gpio_stim/gpio_io_o]  [get_bd_pins slice_emg/Din]
connect_bd_net [get_bd_pins gpio_stim/gpio_io_o]  [get_bd_pins slice_gyro/Din]
connect_bd_net [get_bd_pins slice_emg/Dout]       [get_bd_pins inference_stream_0/emg_sample]
connect_bd_net [get_bd_pins slice_gyro/Dout]      [get_bd_pins inference_stream_0/gyro_sample]
connect_bd_net [get_bd_pins gpio_stim/gpio2_io_o] [get_bd_pins inference_stream_0/ap_start]

# ---------------------------------------------------------------------------
# AXI plumbing. Automation creates the interconnect and proc_sys_reset, and
# hooks up ap_clk / ap_rst_n (associated with s_axi_ctrl) for us.
#
# ap_rst_n is SYNCHRONOUS ACTIVE LOW -- forced by the presence of the AXI port.
# The pre-wrapper build had active-high ap_rst; wiring that polarity backwards
# leaves the block held in reset with no other symptom.
# ---------------------------------------------------------------------------
# intc_ip {Auto} for BOTH, not a hardcoded interconnect name: Vivado picks its own
# name for the interconnect it creates (ps7_axi_periph here, not axi_interconnect_0),
# so naming it explicitly on the second call fails with "No block was found at ...".
# Auto creates one on the first call and reuses it on the second.
apply_bd_automation -rule xilinx.com:bd_rule:axi4 \
    -config [list Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} \
                  Master {/ps7/M_AXI_GP0} Slave {/inference_stream_0/s_axi_ctrl} \
                  ddr_seg {Auto} intc_ip {Auto} master_apm {0}] \
    [get_bd_intf_pins inference_stream_0/s_axi_ctrl]

apply_bd_automation -rule xilinx.com:bd_rule:axi4 \
    -config [list Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} \
                  Master {/ps7/M_AXI_GP0} Slave {/gpio_stim/S_AXI} \
                  ddr_seg {Auto} intc_ip {Auto} master_apm {0}] \
    [get_bd_intf_pins gpio_stim/S_AXI]

assign_bd_address

regenerate_bd_layout
validate_bd_design
save_bd_design

puts "footdrop_bd: created and validated."
puts "  PL clock : 50 MHz (FCLK_CLK0)"
puts "  Slaves   : inference_stream_0/s_axi_ctrl, gpio_stim/S_AXI"
puts "  Register map inside s_axi_ctrl: logit @0x10, logit_ctrl @0x14 (bit0 = valid)"
