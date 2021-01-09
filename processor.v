`timescale 1ns / 1ps

module mux(input [31:0] a, b, input c, output wire [31:0] d);
assign d = c ? b : a;
endmodule

module mux_5bit(input[4:0]a,b, input c, output wire[4:0]d);
assign d = c? b : a;
endmodule

module processor(
input clk,
input reset,
output reg halt
    );
wire [31:0] PC_new, w4, w5,w7;
wire [31:0] PC, w3, instr, res, rd1, rd2, signimm, readdata, PCBranch, srcB;
wire signed [31:0] aluresult;
wire memtoreg, memwrite, branch, alusrc, regdst, regwrite, si_select,zero, PCSrc;
wire [3:0] alucntrl;
wire halt_temp,jump_temp;
wire [4:0] w6;
initial begin 
halt=0;
end
PC u1(clk, reset, PC_new, PC);
PCPlus4 u2(PC, w3);
Instr_Mem u3(PC, instr);
decode_unit u4(clk, instr, si_select, memtoreg, memwrite, branch, alucntrl, alusrc, regdst, regwrite, halt_temp, jump_temp);
mux_5bit u15(instr[20:16], instr[15:11], regdst, w6);
Register_File u5(clk, instr[25:21],instr[20:16], w6, res, regwrite, rd1, rd2);
mux u6(rd2, signimm, alusrc, srcB);
ALU u7(rd1, srcB, alucntrl, zero, aluresult);
and u8(PCSrc, zero, branch);
data_mem u9(clk, memwrite, aluresult, rd2, readdata);
mux u10(w5, readdata, memtoreg, res);
sign_extend u11(instr[15:0],signimm); 
shiftleftandadd u12(signimm, w3, PCBranch);
mux u0(w3,w7, PCSrc, PC_new);
SI_ALU u13(rd1, srcB, instr[10:6], alucntrl, w4);
mux u14(w4, aluresult, si_select, w5);
mux ujump(PCBranch,signimm, jump_temp,w7); 
always@(posedge clk)
begin
halt = halt_temp;
end
endmodule 
