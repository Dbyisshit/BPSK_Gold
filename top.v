`timescale 1ns / 1ps

module top(sys_clk,code_clk,reset_n,sine_out);

input sys_clk;
input code_clk;
input reset_n;
output [11:0] sine_out;
wire digital_in;

bpsk_modulator bpsk_modulator0(
    .sys_clk(sys_clk),
    .digital_in(digital_in),
    .rst_n(reset_n),
    .bpsk_out(sine_out)
    );

gold_code_generator gold_code_generator0(
    .clk(code_clk),
    .reset_n(reset_n),
    .gold_code_out(digital_in)
    );

endmodule
