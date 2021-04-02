module Block2 (delta, out_max, in_max, min, r, g, b, t0_h, t0_s, t0_v, h_add, valid_in, valid_out, clk, rst);

input clk, rst, valid_in;
input [31:0] in_max, min, r, g, b;
output reg [31:0] t0_h, t0_s, t0_v, h_add, delta;
output reg [31:0] out_max;
output reg valid_out;


wire [31:0] delta_temp, t0_s_temp, t0_v_temp;
wire valid_out_sub, valid_out_div, valid_out_mul;

Addition sub (delta_temp, in_max, {1'b1, min[30:0]}, valid_in, valid_out_sub); // delta = max - min
Division div (t0_s_temp, 32'h42c80000, in_max, valid_in, valid_out_div); // t0_s = 100 / max
Multiply mul (t0_v_temp, 32'h42c80000, in_max, valid_in, valid_out_mul); // t0_v = 100 * max

wire [31:0] g_b, b_r, r_g;
wire valid_out_sub1, valid_out_sub2, valid_out_sub3;
Addition sub1 (g_b, g, {1'b1, b[30:0]}, valid_in, valid_out_sub1);
Addition sub2 (b_r, b, {1'b1, r[30:0]}, valid_in, valid_out_sub2);
Addition sub3 (r_g, r, {1'b1, g[30:0]}, valid_in, valid_out_sub3);


always @(posedge clk or negedge rst) begin
	if (!rst) begin
		t0_h <= 32'd0;
		t0_s <= 32'd0;
		t0_v <= 32'd0;
		h_add <= 32'd0;
		delta <= 32'd0;
		valid_out <= 0;
	end
	else begin
		valid_out <= 1'b0;
		delta <= delta_temp;
		t0_s <= t0_s_temp;
		t0_v <= t0_v_temp;
		if (valid_out_sub1 && valid_out_sub2 && valid_out_sub3) begin
			if (in_max == r) begin
				t0_h <= g_b;
				if (g[30:23] == b[30:23]) begin
					if (g[22:0] < b[22:0])
						h_add <= 32'h43b40000; // h_add = 360
					else h_add <= 32'd0;
				end
				else begin
					if (g[30:23] < b[30:23])
						h_add <= 32'h43b40000; // h_add = 360
					else h_add <= 32'd0;
				end
			end
			else if (in_max == g) begin
				t0_h <= b_r;
				h_add <= 32'h42f00000; // h_add = 120
			end
			else if (in_max == b) begin
				t0_h <= r_g;
				h_add <= 32'h43700000; // h_add = 240
			end
		end
		if (valid_out_sub1 && valid_out_sub2 && valid_out_sub3 && valid_out_sub && valid_out_div && valid_out_mul) begin
			out_max <= in_max;
			valid_out <= 1;
		end
	end
end
endmodule		
	