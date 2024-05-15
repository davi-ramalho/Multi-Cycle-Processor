module MemRAM (input clk, input rst, input [7:0] A, input [7:0] WD, input WE, output reg [7:0] RD);

reg [7:0] memoria [255:0];
integer i;

always@(*)begin
        RD <= memoria[A];
		  end

always @(posedge clk or negedge rst) begin
    if(!rst)begin
		for(i = 0; i < 256; i = i + 1) begin
			memoria[i] <= 0;
			end
		end	
		
	 else if (WE)begin
        memoria[A] <= WD; 
    end 
end

endmodule