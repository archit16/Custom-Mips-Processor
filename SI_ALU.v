`timescale 1ns / 1ps
module SI_ALU(
    input [31:0] RS,
    input [31:0] RT,
    input [3:0] ROT_AM,
    input [3:0]ALU_CNTRL,
    output reg [31:0] VAL
    );
 
    initial begin
    VAL <= 0;
    end
    always@(RS, RT, ALU_CNTRL)
    begin
    case(ALU_CNTRL)
    4'd5: begin
        //XOR and rotate left
        VAL = (RS ^ RT)<<ROT_AM;        
        end 
    4'd6: begin
        // right rotate and xor
        VAL = (RS >> ROT_AM) ^ RT;
        end
    4'd7: begin
        // left rotate and add
        VAL = (RS << ROT_AM) + RT;
        end   
    4'd8: begin
        // sub and right rotate
        VAL = (RS - RT) >> ROT_AM;
        end
    default: VAL = 0;
    endcase    
    end
endmodule
