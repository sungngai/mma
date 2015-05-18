
/* 
copyright C.Y

Filename    : pllnrst.v
Compiler    : Quartus II 9.1
simulator	: ModelSim 6.5b
Description : 乒乓FIFO模块
Release     : 
*/

module pingpong_fifo (
				//input
				oclk,
				clkc0_24m,
				sysrst_n,
				de1,
				de2,
				rdreq1,
				rdreq2,
				data,
				clr1,
				clr2,
				//output
				fifo1_full,
				fifo1_empty,
				fifo2_full,
				fifo2_empty,
				q1_1,
				q1_2,
				q2_1,
				q2_2
				);
				
input oclk;
input clkc0_24m;
input sysrst_n;
input de1;
input de2;
input rdreq1;
input rdreq2;
input [23:0] data;
input clr1;
input clr2;

output fifo1_full;
output fifo1_empty;
output fifo2_full;
output fifo2_empty;
output [23:0] q1_1;
output [23:0] q1_2;
output [23:0] q2_1;
output [23:0] q2_2;

wire [10:0] wrusedw1_1;
wire [10:0] wrusedw1_2;
wire [10:0] wrusedw2_1;
wire [10:0] wrusedw2_2;

//pingpong fifo1 controler**********************************************************
reg de1_1;
always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n)
		de1_1<=1'b0;
	else if(de1 && wrusedw1_1<11'd639)
		de1_1<=1'b1;
	else
		de1_1<=1'b0;
end	

reg [23:0] data1_1;
always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n) 
		data1_1<=24'd0;
	else if(de1_1 || fifo2_full)
		data1_1<=data;
	else 
		data1_1<=24'd0;
end

reg de1_2;
always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n) 
		de1_2<=1'b0;
	else if(de1 && (wrusedw1_1==11'd639 || wrusedw1_1==11'd640) && wrusedw1_2<11'd640)
		de1_2<=1'b1;
	else
		de1_2<=1'b0;
end

reg [23:0] data1_2;
always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n)
		data1_2<=24'd0;
	else if(de1_2 || (de1_1 && wrusedw1_1==11'd639))
		data1_2<=data;
	else
		data1_2<=24'd0;
end

//fifo1_full时序
reg fifo1_full;
always @ (posedge oclk or negedge sysrst_n) begin
	if(!sysrst_n)
		fifo1_full<=1'b0;
	else if(wrusedw1_1>=11'd640 && wrusedw1_2>=11'd640)
		fifo1_full<=1'b1;
	else
		fifo1_full<=1'b0;
end

//fifo1_empty时序
reg fifo1_empty;
wire rdempty1_1;
wire rdempty1_2;
always @ (posedge clkc0_24m or negedge sysrst_n) begin
	if(!sysrst_n)
		fifo1_empty<=1'b0;
	else if(rdempty1_1 && rdempty1_2)
		fifo1_empty<=1'b1;
	else
		fifo1_empty<=1'b0;
end

fifo1_1	fifo1_1_inst (
			.aclr (clr1),
			.data (data1_1),
			.rdclk (clkc0_24m),
			.rdreq (rdreq1),
			.wrclk (oclk),
			.wrreq (de1_1),
			.q (q1_1),
			.rdempty (rdempty1_1),
			.wrusedw (wrusedw1_1)
			);
			
fifo1_2	fifo1_2_inst (
			.aclr (clr1),
			.data (data1_2),
			.rdclk (clkc0_24m),
			.rdreq (rdreq1),
			.wrclk (oclk),
			.wrreq (de1_2),
			.q (q1_2),
			.rdempty (rdempty1_2),
			.wrusedw (wrusedw1_2)
			);
			
//pingpong fifo2 controler**********************************************************
reg de2_1;
always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n)
		de2_1<=1'b0;
	else if(de2 && wrusedw2_1>=11'd0 && wrusedw2_1<11'd639)
		de2_1<=1'b1;
	else
		de2_1<=1'b0;
end

reg [23:0] data2_1;
always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n) 
		data2_1<=24'd0;
	else if(de2_1 || fifo1_full)
		data2_1<=data;
	else 
		data2_1<=24'd0;
end

reg de2_2;
always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n) 
		de2_2<=1'b0;
	else if(de2 && (wrusedw2_1==11'd639 || wrusedw2_1==11'd640) && wrusedw2_2<11'd640)
		de2_2<=1'b1;
	else
		de2_2<=1'b0;
end

reg [23:0] data2_2;
always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n)
		data2_2<=24'd0;
	else if(de2_2 || (de2_1 && wrusedw2_1==11'd639))
		data2_2<=data;
	else
		data2_2<=24'd0;
end

//fifo1_full时序
reg fifo2_full;
always @ (posedge oclk or negedge sysrst_n) begin
	if(!sysrst_n)
		fifo2_full<=1'b0;
	else if(wrusedw2_1>=11'd640 && wrusedw2_2>=11'd640)
		fifo2_full<=1'b1;
	else
		fifo2_full<=1'b0;
end

//fifo1_empty时序
reg fifo2_empty;
wire rdempty2_1;
wire rdempty2_2;
always @ (posedge oclk or negedge sysrst_n) begin
	if(!sysrst_n)
		fifo2_empty<=1'b0;
	else if(rdempty2_1 && rdempty2_2)
		fifo2_empty<=1'b1;
	else
		fifo2_empty<=1'b0;
end

fifo2_1	fifo2_1_inst (
			.aclr (clr2),
			.data (data2_1),
			.rdclk (clkc0_24m),
			.rdreq (rdreq2),
			.wrclk (oclk),
			.wrreq (de2_1),
			.q (q2_1),
			.rdempty (rdempty2_1),
			.wrusedw (wrusedw2_1)
			);
			
fifo2_2	fifo2_2_inst (
			.aclr (clr2),
			.data (data2_2),
			.rdclk (clkc0_24m),
			.rdreq (rdreq2),
			.wrclk (oclk),
			.wrreq (de2_2),
			.q (q2_2),
			.rdempty (rdempty2_2),
			.wrusedw (wrusedw2_2)
			);


endmodule

