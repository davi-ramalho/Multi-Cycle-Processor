module IM(input [7:0] A, output reg[31:0] RD);

always @(*) 
	casex (A)
		8'h00 : RD = 32'h00700093;
		8'h04 : RD = 32'h00300193;
		8'h08 : RD = 32'hfff00113;
		8'h0C : RD = 32'h00110113;
		8'h10 : RD = 32'h003123b3;
		8'h14 : RD = 32'hfe208ae3;
		8'h18 : RD = 32'hfe000ae3;
		default : RD = 32'hx;
	endcase		
	
endmodule