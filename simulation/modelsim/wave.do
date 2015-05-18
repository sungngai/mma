onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /mma_top_vlg_tst/clk
add wave -noupdate -format Logic /mma_top_vlg_tst/rst_n
add wave -noupdate -format Logic /mma_top_vlg_tst/sysrst_n
add wave -noupdate -expand -group input -format Logic /mma_top_vlg_tst/oclk
add wave -noupdate -expand -group input -format Logic /mma_top_vlg_tst/mma_top_tb/input_sync_inst/hsync
add wave -noupdate -expand -group input -format Logic /mma_top_vlg_tst/mma_top_tb/input_sync_inst/vsync
add wave -noupdate -expand -group input -format Logic /mma_top_vlg_tst/mma_top_tb/input_sync_inst/de
add wave -noupdate -expand -group input -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/input_sync_inst/data
add wave -noupdate -divider {New Divider}
add wave -noupdate -group {input timing domain} -format Logic /mma_top_vlg_tst/oclk
add wave -noupdate -group {input timing domain} -format Literal /mma_top_vlg_tst/mma_top_tb/pingpong_wr_inst/cstate
add wave -noupdate -group {input timing domain} -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/pingpong_fifo_inst/data
add wave -noupdate -group {input timing domain} -format Logic /mma_top_vlg_tst/mma_top_tb/pingpong_fifo_inst/de1_1
add wave -noupdate -group {input timing domain} -format Logic /mma_top_vlg_tst/mma_top_tb/pingpong_fifo_inst/de1_2
add wave -noupdate -group {input timing domain} -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/pingpong_fifo_inst/data1_1
add wave -noupdate -group {input timing domain} -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/pingpong_fifo_inst/data1_2
add wave -noupdate -group {input timing domain} -format Logic /mma_top_vlg_tst/mma_top_tb/pingpong_fifo_inst/de2_1
add wave -noupdate -group {input timing domain} -format Logic /mma_top_vlg_tst/mma_top_tb/pingpong_fifo_inst/de2_2
add wave -noupdate -group {input timing domain} -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/pingpong_fifo_inst/data2_1
add wave -noupdate -group {input timing domain} -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/pingpong_fifo_inst/data2_2
add wave -noupdate -group {input timing domain} -format Logic /mma_top_vlg_tst/mma_top_tb/pingpong_fifo_inst/clr1
add wave -noupdate -group {input timing domain} -format Logic /mma_top_vlg_tst/mma_top_tb/pingpong_fifo_inst/clr2
add wave -noupdate -group {output timing domain} -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/pingpong_fifo_inst/q1_1
add wave -noupdate -group {output timing domain} -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/pingpong_fifo_inst/q1_2
add wave -noupdate -group {output timing domain} -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/pingpong_fifo_inst/q2_1
add wave -noupdate -group {output timing domain} -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/pingpong_fifo_inst/q2_2
add wave -noupdate -group output -format Logic /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/hsync_l
add wave -noupdate -group output -format Logic /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/vsync_l
add wave -noupdate -group output -format Logic /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/clkc0_24m
add wave -noupdate -group output -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/x_cnt
add wave -noupdate -group output -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/vga_l
add wave -noupdate -group output -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/vga_r
add wave -noupdate -group output -format Logic /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/blank_n_l
add wave -noupdate -group output -format Logic /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/blank_n_r
add wave -noupdate -format Logic /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/rdreq1
add wave -noupdate -format Logic /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/rdreq2
add wave -noupdate -format Logic /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/valid
add wave -noupdate -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/y_cnt
add wave -noupdate -format Logic /mma_top_vlg_tst/mma_top_tb/pingpong_wr_inst/wrreq1
add wave -noupdate -format Logic /mma_top_vlg_tst/mma_top_tb/pingpong_wr_inst/wrreq2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {614598322 ps} 0}
configure wave -namecolwidth 217
configure wave -valuecolwidth 45
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {357901764 ps}
