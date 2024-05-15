module FF_PC(input clk, rst, PCWrite, input [7:0] PCnew, output reg [7:0] PC);

always @(posedge clk or negedge rst) begin
		if (!rst) begin
			PC <= 8'b00000000;
			end
		else if (PCWrite) begin
			PC <= PCnew;
			end
		end
endmodule
