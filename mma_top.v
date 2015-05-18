
/* 
copyright C.Y

Filename    : pllnrst.v
Compiler    : Quartus II 9.1
simulator	: ModelSim 6.5b
Description : mma(multi monitor adapter) 顶层模块
Release     : 
*/

module mma_top (
				//input
				clk,
				rst_n,
				oclk,
				hsync_in,
				vsync_in,
				de_in,
				data_in,
				//output
				led0,
				led1,
				
				vga_clk,
				hsync_l,
				vsync_l,
				blank_n_l,
				sync_n_l,
				vga_l,
				
				hsync_r,
				vsync_r,
				blank_n_r,
				sync_n_r,
				vga_r
				);
				
input clk;
input rst_n;
input oclk;
input hsync_in;
input vsync_in;
input de_in;
input [23:0] data_in;

output vga_clk;
output hsync_l;
output vsync_l;
output blank_n_l;
output sync_n_l;
output [23:0] vga_l;
output hsync_r;
output vsync_r;
output blank_n_r;
output sync_n_r;
output [23:0] vga_r;

output led0;
output led1;

wire clkc0_24m;
wire sysrst_n;
wire hsync_tmp;
wire vsync_tmp;
wire de_tmp;
wire [23:0] data_tmp;
wire fifo1_full;
wire fifo1_empty;
wire fifo2_full;
wire fifo2_empty;
wire wrreq1;
wire wrreq2;
wire rdreq1;
wire rdreq2;
wire clr1;
wire clr2;
wire [23:0] q1_1;
wire [23:0] q1_2;
wire [23:0] q2_1;
wire [23:0] q2_2;

pllnrst pllnrst_inst(
				//input
				.clk(clk),
				.rst_n(rst_n),
				//otuput 
				.clkc0_24m(clkc0_24m),
				.sysrst_n(sysrst_n)
				);
				
input_sync input_sync_inst(
				//input 
				.oclk(oclk),
				.sysrst_n(sysrst_n),
				.hsync_in(hsync_in),
				.vsync_in(vsync_in),
				.de_in(de_in),
				.data_in(data_in),
				//output
				.hsync(hsync_tmp),
				.vsync(vsync_tmp),
				.de(de_tmp),
				.data(data_tmp)
				);
				
pingpong_wr pingpong_wr_inst(
				//input
				.oclk(oclk),
				.sysrst_n(sysrst_n),
				.fifo1_full(fifo1_full),
				.fifo1_empty(fifo1_empty),
				.fifo2_full(fifo2_full),
				.fifo2_empty(fifo2_empty),
				.de(de_tmp),
				//output
				.led0(led0),
				.led1(led1),
				.clr1(clr1),
				.clr2(clr2),
				.wrreq1(wrreq1),
				.wrreq2(wrreq2)
				);
				
pingpong_fifo pingpong_fifo_inst(
				//input 
				.oclk(oclk),
				.clkc0_24m(clkc0_24m),
				.sysrst_n(sysrst_n),
				.de1(wrreq1),
				.de2(wrreq2),
				.rdreq1(rdreq1),
				.rdreq2(rdreq2),
				.data(data_tmp),
				.clr1(clr1),
				.clr2(clr2),
				//output
				.fifo1_full(fifo1_full),
				.fifo1_empty(fifo1_empty),
				.fifo2_full(fifo2_full),
				.fifo2_empty(fifo2_empty),
				.q1_1(q1_1),
				.q1_2(q1_2),
				.q2_1(q2_1),
				.q2_2(q2_2)
				);
				
vga_controler vga_controler_inst(
				//input
				.clkc0_24m(clkc0_24m),
				.sysrst_n(sysrst_n),
				.hsync_in(hsync_tmp),
				.vsync_in(vsync_tmp),
				.q1_1(q1_1),
				.q1_2(q1_2),
				.q2_1(q2_1),
				.q2_2(q2_2),
				.fifo1_full(fifo1_full),
				.fifo1_empty(fifo1_empty),
				.fifo2_full(fifo2_full),
				.fifo2_empty(fifo2_empty),
				
				//output
				.rdreq1(rdreq1),
				.rdreq2(rdreq2),
				/* .led0(led0),
				.led1(led1), */
				.vga_clk(vga_clk),
				.hsync_l(hsync_l),
				.vsync_l(vsync_l),
				.blank_n_l(blank_n_l),
				.sync_n_l(sync_n_l),
				.vga_l(vga_l),
				
				.hsync_r(hsync_r),
				.vsync_r(vsync_r),
				.blank_n_r(blank_n_r),
				.sync_n_r(sync_n_r),
				.vga_r(vga_r)
				);


endmodule



