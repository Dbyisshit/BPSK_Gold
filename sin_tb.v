`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/07 09:22:53
// Design Name: 
// Module Name: sin_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sin_tb();
reg clk;
reg reset_n;
reg digital_in;
wire [11:0] sine_out;

sin sin0(
    .clk(clk),
    .reset_n(reset_n),
    .digital_in(digital_in),
    .sine_out(sine_out)
    );


initial begin
    clk = 0;
    reset_n = 0;
    digital_in = 0;
    reset_n = 0;
    #1000;
    reset_n = 1;
end

integer i,j;
initial begin
for(j=0;j<10;j=j+1)begin
for(i=0;i<2000;i=i+1)begin
    #2;
    clk = ~clk;
end
digital_in = ~digital_in;
end
end

endmodule
