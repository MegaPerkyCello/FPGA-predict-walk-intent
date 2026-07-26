# Vivado — Block Design & Bitstream

Scripts that build the Vivado project containing the FootDrop inference IP, targeting
the Red Pitaya's Zynq-7020. **These scripts are the source of truth; the Vivado project
directory is a build artifact** — the same discipline as [`../HLS`](../HLS), where
`.cpp` + `hls_config.cfg` are tracked and the nested build folder is not.

| File | What it does |
|---|---|
| `create_project.tcl` | Creates the project, sets the part and board, points the IP catalog at the packaged HLS IP, builds the block design, generates the HDL wrapper |
| `bd/footdrop_bd.tcl` | Builds the block design itself — the PS7, the inference IP, the stimulus GPIO, and the AXI plumbing |
| `build_bitstream.tcl` | Runs implementation, checks post-route timing, emits the `.bit` / `.hwh` pair for PYNQ |
| `export_bd.tcl` | Dumps the current block design back to Tcl so GUI edits can be folded into `bd/footdrop_bd.tcl` |
| `board_files/` | Vendored `redpitaya-125-14-z20` board definition — **do not delete**, see below |

## ⚠ Board file: z20, not the base 125-14

This board is a **STEMlab 125-14 Pro (xc7z020)**. Vivado installs only the base
`redpitaya-125-14` board file, which targets **xc7z010** — and `set_property board_part`
*overrides* the `-part` given to `create_project`. Selecting the wrong one silently
retargets the entire design to a 7010 with no warning.

