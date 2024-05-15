module MUX2(input [7:0] i0, i1, input sel, output [7:0] out);

assign out = sel ? i1 : i0;

endmodule