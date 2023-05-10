module gold_code_generator(
    input wire clk,
    input wire reset_n,
    output wire gold_code_out
);
wire [9:0] gold_code;
parameter n = 10; // 寄存器长度
parameter taps1 = 10'b1000001001; // 第一个多项式的反馈系数
parameter taps2 = 10'b1100000000; // 第二个多项式的反馈系数

reg [n-1:0] shift_reg1, shift_reg2;

integer i;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        shift_reg1 <= 10'b1111111111;
        shift_reg2 <= 10'b1111111111;
    end else begin
        // LFSR 1 更新
        shift_reg1 <= {shift_reg1[n-2:0], shift_reg1[n-1]^shift_reg1[2]^shift_reg1[9]};
        
        // LFSR 2 更新
        shift_reg2 <= {shift_reg2[n-2:0], shift_reg2[n-1]^shift_reg2[1]^shift_reg2[8]^shift_reg2[9]};
    end
end

assign gold_code = shift_reg1 ^ shift_reg2;
assign gold_code_out = gold_code[9];
endmodule
