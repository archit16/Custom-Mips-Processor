`timescale 1ns / 1ps

module Register_File(input clk, [4:0]a1, a2, a3, [31:0]wd3, input regwrite, output reg [31:0]rd1, rd2);
reg [31:0] regfile[31:0];
integer i;
initial begin
rd1 <= 0;
rd2 <= 0;
regfile[0] <= 0;
for(i=0; i<32; i=i+1) begin
regfile[i] <= i;
end
end 

always@(posedge clk)
begin
    if(regwrite)
    begin
        if(a3!=0)
        begin
            regfile[a3] <= wd3; 
        end
        else
        $display("Cannot write to register 0");
    end
end
always@(negedge clk)
begin
    rd1 = regfile[a1];
    rd2 = regfile[a2];
end


endmodule