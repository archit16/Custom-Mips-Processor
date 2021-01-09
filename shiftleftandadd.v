`timescale 1ns / 1ps

module shiftleftandadd(
input [31:0] signimm, w3, output reg [31:0] pc_branch
    );
 reg [31:0] abc;
 
 initial
 begin
 pc_branch <= 0;
 end
 
 always @(signimm, w3)
 begin
 abc = signimm<<2;
 pc_branch = abc+w3;
end
endmodule
