module ULA(input [7:0] SrcA, SrcB, input [2:0] ULAControl, output reg [7:0] ULAResult, output Zero);

	always @ (*)
		case(ULAControl)
			3'b000	: ULAResult = SrcA + SrcB;
			3'b001	: ULAResult = SrcA + ~(SrcB) + 1;
			3'b010	: ULAResult = SrcA & SrcB;
			3'b011	: ULAResult = SrcA | SrcB;
			3'b100	: ULAResult = SrcA ^ SrcB;
			3'b101	: ULAResult = SrcA < SrcB;
			default	: ULAResult = 3'b000;
		endcase
		
	assign Zero = ~|ULAResult;
endmodule
