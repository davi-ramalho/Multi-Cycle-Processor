module FF_TD_2(input clk, rst, input [7:0] In1, output reg [7:0] Out1, input [7:0] In2, output reg [7:0] Out2);

always @(posedge clk or negedge rst) begin
		if (!rst) begin
			Out1 <= 8'b00000000;
			Out2 <= 8'b00000000;
			end
		else begin
			Out1 <= In1;
			Out2 <= In2;
			end
		end
endmodule