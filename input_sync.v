
/* 
copyright C.Y

Filename    : pllnrst.v
Compiler    : Quartus II 9.1
simulator	: ModelSim 6.5b
Description : 用作输入同步
Release     : 
*/

module input_sync(
				//input
				oclk,
				sysrst_n,
				hsync_in,
				vsync_in,
				de_in,
				data_in,
				//output
				hsync,
				vsync,
				de,
				data
				);

input oclk;
input sysrst_n;
input hsync_in;
input vsync_in;
input de_in;
input [23:0] data_in;
output hsync;
output vsync;
output de;
output [23:0] data;

reg hsync;
reg vsync;
reg de;
reg [23:0] data;
always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n) begin
		hsync<=1'b1;
		vsync<=1'b0;
		de<=1'b0;
		data<=24'd0;
		end
	else begin
		hsync<=hsync_in;
		vsync<=vsync_in;
		de<=de_in;
		data<=data_in;
		end
end

endmodule




