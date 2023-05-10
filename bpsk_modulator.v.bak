`timescale 1ns / 1ps

module bpsk_modulator (
    input sys_clk,
    input digital_in,
    input rst_n,
    output [11:0] bpsk_out
);

reg [10:0] pword;
wire [11:0] sine_out;

// Instantiate the sin module
sin sin_inst (
    .clk(sys_clk),
    .reset_n(rst_n),
    .Pword(pword),
    .sine_out(sine_out)
);

// Set Pword based on digital_in
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        pword <= 11'd0;
    end else begin
        pword <= digital_in ? 11'd1024 : 11'd0; // Phase change based on digital_in
    end
end

// Assign bpsk_out
assign bpsk_out = sine_out;

endmodule
