module Hue (h, r, g, b, max, delta, valid_in, valid_out);

input [31:0] r, g, b, max, delta;
input valid_in;
output reg valid_out;
output reg [31:0] h;

//------------------ Var -----------------||
wire [31:0] Sub_g_b, Sub_b_r, Sub_r_g;
wire [31:0] Mul_r, Mul_g, Mul_b, Mul_s, Mul_v;
wire [31:0] Div_r, Div_g, Div_b;
wire [31:0] h_r_g, h_r_b, h_g, h_b, q_s, q_v;
wire vout_sub_g_b, vout_sub_r_g, vout_sub_b_r;
wire vout_div_r, vout_div_g, vout_div_b;
wire vout_hue_r_b, vout_hue_r_g,  vout_hue_g, vout_hue_b;
wire vout_mul_r, vout_mul_g, vout_mul_b;

//----------------------------------------||
//----------------- Tim h ----------------||
//-------------- If max = r --------------||
// h = (g - b) * 60 / delta + ((g < b) ? 8'd360 : 8'd0);
	Addition sub_g_b (Sub_g_b, g, {1'b1, b[30:0]}, valid_in, vout_sub_g_b);
	Multiply mul_r (Mul_r, Sub_g_b, 32'h42700000, vout_sub_g_b, vout_mul_r);
	Division div_r (Div_r, Mul_r, delta, vout_mul_r, vout_div_r);
	Addition hue_r_b (h_r_b, Div_r, 32'h43b40000, vout_div_r, vout_hue_r_b); 	// g < b
	Addition hue_r_g (h_r_g, Div_r, 32'h0, vout_div_r, vout_hue_r_g); 			// g > b
//----------------------------------------||
//----------------- Tim h ----------------||
//-------------- Neu max = g -------------||
// h = (b - r) * 60 / delta + 8'd120;
	Addition sub_b_r (Sub_b_r, b, {1'b1, r[30:0]}, valid_in, vout_sub_b_r);
	Multiply mul_g (Mul_g, Sub_b_r, 32'h42700000, vout_sub_b_r, vout_mul_g);
	Division div_g (Div_g, Mul_g, delta, vout_mul_g, vout_div_g);
	Addition hue_g (h_g, Div_g, 32'h42f00000, vout_div_g, vout_hue_g);
//----------------------------------------||
//----------------- Tim h ----------------||
//-------------- Neu max = b -------------||
// h = (r - g) * 60 / delta + 8'd240;
	Addition sub_r_g (Sub_r_g, r, {1'b1, g[30:0]}, valid_in, vout_sub_r_g);
	Multiply mul_b (Mul_b, Sub_r_g, 32'h42700000, vout_sub_r_g, vout_mul_b);
	Division div_b (Div_b, Mul_b, delta, vout_mul_b, vout_div_b);
	Addition hue_b (h_b, Div_b, 32'h42f00000, vout_div_b, vout_hue_b);
//----------------------------------------||

always @(*) begin
	valid_out = 0;
	if (delta == 32'd0 || max == 0) begin
		h = 32'd0;
		valid_out = 1;
	end
	else begin
		if (max == r) 
		begin
		// So sanh g < b ?
			if (g[30:23] == b[30:23]) 
			begin
				if (g[22:0] < b[22:0])
					h = (vout_hue_r_b) ? h_r_b : h;
				else h = (vout_hue_r_g) ? h_r_g : h;
			end
			else begin
				if (g[30:23] < b[30:23])
					h = (vout_hue_r_b) ? h_r_b : h;
				else h = (vout_hue_r_g) ? h_r_g : h;
			end
		end
		// Neu max = g
		else begin
			if (max == g)
				h = (vout_hue_g) ? h_g : h;
			else h = (vout_hue_b) ? h_b : h;// Neu max = b
			//h = (r - g) * 60 / delta + 8'd240;
		end
		valid_out = 1;
	end
end

endmodule


