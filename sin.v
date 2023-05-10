`timescale 1ns / 1ps

module sin(
	clk,
	reset_n,
	Pword,
	sine_out
);

input clk;
input reset_n;
input [10:0] Pword;
output [11:0] sine_out;

wire [31:0] Fword = 17620190;//2的32次方-1;

wire [11:0] wave_data;
reg  [11:0] wave_data_r;
reg  [31:0] Fcnt;//Fcnt是相位累加器，频率控制数字对他起作用；
wire [10:0] rom_addr;

reg [10:0] rom_addr_reg;
wire pword_uprising_edge;//Pword跳变的标志
wire pword_down_edge;//Pword跳变的标志

reg  p_word_msb_reg;
always@(posedge clk or negedge reset_n)begin
	if(!reset_n)
		p_word_msb_reg <= 1'b0;
	else
		p_word_msb_reg <= Pword[10];
end

assign pword_uprising_edge = ~p_word_msb_reg & Pword[10];
assign pword_down_edge = p_word_msb_reg & ~Pword[10];
/*在上升沿时将rom_addr_reg赋值为1024，即将相位累加器Fcnt的值清零，这样就可以实现相位的切换了。*/
always @(posedge clk)
begin
        rom_addr_reg <= rom_addr;
end

assign sine_out=wave_data_r;
assign rom_addr = Fcnt[31:21];

always@(posedge clk or negedge reset_n)begin
	if(!reset_n)
		Fcnt <= 32'd0;
	else if(pword_uprising_edge)begin
		Fcnt <= {11'd1024,21'd0};
	end
	else if(pword_down_edge)begin
		Fcnt <= {11'd0,21'd0};
	end
		else
		Fcnt <= Fcnt + Fword;
end
always @(posedge clk)
begin
	wave_data_r <= wave_data;
end

my_rom rom1(
    .address(rom_addr_reg),
    .clock(clk),
    .q(wave_data)
    );

endmodule
