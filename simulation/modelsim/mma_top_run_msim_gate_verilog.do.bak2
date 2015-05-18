transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {mma_top_8_1200mv_85c_slow.vo}

vlog -vlog01compat -work work +incdir+E:/myverilog/mma_top/simulation/modelsim {E:/myverilog/mma_top/simulation/modelsim/mma_top.vt}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneiii_ver -L gate_work -L work -voptargs="+acc" mma_top_vlg_tst

add wave *
view structure
view signals
run -all
