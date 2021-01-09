`timescale 1ns / 1ps

module Instr_Mem(input [31:0] address, output reg [31:0]instr); 
reg[7:0] mem[0:31];

initial begin
$readmemh("C:/Users/Archit/Desktop/project__processor_1/code.mem",mem);
instr <= 31'b0;
//-------------------------------------------------------CONTENTS OF code.mem file-------------------------------------------------------------

//Xor and left r3, r1, r2 (rot_amt =2)
//mem[0] = 8'h90;
//mem[1] = 8'h18;
//mem[2] = 8'h22;
//mem[3] = 8'h00;

////jump 
//mem[4] = 8'h0c;
//mem[5] = 8'h00;
//mem[6] = 8'h00;
//mem[7] = 8'h30;

////Xor and left r3, r1, r2 (rot_amt =2)
//mem[8] = 8'h90;
//mem[9] = 8'h18;
//mem[10] = 8'h22;
//mem[11] = 8'h00;

////store r9, 16
//mem[12] = 8'h00;
//mem[13] = 8'h00;
//mem[14] = 8'h36;
//mem[15] = 8'had;

////load r4, 6
//mem[16] <= 8'h00;
//mem[17] <= 8'h00;
//mem[18] <= 8'h86;
//mem[19] <= 8'h1c;

////add r7, r1, r2
//mem[20] <= 8'h20;
//mem[21] <= 8'h38;
//mem[22] <= 8'h22;
//mem[23] <= 8'h00;

////nor r3, r1, r2
//mem[24] = 8'h14;
//mem[25] = 8'h18;
//mem[26] = 8'h22;
//mem[27] = 8'h00;

////HALT
//mem[28] <= 8'h1c;
//mem[29] <= 8'h00;
//mem[30] <= 8'h00;
//mem[31] <= 8'hfc;
//-------------------------------------------------------------------------------------------------------------------------------------------
end
always @ (address)
begin
instr = {mem[address+3], mem[address+2], mem[address+1], mem[address]};
end
endmodule