`default_nettype none //Comando para desabilitar declaração automática de wires
module Mod_Teste(input clock, rst, output [3:0] fsmstate);

wire w_RegWrite, w_MemWrite, w_PCWrite, w_Zero, w_AdrSrc, w_IRWrite;
wire [1:0] w_ImmSrc, w_ULASrcA, w_ULASrcB, w_ResultSrc;
wire [2:0] w_ULAControl;
wire [3:0] w_fsmstate;
wire [7:0] w_rd1, w_rd2, w_rd1ff, w_PC, w_Imm, w_SrcB, w_SrcA, w_ULAResult, w_ULAOut, w_Wd3, w_Result, w_Adr, w_WD, w_ReadData, w_PCold, w_Data, w_x0, w_x1, w_x2, w_x3, w_x4, w_x5, w_x6, w_x7;
wire [31:0] w_Instnew, w_Inst;

assign fsmstate = w_fsmstate;

FF_PC ffpc(.clk(clock), .rst(rst), .PCWrite(w_PCWrite), .PCnew(w_Result), .PC(w_PC));

MUX2 mux_PC(.i0(w_PC), .i1(w_Result), .sel(w_AdrSrc), .out(w_Adr));

IM IntructionMemory(.A(w_Adr), .RD(w_Instnew));

MemRAM DataMemory(.clk(clock), .rst(rst), .A(w_Adr), .WD(w_WD), .WE(w_MemWrite), .RD(w_ReadData));

FF_IR ffir(.clk(clock), .rst(rst), .IRWrite(w_IRWrite), .PC(w_PC), .PCold(w_PCold), .Instnew(w_Instnew), .Inst(w_Inst));

FF_TD ffdata(.clk(clock), .rst(rst), .In(w_ReadData), .Out(w_Data));

ControlUnit UnidadeDeControle(.OP(w_Inst[6:0]), .Funct3(w_Inst[14:12]), .Funct7(w_Inst[31:25]), .Zero(w_Zero), .rst(rst), .clk(clock), .RegWrite(w_RegWrite),
.IRWrite(w_IRWrite), .PCWrite(w_PCWrite), .AdrSrc(w_AdrSrc), .ULASrcA(w_ULASrcA), .ULASrcB(w_ULASrcB), .ImmSrc(w_ImmSrc),
.MemWrite(w_MemWrite), .ResultSrc(w_ResultSrc), .ULAControl(w_ULAControl), .fsmstate(w_fsmstate));

registrador RegFile(.wd3(w_Result), .wa3(w_Inst[9:7]), .ra1(w_Inst[17:15]), .ra2(w_Inst[22:20]), .clk(clock), .we3(w_RegWrite), .reset(rst), .rd1(w_rd1), .rd2(w_rd2), .x0(w_x0), .x1(w_x1), .x2(w_x2), .x3(w_x3), .x4(w_x4), .x5(w_x5), .x6(w_x6), .x7(w_x7));

MUX4 MuxImm(.i0(w_Inst[27:20]), .i1({w_Inst[27:25], w_Inst[11:7]}), .i2({w_Inst[29:25], w_Inst[11:8], 1'b0}), .i3(8'b0), .sel(w_ImmSrc), .out(w_Imm));

FF_TD_2 ffreg(.clk(clock), .rst(rst), .In1(w_rd1), .Out1(w_rd1ff), .In2(w_rd2), .Out2(w_WD));

MUX4 MuxSrcA(.i0(w_PC), .i1(w_PCold), .i2(w_rd1ff), .i3(8'b0), .sel(w_ULASrcA), .out(w_SrcA));

MUX4 MuxSrcB(.i0(w_WD), .i1(w_Imm), .i2(3'd4), .i3(8'b0), .sel(w_ULASrcB), .out(w_SrcB));

ULA Ulamulti(.SrcA(w_SrcA), .SrcB(w_SrcB), .ULAControl(w_ULAControl), .ULAResult(w_ULAResult), .Zero(w_Zero));

FF_TD ffula(.clk(clock), .rst(rst), .In(w_ULAResult), .Out(w_ULAOut));

MUX4 MuxResult(.i0(w_ULAOut), .i1(w_Data), .i2(w_ULAResult), .i3(8'b0), .sel(w_ResultSrc), .out(w_Result));

endmodule
