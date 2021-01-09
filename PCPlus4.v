`timescale 1ns / 1ps
module PCPlus4(
    input [31:0] PC,
    output reg [31:0] PC_out
    );
    
    always@(PC) begin
    PC_out = PC + 32'd4;
    end
endmodule
