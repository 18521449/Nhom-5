module rgb2hsv (

input clk,
input rst,
input valid_in,
input [31:0] r,
input [31:0] g,
input [31:0] b,
output reg [31:0] h,
output reg [31:0] s,
output reg [31:0] v,
output reg valid_out,
output valid_out_H, 
output valid_out_S, 
output valid_out_V);

//----------------------- Var -----------------||
wire [31:0] max, min;
wire [31:0] delta;
wire valid_out_m, valid_out_d/*, valid_out_H, valid_out_S, valid_out_V*/;
wire [31:0] Hue, Sat, Val;

MaxMin M (max, min, r, g, b, valid_in, valid_out_m);
Addition Delta (delta, max, {1'b1, min[30:0]}, valid_out_m, valid_out_d);
Hue H (Hue, r, g, b, max, delta, valid_out_d, valid_out_H);
Saturation S (Sat, delta, max, valid_out_d, valid_out_S);
Value V (Val, max, valid_out_d, valid_out_V);

always @(posedge clk or negedge rst) begin
	if (~rst) begin 
		h <= 32'd0;
		s <= 32'd0;
		v <= 32'd0;
		valid_out <= 0;
	end
	else begin
		valid_out = 0;
		if (valid_out_H && valid_out_S && valid_out_V) begin
			valid_out <= 1;
			h <= Hue;
			s <= Sat;
			v <= Val;
		end			
	end
end

endmodule
