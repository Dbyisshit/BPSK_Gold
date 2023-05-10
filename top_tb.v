`timescale 1ps / 1ps

module top_tb();
reg sys_clk;
reg code_clk;
reg reset_n;

wire [11:0] sine_out;

top top_inst0(
    .sys_clk(sys_clk),
    .code_clk(code_clk),
    .reset_n(reset_n),
    .sine_out(sine_out)
    );

        initial begin
        sys_clk = 0;
        code_clk = 0;
        reset_n = 0;
        #100000;
        reset_n = 1;
    end

    initial begin
        #100000
        forever begin
            #200 sys_clk = ~sys_clk;
        end
    end
    initial begin
        #1000
        forever begin
            #243902 code_clk = ~code_clk;
        end
    end
endmodule