The correct board file is **vendored into this repo** at
`board_files/redpitaya-125-14-z20/1.0/` (from
[dspsandbox/FPGA-Notes-for-Scientists](https://github.com/dspsandbox/FPGA-Notes-for-Scientists))
rather than depending on what happens to be installed, `create_project.tcl` points
`board.repoPaths` at it, and it **verifies the resulting device is xc7z020** and aborts if
not. This already went wrong once; the check costs one line.

## Prerequisite: the HLS IP must be current

The block design instantiates `xilinx.com:hls:inference_stream:1.0` from
`../HLS/inference/inference/hls/impl/ip`. That folder is **gitignored build output**, so a
fresh clone will not have it.

In Vitis, on the `inference` component: run **C Synthesis**, then **Package**.

Vitis packages
whatever was last *synthesized*, not whatever `hls_config.cfg` currently says — so after
changing `syn.top` you can package a perfectly valid-looking IP that is actually the
previous design, with different ports. `create_project.tcl` guards against this: it
aborts if `inference_stream.v` is missing from the package rather than letting you
discover it during connection automation.

## Running the scripts

**Headless** — no GUI, good for rebuilds and CI:

```
cd C:/Users/cocol/Ruby_Proj/workspace
vivado -mode batch -source Vivado/create_project.tcl
vivado -mode batch -source Vivado/build_bitstream.tcl
```

Both accept the project location as an argument, defaulting to `C:/fdv`:

```
vivado -mode batch -source Vivado/create_project.tcl -tclargs C:/somewhere/short
```

**From the GUI** — open Vivado, then use the **Tcl Console** at the bottom of the window:

```tcl
cd C:/Users/cocol/Ruby_Proj/workspace
source Vivado/create_project.tcl
```

Vivado builds the project in front of you and opens it. `cd` first — the script locates
the repo from its own path, but sourcing from the right directory keeps everything
predictable. From there, open the block design in the GUI to inspect or edit it normally.

**Interactive, no GUI:** `vivado -mode tcl`, then `source ...`. Add `start_gui` at the end
of a batch script to open the GUI on the finished project.

## How a block design becomes a Tcl script

A `.bd` file is a graph: IP instances, their parameter settings, and the nets between
them. Vivado serializes that graph to Tcl, and re-running the Tcl rebuilds it exactly.
Nearly all of `bd/footdrop_bd.tcl` is four commands:

```tcl
create_bd_cell -type ip -vlnv xilinx.com:hls:inference_stream:1.0 inference_stream_0
set_property -dict [list CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {50}] $ps7
connect_bd_net      [get_bd_pins slice_emg/Dout] [get_bd_pins inference_stream_0/emg_sample]
connect_bd_intf_net [get_bd_intf_pins ps7/M_AXI_GP0] [get_bd_intf_pins .../s_axi_ctrl]
```

plus `apply_bd_automation`, which does the tedious parts: applying the board preset to the
PS7 (DDR3 timings, MIO assignments, clocks) and inserting the AXI interconnect and reset
logic.

### Round-tripping GUI edits

If you change the design in the GUI, export it back — otherwise the change lives only in
the untracked project directory and is lost on the next rebuild. Use `export_bd.tcl`:

```tcl
cd C:/Users/cocol/Ruby_Proj/workspace
source Vivado/export_bd.tcl
```

It writes `bd/_exported_bd.tcl` — deliberately **not** over `footdrop_bd.tcl`. Then diff
and port the changes across:

```
git diff --no-index Vivado/bd/footdrop_bd.tcl Vivado/bd/_exported_bd.tcl
```

The reason for the two-file dance is that `write_bd_tcl` emits machine-generated Tcl:
correct, but ~5× longer (578 lines versus 119 here), wrapped in procs, and carrying none
of the comments explaining *why* the design is as it is — the 50 MHz choice, the
`ap_start` exactly-once semantics, the `intc_ip {Auto}` trap, the board-file hazard.
Overwriting the curated file trades all of that for a diff. `_exported_bd.tcl` is
gitignored scratch.

To re-export the whole project (sources, IP paths, run settings) rather than just the
block design:

```tcl
write_project_tcl -force -no_copy_sources -use_bd_files <path>
```

Don't point that at `create_project.tcl` — it would discard the stale-IP guard, the
device check, and the board-repo setup. Hand-edit `create_project.tcl` when project
settings change.

> ⚠ **Keep the project path short.** Vivado implementation plus IP Integrator generate very
> deep paths, and Windows still enforces a 260-character limit. Cosim in this project already
> failed on it once. `C:/fdv` is deliberately short; do not build inside the repo.

## Build results (post-route, xc7z020, 50 MHz)

| Resource | Used | Available | % |
|---|---:|---:|---:|
| Slice LUTs | 5,707 | 53,200 | 10.7 |
| Slice Registers | 4,683 | 106,400 | 4.4 |
| Block RAM Tile | 11 | 140 | 7.9 |
| DSPs | 49 | 220 | 22.3 |

**All user specified timing constraints are met. WNS = +10.137 ns, WHS = +0.036 ns.**

Against a 20 ns period, +10.1 ns of setup slack means the real critical path is ~9.9 ns —
the design would meet 100 MHz. It stays at 50 MHz anyway: inference takes 2.75 ms of a
10 ms budget, and a slower clock draws less power on a battery-powered device.

Roughly 90% of the fabric is free for the preprocessing filter chain.

## What this design does (v1 — bring-up)

```
PS7 ──AXI-Lite──▶ AXI GPIO ──▶ {emg_sample, gyro_sample, ap_start}
PS7 ──AXI-Lite──▶ inference_stream/s_axi_ctrl   (read logit + valid)
```

There is no ADC or preprocessing chain yet, and that is deliberate. This design lets the
**PS inject known windows — your golden vectors — and read back the logit**, reproducing
`inference_TB` on real silicon. Without that path, the first wrong classification in the
field leaves you guessing between the model, the preprocessing, and the accelerator.

### Address map (confirmed by `assign_bd_address`)

| Slave | Base |
|---|---|
| `inference_stream_0/s_axi_ctrl` | `0x4000_0000` |
| `gpio_stim/S_AXI` | `0x4001_0000` |

Absolute addresses the PS uses:

| Address | What |
|---|---|
| `0x4000_0010` | `logit` — low 16 bits are the `ap_fixed<16,6>` value: sign-extend from bit 15, scale by 2⁻¹⁰ |
| `0x4000_0014` | `logit_ctrl` — bit 0 = `logit_ap_vld` |
| `0x4001_0000` | GPIO ch1 data — packed `{gyro[31:16], emg[15:0]}` |
| `0x4001_0008` | GPIO ch2 data — bit 0 = `ap_start` |

(`0x4001_0004` and `0x4001_000C` are the GPIO direction registers; both channels are
configured all-outputs, so they can be left alone.)

Under PYNQ you would normally reach these through the overlay's IP dictionary rather than
raw addresses, but the offsets are what the register names resolve to.

The PS **polls** bit 0 of `0x14` and then reads `0x10`. No interrupt: `ap_done` is a
single-cycle pulse the GIC can miss unless latched through an AXI Interrupt Controller,
and at 100 Hz polling is trivially adequate.

**`ap_start` means "exactly one new sample has arrived"**, not merely "go compute" — the
IP shifts its 32-sample window on every invocation. Pulse it twice for one sample and the
window duplicates a sample; miss one and it drops a sample. Either desynchronizes the
window from the real signal silently, with no error, until 32 more samples flush it.

### Clock

`FCLK_CLK0` is **50 MHz**, not the 83.3 MHz that the 12 ns HLS target would permit. The
inference takes 137,585 cycles = 2.75 ms at 50 MHz against a 10 ms budget, so slowing down
costs nothing and gives Vivado room to route. C-synthesis reported 0.01 ns slack at 12 ns,
but that number means very little: **HLS schedules to fill whatever period it is given**, so
near-zero slack is the expected outcome at any target. Post-route timing from
`build_bitstream.tcl` is the only real arbiter. Raise the clock once that shows margin.

## What v2 needs

Replacing the GPIO stimulus with the real front end:

- **ADC interface** — `ip/Redpitaya-125-14-adc` from
  [dspsandbox/FPGA-Notes-for-Scientists](https://github.com/dspsandbox/FPGA-Notes-for-Scientists),
  which also supplies `sdc/redpitaya-125-14.xdc` (needed as soon as PL pins are used) and
  the `board_files` this project's board preset comes from. Add its IP path to
  `ip_repo_paths` in `create_project.tcl`.
- **Filter chain** — EMG: band-pass 20–350 Hz → notch 60/180/300 Hz → rectify → 40 Hz
  low-pass → decimate to 100 Hz. Gyro: 30 Hz low-pass → decimate. Notch *before* rectify.
- **Z-scoring** against the subject's quiet-standing baseline. The model was trained
  exclusively on normalized input; feeding it raw conditioned envelope puts it out of
  distribution and the reported F1 stops meaning anything.
- **Scaling** to `ap_fixed<16,6>`: the 16-bit integer is the real value × 2¹⁰.
- **A mux** selecting PL samples or PS-injected test samples, so golden-vector testing
  survives once the front end exists.
- **An overrun counter** on `ap_idle` low at strobe time. It should never fire at 2.75 ms
  compute against a 10 ms period — which is exactly why a counter proving it is worth more
  than the assumption.

The inference IP's own connections do not change between v1 and v2; only what drives
`emg_sample`, `gyro_sample`, and `ap_start`.
