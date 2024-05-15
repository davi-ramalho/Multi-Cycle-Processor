module registrador(input [7:0] wd3, input [2:0] wa3, ra1, ra2, input clk, we3, reset, output reg [7:0] rd1, rd2, x0, x1, x2, x3, x4, x5, x6, x7);

reg [7:0] rgf [7:0];

always @(posedge clk or negedge reset) begin
	if(!reset) begin
		rgf[1] <= 0;
		rgf[2] <= 0;
		rgf[3] <= 0;
		rgf[4] <= 0;
		rgf[5] <= 0;
		rgf[6] <= 0;
		rgf[7] <= 0;
		end
	else begin
      if (we3 && (wa3 != 0)) begin
		rgf[wa3] <= wd3;
	end
	rgf[0] <= 0;
end 
end
always @(*) begin
  	rd1 = rgf[ra1];
  	rd2 = rgf[ra2];
	x0 = rgf[0];
	x1 = rgf[1];
	x2 = rgf[2];
	x3 = rgf[3];
	x4 = rgf[4];
	x5 = rgf[5];
	x6 = rgf[6];
	x7 = rgf[7];
end
  

endmodule
			