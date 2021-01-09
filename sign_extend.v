`timescale 1ns / 1ps

module sign_extend(input [15:0] instr, output reg [31:0] Signimm);
initial
begin
Signimm <= 32'b0;
end
always @(instr)
begin
if(instr[15])
begin
    Signimm = {16'b1111111111111111,  instr};
end
else
begin
    Signimm = {16'd0, instr};
end
end
endmodule
