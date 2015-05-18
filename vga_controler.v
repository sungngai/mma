
/* 
copyright C.Y

Filename    : pllnrst.v
Compiler    : Quartus II 9.1
simulator	: ModelSim 6.5b
Description : vga控制器
Release     : 
*/

module vga_controler(
				//input 
				clkc0_24m,
				sysrst_n,
				hsync_in,
				vsync_in,
				q1_1,
				q1_2,
				q2_1,
				q2_2,
				fifo1_full,
				fifo1_empty,
				fifo2_full,
				fifo2_empty,
				//output
				/* led0,
				led1, */
				
				rdreq1,
				rdreq2,
				
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
				
input clkc0_24m;
input sysrst_n;
input hsync_in;
input vsync_in;
input [23:0] q1_1;
input [23:0] q1_2;
input [23:0] q2_1;
input [23:0] q2_2;
input fifo1_full;
input fifo1_empty;
input fifo2_full;
input fifo2_empty;

/* output led0;
output led1; */
output rdreq1;
output rdreq2;
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
output[23:0] vga_r;


//边沿检测hsync_in下降沿
reg hsync_in_ff1;
reg hsync_in_ff2;
always @ (negedge clkc0_24m or negedge sysrst_n) begin	
	if(!sysrst_n) begin
		hsync_in_ff1<=1'b1;
		hsync_in_ff2<=1'b1;
		end
	else begin
		hsync_in_ff1<=hsync_in;
		hsync_in_ff2<=hsync_in_ff1;
		end
end
wire hsync_neg=hsync_in_ff2 &(~hsync_in_ff1);

//信号延迟一行
reg hsync_flag1;
always @ (negedge clkc0_24m or negedge sysrst_n) begin
	if(!sysrst_n)
		hsync_flag1<=1'b0;
	else if(hsync_neg & vsync_in)
		hsync_flag1<=1'b1;
	else ;
end

reg hsync_flag2;
always @ (negedge clkc0_24m or negedge sysrst_n) begin
	if(!sysrst_n)
		hsync_flag2<=1'b0;
	else if(hsync_flag1 && hsync_neg)
		hsync_flag2<=1'b1;
	else ;
end

//行计数器
reg [10:0] x_cnt;
always @ (negedge clkc0_24m or negedge sysrst_n) begin
	if(!sysrst_n)
		x_cnt<=11'd0;
	else if(hsync_neg)
		x_cnt<=11'd0;
	else
		x_cnt<=x_cnt+1'b1;
end

//场计数器
reg [9:0] y_cnt;
always @ (negedge clkc0_24m or negedge sysrst_n) begin
	if(!sysrst_n)
		y_cnt<=10'd0;
	else if(y_cnt>=10'd500)
		y_cnt<=10'd0;
	else if(hsync_flag2 && hsync_neg)
		y_cnt<=y_cnt+1'b1;
	else ;
end

//hsync_l时序
reg hsync_l;
always @ (negedge clkc0_24m or negedge sysrst_n) begin
	if(!sysrst_n) 
		hsync_l<=1'b1;
	else if(hsync_flag2 && x_cnt>=11'd0 && x_cnt<11'd64)
		hsync_l<=1'b0;
	else
		hsync_l<=1'b1;
end

//hsync_r时序
assign hsync_r=hsync_l;

//vsync_l时序
reg vsync_l;
always @ (negedge clkc0_24m or negedge sysrst_n) begin
	if(!sysrst_n) 
		vsync_l<=1'b0;
	else if(hsync_flag2 && y_cnt>=10'd0 && y_cnt<10'd4)
		vsync_l<=1'b1;
	else
		vsync_l<=1'b0;
end

//vsync_r时序
assign vsync_r=vsync_l;

//sync_n_l时序
assign sync_n_l=1'b0;

//sync_n_r时序
assign sync_n_r=1'b0;

//vga_clk时序
assign vga_clk=clkc0_24m;

//blank_n_l时序
wire valid=(x_cnt>11'd143 && x_cnt<=11'd783 && y_cnt>10'd16 && y_cnt<=10'd496);

reg blank_n_l;
always @ (negedge clkc0_24m or negedge sysrst_n) begin
	if(!sysrst_n)
		blank_n_l<=1'b0;
	else if(valid)
		blank_n_l<=1'b1;
	else
		blank_n_l<=1'b0;
end

//blank_n_r时序
assign blank_n_r=blank_n_l;

/* assign vga_l=blank_n_l? 24'hff0000:24'h000000;
assign vga_r=blank_n_r? 24'h00ff00:24'h000000; */

//FSM controler
reg [1:0] cstate;

parameter IDLE=		2'b00;
parameter RD_FIFO1=	2'b01;
parameter RD_FIFO2=	2'b10;

always @ (negedge clkc0_24m or negedge sysrst_n) begin
	if(!sysrst_n) 
		cstate<=IDLE;
	else
		case(cstate)
			IDLE: begin
				if(fifo1_full)
					cstate<=RD_FIFO1;
				else if(fifo2_full)
					cstate<=RD_FIFO2;
				else
					cstate<=IDLE;
				end
			RD_FIFO1: begin
				if(fifo1_empty)
					cstate<=IDLE;
				else
					cstate<=RD_FIFO1;
				end
			RD_FIFO2: begin
				if(fifo2_empty)
					cstate<=IDLE;
				else
					cstate<=RD_FIFO2;
				end
			default: ;
		endcase
end

//rdreq1时序
reg rdreq1;
always @ (*) begin
	if(!sysrst_n)
		rdreq1=1'b0;
	else if(cstate==RD_FIFO1 && valid) 
		rdreq1=1'b1;
	else
		rdreq1=1'b0;
end

//rdreq2时序
reg rdreq2;
always @ (*) begin
	if(!sysrst_n)
		rdreq2=1'b0;
	else if(cstate==RD_FIFO2 && valid)
		rdreq2=1'b1;
	else 
		rdreq2=1'b0;
end

/* //led0,led1时序
reg led0;
reg led1;
always @ (negedge clkc0_24m or negedge sysrst_n) begin
	if(!sysrst_n) begin
		led0<=1'b0;
		led1<=1'b0;
		end
	else if(cstate==RD_FIFO1)
		led0<=1'b1;
	else if(cstate==RD_FIFO2)
		led1<=1'b1;
	else begin
		led0<=1'b0;
		led1<=1'b0;
		end
end */

//vga_l时序
reg [23:0] vga_l;
always @ (negedge clkc0_24m or negedge sysrst_n) begin
	if(!sysrst_n)
		vga_l<=24'd0;
	else if(rdreq1)
		vga_l<=q1_1;
	else if(rdreq2)
		vga_l<=q2_1;
	else
		vga_l<=24'd0;
end

//vga_r时序
reg [23:0] vga_r;
always @ (negedge clkc0_24m or negedge sysrst_n) begin
	if(!sysrst_n)
		vga_r<=24'd0;
	else if(rdreq1)
		vga_r<=q1_2;
	else if(rdreq2)
		vga_r<=q2_2;
	else
		vga_r<=24'd0;
end


endmodule


