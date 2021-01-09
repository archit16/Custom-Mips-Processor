`timescale 1ns / 1ps

module main_test(
    );
reg clk, reset;
wire Halt;

processor uut(clk, reset, Halt);
initial begin
forever
begin
clk = 0;
#10 clk = 1;
#10 clk = 0; 
end
end
initial begin
reset = 1;
#15
reset = 0;
end

always @(posedge clk)
begin
if(Halt)
begin
$finish;
end
end
endmodule
