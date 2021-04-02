module rgb2hsv (h, s, v, r, g, b, valid_in, valid_out, clk, rst);

input clk, rst, valid_in;
input [31:0] r, g, b;
output reg [31:0] h, s, v;
output reg valid_out;

wire [31:0] max, min, out_r, out_g, out_b;
wire [31:0] out_max_1, delta, t0_h, t0_s, t0_v, h_add;
wire [31:0] out_max_2, out_delta, t1_h, t1_s, t1_v, out_h_add_1;
wire [31:0] t2_h, t2_s, t2_v, out_h_add_2;
wire [31:0] h_temp, s_temp, v_temp;
wire valid_out_B1, valid_out_B2, valid_out_B3, valid_out_B4, valid_out_B5;

reg [31:0] Reg1 [0:7];
reg [31:0] Reg2 [0:7];
reg [31:0] Reg3 [0:7];
reg [31:0] Reg4 [0:7];
reg VReg1, VReg2, VReg3, VReg4;

always @ (posedge clk) begin
// Reg 1
	Reg1[0] <= max;
	Reg1[1] <= min;
	Reg1[2] <= out_r;
	Reg1[3] <= out_g;
	Reg1[4] <= out_b;
	VReg1 <= valid_out_B1;
// Reg 2
	Reg2[0] <= out_max_1;
	Reg2[1] <= delta;
	Reg2[2] <= t0_h;
	Reg2[3] <= t0_s;
	Reg2[4] <= t0_v;
	Reg2[5] <= h_add;
	VReg2 <= valid_out_B2;
// Reg 3
	Reg3[0] <= out_max_2;
	Reg3[1] <= out_delta;
	Reg3[2] <= t1_h;
	Reg3[3] <= t1_s;
	Reg3[4] <= t1_v;
	Reg3[5] <= out_h_add_1;
	VReg3 <= valid_out_B3;
// Reg 4
	Reg4[0] <= t2_h;
	Reg4[1] <= t2_s;
	Reg4[2] <= t2_v;
	Reg4[3] <= out_h_add_2;
	VReg4 <= valid_out_B4;
end

Block1 B1 (max, min, out_r, out_g, out_b, r, g, b, valid_in, valid_out_B1, clk, rst);
Block2 B2 (delta, out_max_1, Reg1[0], Reg1[1], Reg1[2], Reg1[3], Reg1[4], t0_h, t0_s, t0_v, h_add, VReg1, valid_out_B2, clk, rst);
Block3 B3 (out_delta, Reg2[1], out_max_2, Reg2[0], Reg2[2], Reg2[3], Reg2[4], t1_h, t1_s, t1_v, out_h_add_1, Reg2[5], VReg2, valid_out_B3, clk, rst);
Block4 B4 (Reg3[0], Reg3[1], Reg3[2], Reg3[3], Reg3[4], t2_h, t2_s, t2_v, out_h_add_2, Reg3[5], VReg3, valid_out_B4, clk, rst);
Block5 B5 (h_temp, s_temp, v_temp, Reg4[0], Reg4[1], Reg4[2], Reg4[3], VReg4, valid_out_B5, clk, rst);

always @(posedge clk or negedge rst) begin
	if (~rst) begin 
		h <= 32'd0;
		s <= 32'd0;
		v <= 32'd0;
		valid_out <= 0;
	end
	else begin
		valid_out <= 0;
		if (valid_out_B5) begin
			h <= h_temp;
			s <= s_temp;
			v <= v_temp;
			valid_out <= 1;
		end
		else begin
			h <= 32'dz;
			s <= 32'dz;
			v <= 32'dz;
			valid_out <= 0;
		end
	end
end

endmodule
