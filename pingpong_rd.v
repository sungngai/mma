
/* 
copyright C.Y

Filename    : pllnrst.v
Compiler    : Quartus II 9.1
simulator	: ModelSim 6.5b
Description : 乒乓FIFO读操作
Release     : 
*/

module pingpong_rd (
				//input
				clkc0_24m,
				sysrst_n,
				fifo1_full,
				fifo1_empty,
				fifo2_full,
				fifo2_empty,
				de,
				//output
				rdreq1,
				rdreq2
				);
				
input clkc0_24m;
input sysrst_n;
input fifo1_full;
input fifo1_empty;
input fifo2_full;
input fifo2_empty;
input de;
output rdreq1;
output rdreq2;

//边沿检测de拉高
reg de_ff1;
reg de_ff2;
wire de_pos;
always @ (negedge clkc0_24m or negedge sysrst_n) begin
	if(!sysrst_n) begin
		de_ff1<=1'b0;
		de_ff1<=1'b0;
		end
	else begin
		de_ff1<=de;
		de_ff2<=de_ff1;
		end
end
assign de_pos=de_ff1 &(~de_ff2);

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
				if(fifo1_full && de_pos)
					cstate<=RD_FIFO1;
				else if(fifo2_full && de_pos)
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
always @ (negedge clkc0_24m or negedge sysrst_n) begin
	if(!sysrst_n)
		rdreq1<=1'b0;
	else if(cstate==RD_FIFO1)
		rdreq1<=1'b1;
	else
		rdreq1<=1'b0;
end

//rdreq2时序
reg rdreq2;
always @ (negedge clkc0_24m or negedge sysrst_n) begin
	if(!sysrst_n)
		rdreq2<=1'b0;
	else if(cstate==RD_FIFO2)
		rdreq2<=1'b1;
	else
		rdreq2<=1'b0;
end

endmodule

