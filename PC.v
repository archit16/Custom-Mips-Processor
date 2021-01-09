`timescale 1ns / 1ps

module PC(
input clk, reset, input [31:0] nxt_instr_addr, output reg [31:0] current_instr_addr
    );
    
//initial
//begin
//current_instr_addr <= 32'h00000000;
//end
always@(posedge clk)
begin
if(reset) begin
current_instr_addr = 32'h00000000;
end
else begin
#1
current_instr_addr = nxt_instr_addr;
end
end
endmodule
