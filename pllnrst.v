
/* 
copyright C.Y

Filename    : pllnrst.v
Compiler    : Quartus II 9.1
simulator	: ModelSim 6.5b
Description : pll 管理及系统复位
Release     : 
*/

module pllnrst (
			//input
			clk,
			rst_n,
			//output
			clkc0_24m,
			sysrst_n
			);
			
input clk;
input rst_n;
output clkc0_24m;
output sysrst_n;

//异步复位同步释放
//同步释放掉pll模块复位端
reg pllrst_n_ff1;
reg pllrst_n_r;
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		pllrst_n_ff1<=1'b0;
		pllrst_n_r<=1'b0;
		end
	else begin
		pllrst_n_ff1<=1'b1;
		pllrst_n_r<=pllrst_n_ff1;
		end
end
wire pllrst_n;
assign pllrst_n=pllrst_n_r;

wire lock;

pll	pll_inst (
	//input
	.areset (!pllrst_n),
	.inclk0 (clk),
	//output
	.c0 (clkc0_24m),
	.locked (lock)
	);

wire pll2sysrst_n;
assign pll2sysrst_n= lock & rst_n;

//同步释放掉后续复位端口
reg sysrst_n_ff1;
reg sysrst_n_r;
always @ (posedge clkc0_24m or negedge pll2sysrst_n) begin
	if(!pll2sysrst_n) begin
		sysrst_n_ff1<=1'b0;
		sysrst_n_r<=1'b0;
		end
	else begin
		sysrst_n_ff1<=1'b1;
		sysrst_n_r<=sysrst_n_ff1;
		end
end
assign sysrst_n=sysrst_n_r;

endmodule




