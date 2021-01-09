`timescale 1ns/1ps
module data_mem(input clk, Mem_write, [31:0]A, [31:0]WD, output reg [31:0] RD);

reg [15:0] mem[255:0];
reg [4:0] temp;
integer i;

initial begin
  RD <= 0;
  temp <= 0;
  for (i = 0; i < 256; i = i + 1) begin
    mem[i] <= i;
  end
end
always @(*) begin
temp = A & 32'hFFFFFFFE;

  if (Mem_write == 1'b1) begin
    mem[temp] <= WD[15:0];
    mem[temp+1] <= WD[31:16];
  end
//  if(A[0] == 0)
//    temp = {mem[A+1], mem[A]};
//  else
//    temp = {mem[A], mem[A-1]};

  RD = {mem[temp+1], mem[temp]};
end

endmodule