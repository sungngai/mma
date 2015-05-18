transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/myverilog/mma_top1 {E:/myverilog/mma_top1/pingpong_wr.v}
vlog -vlog01compat -work work +incdir+E:/myverilog/mma_top1 {E:/myverilog/mma_top1/pingpong_fifo.v}
vlog -vlog01compat -work work +incdir+E:/myverilog/mma_top1 {E:/myverilog/mma_top1/input_sync.v}
vlog -vlog01compat -work work +incdir+E:/myverilog/mma_top1 {E:/myverilog/mma_top1/vga_controler.v}
vlog -vlog01compat -work work +incdir+E:/myverilog/mma_top1 {E:/myverilog/mma_top1/mma_top.v}
vlog -vlog01compat -work work +incdir+E:/myverilog/mma_top1 {E:/myverilog/mma_top1/pllnrst.v}
vlog -vlog01compat -work work +incdir+E:/myverilog/mma_top1 {E:/myverilog/mma_top1/pll.v}
vlog -vlog01compat -work work +incdir+E:/myverilog/mma_top1 {E:/myverilog/mma_top1/fifo1_1.v}
vlog -vlog01compat -work work +incdir+E:/myverilog/mma_top1 {E:/myverilog/mma_top1/fifo1_2.v}
vlog -vlog01compat -work work +incdir+E:/myverilog/mma_top1 {E:/myverilog/mma_top1/fifo2_1.v}
vlog -vlog01compat -work work +incdir+E:/myverilog/mma_top1 {E:/myverilog/mma_top1/fifo2_2.v}
vlog -vlog01compat -work work +incdir+E:/myverilog/mma_top1/db {E:/myverilog/mma_top1/db/pll_altpll.v}

vlog -vlog01compat -work work +incdir+E:/myverilog/mma_top1/simulation/modelsim {E:/myverilog/mma_top1/simulation/modelsim/mma_top.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc" mma_top_vlg_tst

add wave *
view structure
view signals
run -all
