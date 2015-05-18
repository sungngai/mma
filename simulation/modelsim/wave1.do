onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/clkc0_24m
add wave -noupdate -format Logic /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/hsync_in
add wave -noupdate -format Logic /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/hsync_neg
add wave -noupdate -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/x_cnt
add wave -noupdate -format Logic /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/hsync_l
add wave -noupdate -format Logic /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/vsync_in
add wave -noupdate -format Literal -radix unsigned /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/y_cnt
add wave -noupdate -format Logic /mma_top_vlg_tst/mma_top_tb/vga_controler_inst/vsync_l
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {22896000 ps} 0}
configure wave -namecolwidth 154
configure wave -valuecolwidth 100
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
WaveRestoreZoom {21336883 ps} {744420133 ps}
