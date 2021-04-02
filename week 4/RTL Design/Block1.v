module Block1 (max, min, out_r, out_g, out_b, r, g, b, valid_in, valid_out, clk, rst);

input clk, rst, valid_in;
input [31:0] r, g, b;
output reg [31:0] max, min;
output reg [31:0] out_r, out_g, out_b;
output reg valid_out;

wire [31:0] max_temp, min_temp;
wire valid_out_m;
MaxMin m (max_temp, min_temp, r, g, b, valid_in, valid_out_m);

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		max <= 32'd0;
		min <= 32'd0;
		valid_out <= 0;
	end
	else begin
		valid_out <= 0;
		if (valid_out_m) begin
			out_r <= r;
			out_g <= g;
			out_b <= b;
			max <= max_temp;
			min <= min_temp;
			valid_out <= 1;
		end
	end
end
endmodule
	