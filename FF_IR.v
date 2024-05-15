module FF_IR(input clk, rst, IRWrite, input [7:0] PC, output reg [7:0] PCold, input [31:0] Instnew, output reg [31:0] Inst);

always @(posedge clk or negedge rst) begin
		if (!rst) begin
			PCold <= 8'b00000000;
			Inst <= 32'h00000000;
			end
		else if (IRWrite) begin
			PCold <= PC;
			Inst <= Instnew;
			end
		end
endmodule