module ControlUnit(input [6:0] OP, input [2:0] Funct3, input [6:0] Funct7, input Zero, input rst, input clk, output RegWrite,
output IRWrite, output PCWrite, output AdrSrc, output [1:0] ULASrcA, output [1:0] ULASrcB, output reg [1:0] ImmSrc,
output MemWrite, output [1:0] ResultSrc, output reg [2:0] ULAControl, output reg [3:0] fsmstate);

wire [1:0] ULAOp;
wire Branch;

always @(posedge clk or negedge rst) begin
	if(!rst) begin
		fsmstate <= 4'd0;
		end
	else begin
		case (fsmstate)
			4'd0:
				fsmstate <= 4'd1;
			4'd1: begin
				case(OP)
					7'b0110011:
						fsmstate <= 4'd6;
					7'b0010011:
						fsmstate <= 4'd8;
					7'b0000011:
						fsmstate <= 4'd2;
					7'b0100011:
						fsmstate <= 4'd2;
					7'b1100011:
						fsmstate <= 4'd9;
					default:
						fsmstate <= 4'd0;
						endcase
						end
			4'd2: begin
				case(OP)
					7'b0000011:
						fsmstate <= 4'd3;
					7'b0100011:
						fsmstate <= 4'd5;
					default:
						fsmstate <= 4'd0;
						endcase
						end
			4'd3:
				fsmstate <= 4'd4;
			4'd4:
				fsmstate <= 4'd0;
			4'd5:
				fsmstate <= 4'd0;
			4'd6:
				fsmstate <= 4'd7;
			4'd7:
				fsmstate <= 4'd0;
			4'd8:
				fsmstate <= 4'd7;
			4'd9:
				fsmstate <= 4'd0;
			default:
				fsmstate <= 4'd0;
		endcase
end
end

assign Branch = (rst == 1'b0) ? 1'b0 : ((fsmstate == 4'd9) ? 1'b1 : 1'b0);
assign IRWrite = (rst == 1'b0) ? 1'b0 : ((fsmstate == 4'd0) ? 1'b1 : 1'b0);
assign PCWrite = (rst == 1'b0) ? 1'b0 : (((fsmstate == 4'd0) || (Branch & Zero)) ? 1'b1 : 1'b0);
assign AdrSrc = (rst == 1'b0) ? 1'b0 : (((fsmstate == 4'd3) || (fsmstate == 4'd4)) ? 1'b1 : 1'b0);
assign MemWrite = (rst == 1'b0) ? 1'b0 : ((fsmstate == 4'd5) ? 1'b1 : 1'b0);
assign RegWrite = (rst == 1'b0) ? 1'b0 : (((fsmstate == 4'd4) || (fsmstate == 4'd7)) ? 1'b1 : 1'b0);
assign ResultSrc = (rst == 1'b0) ? 2'b00 : ((fsmstate == 4'd4) ? 2'b01 : ((fsmstate == 4'd0) ? 2'b10 : 2'b00)); 
assign ULASrcA = (rst == 1'b0) ? 2'b00 : ((fsmstate == 4'd1) ? 2'b01 : (((fsmstate == 4'd2) || (fsmstate == 4'd6) || (fsmstate == 4'd8) || (fsmstate == 4'd9)) ? 2'b10 : 2'b00));		
assign ULASrcB = (rst == 1'b0) ? 2'b00 : ((fsmstate == 4'd0) ? 2'b10 : (((fsmstate == 4'd1) || (fsmstate == 4'd2) || (fsmstate == 4'd8)) ? 2'b01 : 2'b00));						
assign ULAOp = (rst == 1'b0) ? 2'b00 : (((fsmstate == 4'd6) || (fsmstate == 4'd8)) ? 2'b10 : ((fsmstate == 4'd9) ? 2'b01 : 2'b00)); 

always@(*) begin
	case(OP)
		7'b1100011:
			ImmSrc <= 2'b10;
		7'b0100011:
			ImmSrc <= 2'b01;
		default:
			ImmSrc <= 2'b00;
		endcase
	casez({ULAOp, Funct3, OP[5], Funct7[5]})
		7'b00_zzz_zz:
			ULAControl <= 3'b000;
		7'b01_zzz_zz:
			ULAControl <= 3'b001;
		7'b10_000_11:
			ULAControl <= 3'b001;
		7'b10_010_00:
			ULAControl <= 3'b101;
		7'b10_110_00:
			ULAControl <= 3'b011;
		7'b10_111_00:
			ULAControl <= 3'b010;
		7'b10_100_00:
			ULAControl <= 3'b100;
		7'b10_000_0z:
			ULAControl <= 3'b000;
		default:
			ULAControl <= 3'b000;
	endcase
end
endmodule