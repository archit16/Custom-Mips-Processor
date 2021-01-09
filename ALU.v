`timescale 1ns/1ps
module ALU(input signed [31:0]srcA, signed [31:0]srcB, [3:0]ALUcntrl, output reg zero, reg signed [31:0]ALUresult);
initial begin
zero <= 0;
ALUresult <= 0;
end

always@(ALUcntrl, srcA, srcB) begin
case(ALUcntrl)
4'd0: begin // AND
    ALUresult = srcA & srcB;
end
4'd1: begin // OR
    ALUresult = srcA | srcB;
end
4'd2: begin // NOR
    ALUresult = ~(srcA | srcB);
end 
4'd3: begin // ADD
    ALUresult = srcA + srcB;
end
4'd4: begin // Divide
    ALUresult = srcA/srcB;
end
4'd9: begin
    ALUresult = srcA - srcB;
    if(ALUresult == 31'sd0) begin
        zero = 1;
    end
    end
4'd10: begin 
    ALUresult = srcA - srcB;
    if(ALUresult < 31'sd0 ) begin
    zero = 1;
    end
    end
4'd11: begin 
    ALUresult = srcA - srcB;
    if(ALUresult != 31'sd0 ) begin
    zero = 1;
    end
    end
4'd12: begin
    zero=1;
end
    
default: begin 
    ALUresult = 1;
    zero = 0;
    end
endcase
end
endmodule