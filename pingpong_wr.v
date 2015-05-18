
/* 
copyright C.Y

Filename    : pllnrst.v
Compiler    : Quartus II 9.1
simulator	: ModelSim 6.5b
Description : 乒乓写操作控制器
Release     : 
*/

module pingpong_wr (
				//input
				oclk,
				sysrst_n,
				fifo1_full,
				fifo1_empty,
				fifo2_full,
				fifo2_empty,
				de,
				//output
				led0,
				led1,
				clr1,
				clr2,
				wrreq1,
				wrreq2
				);
				
input oclk;
input sysrst_n;
input fifo1_full;
input fifo1_empty;
input fifo2_full;
input fifo2_empty;
input de;
output led0;
output led1;
output clr1;
output clr2;
output wrreq1;
output wrreq2;

//FSM controler
reg [3:0] cstate;
reg [2:0] fsm_dly;

parameter IDLE=			4'b0000;
parameter CLR_FIFO1=	4'b0001;
parameter WR_FIFO1=		4'b0010;
parameter CLR_FIFO2=	4'b0100;
parameter WR_FIFO2=		4'b1000;

always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n) begin
		cstate<=IDLE;
		fsm_dly<=3'd0;
		end
	else 
		case(cstate)
			IDLE: begin
				if(fifo1_empty)
					cstate<=CLR_FIFO1;
				else 
					cstate<=IDLE;
				end
			CLR_FIFO1: begin
				fsm_dly<=3'd0;
				cstate<=WR_FIFO1;
				end
			WR_FIFO1: begin
				if(fifo1_full) begin	
					fsm_dly<=fsm_dly+1'b1;
					if(fsm_dly==3'd5)
						cstate<=CLR_FIFO2;
					else ;
					end
				else
					cstate<=WR_FIFO1;
				end
			CLR_FIFO2: begin
				fsm_dly<=3'd0;
				cstate<=WR_FIFO2;
				end
			WR_FIFO2: begin
				if(fifo2_full) begin
					fsm_dly<=fsm_dly+1'b1;
					if(fsm_dly==3'd5)
						cstate<=CLR_FIFO1;
					else ;
					end
				else
					cstate<=WR_FIFO2;
				end
			default: ;
		endcase
end

reg clr1;
always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n)
		clr1<=1'b1;
	else if(cstate==CLR_FIFO1)
		clr1<=1'b1;
	else 
		clr1<=1'b0;
end

reg clr2;
always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n)
		clr2<=1'b1;
	else if(cstate==CLR_FIFO2)
		clr2<=1'b1;
	else 
		clr2<=1'b0;
end

reg [11:0] de_cnt;
always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n) 
		de_cnt<=12'd0;
	else if(de)
		de_cnt<=de_cnt+1'b1;
	else
		de_cnt<=12'd0;
end

reg wrreq1;
always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n)
		wrreq1<=1'b0;
	else if(de && cstate==WR_FIFO1)
		wrreq1<=1'b1;
	else 
		wrreq1<=1'b0;
end

reg wrreq2;
always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n)
		wrreq2<=1'b0;
	else if(de && cstate==WR_FIFO2)
		wrreq2<=1'b1;
	else
		wrreq2<=1'b0;
end

//led0,led1时序
reg led0;
reg led1;
always @ (negedge oclk or negedge sysrst_n) begin
	if(!sysrst_n) begin
		led0<=1'b0;
		led1<=1'b0;
		end
	else if(wrreq1)
		led0<=1'b1;
	else if(wrreq2)
		led1<=1'b1;
	else begin
		led0<=1'b0;
		led1<=1'b0;
		end
end

endmodule














