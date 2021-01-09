`timescale 1ns / 1ps

module decode_unit(input clk, input [31:0]instr, output reg SI_SELECT, reg MemtoReg,reg MemWrite, reg Branch,reg [3:0]ALUCNTRL,reg ALUSRC, reg RegDST,reg RegWrite, reg Halt, reg Jump);
initial
begin
ALUSRC <= 0;
MemtoReg <= 0;
RegWrite <= 0;
MemWrite <= 0;
Branch <= 0;
RegDST <=0;
Halt <=0;
Jump <=0;
ALUCNTRL <= 3'b000;
end

always @(*)
begin

if(instr[31:26] == 6'd0)
begin
ALUSRC <= 0;
MemtoReg <= 0;
RegWrite <= 1;
MemWrite <= 0;
Branch <= 0;
RegDST <= 1;
Jump <= 0;

case(instr[5:0])
6'h12: begin 
    ALUCNTRL <= 4'd0; 
    SI_SELECT <= 1;//and
    end
6'h13: begin 
    ALUCNTRL <= 4'd1;
    SI_SELECT <= 1;
    end //or
6'h14: begin 
    ALUCNTRL <= 4'd2; //nor
    SI_SELECT <= 1;
    end
6'h20: begin 
    ALUCNTRL <= 4'd3; //signed add
    SI_SELECT <= 1;
    end
6'h21: begin
    ALUCNTRL <= 4'd3; //unsigned add
    SI_SELECT <= 1;
    end
6'h1A: begin
    ALUCNTRL <= 4'd4; //divide /////////////////////////////////add select pin
    end
6'h10: begin
    ALUCNTRL <= 4'd5; //xor and left rotate
    SI_SELECT <= 0;
    end
6'h11: begin
    ALUCNTRL <= 4'd6; // right rotate and xor
    SI_SELECT <= 0;
    end
6'h15: begin 
    ALUCNTRL <= 4'd7; // left rotate and add
    SI_SELECT <= 0;
    end
6'h16: begin
    ALUCNTRL <= 4'd8; // sub and right rotate
    SI_SELECT <= 0;
    end
default: begin
        ALUCNTRL <= 4'd0;
        SI_SELECT <= 0;
        end
endcase
end

if(instr[31:26] == 6'h03 | instr[31:26] == 6'h04 | instr[31:26] == 6'h07 | instr[31:26] == 6'h2b | instr[31:26] == 6'h09 | instr[31:26] == 6'h0a | instr[31:26] == 6'h0b | instr[31:26] == 6'h08)
begin
if(instr[31:26] == 6'h03)
begin
    ALUSRC <= 0;
    MemtoReg <= 0;
    RegWrite <= 1;
    MemWrite <= 0;
    Branch <= 0;
    RegDST <= 0;
    Jump<=0;
    ALUCNTRL <= 4'd0;
end
if(instr[31:26] == 6'h04)
    ALUSRC <= 0;
    MemtoReg <= 0;
    RegWrite <= 1;
    MemWrite <= 0;
    Branch <= 0;
    RegDST <= 0;
    Jump<=0;
    ALUCNTRL <= 4'd1;
//load
if(instr[31:26] == 6'h07)
begin
    ALUSRC <= 1;
    MemtoReg <= 1;
    RegWrite <= 1;
    MemWrite <= 0;
    Branch <= 0;
    RegDST <= 0;
    Jump<=0;
    ALUCNTRL <= 4'd3;
end
//store
if(instr[31:26] == 6'h2b)
begin
    ALUSRC <= 1;
    MemtoReg <= 0;
    RegWrite <= 0;
    MemWrite <= 1;
    Branch <= 0;
    RegDST <= 0;
    Jump<=0;
    ALUCNTRL <= 4'd3;
end

if(instr[31:26] == 6'h09)
begin
    ALUSRC <= 0;
    MemtoReg <= 0;
    RegWrite <= 0;
    MemWrite <= 0;
    Branch <= 1;
    RegDST <= 0;
    Jump<=0;
    ALUCNTRL <= 4'd10; //subtract
end
if(instr[31:26] == 6'h0A)
begin
    ALUSRC <= 0;
    MemtoReg <= 0;
    RegWrite <= 0;
    MemWrite <= 0;
    Branch <= 1;
    RegDST <= 0;
    Jump<=0;
    ALUCNTRL <= 4'd9; //subtract
end
if(instr[31:26] == 6'h0B)
begin
    ALUSRC <= 0;
    MemtoReg <= 0;
    RegWrite <= 0;
    MemWrite <= 0;
    Branch <= 1;
    RegDST <= 0;
    Jump<=0;
    ALUCNTRL <= 4'd11; //subtract
end

if(instr[31:26] == 6'h08)
begin
    ALUSRC <= 0;
    MemtoReg <= 0;
    RegWrite <= 1;
    MemWrite <= 0;
    Branch <= 0;
    RegDST <= 0;
    Jump<=0;
    ALUCNTRL <= 4'd3;
end
end

if(instr[31:26] == 6'h0c | instr[31:26] == 6'h3f)
begin
if(instr[31:26]==6'h3f)
begin
Halt <= 1;
end
ALUSRC <= 0;
MemtoReg <= 0;
RegWrite <= 0;
MemWrite <= 0;
Branch <= 1;
Jump <= 1;
ALUCNTRL <= 4'd12;
end
end

endmodule