module Block5 (h, s, v, t2_h, t2_s, t2_v, h_add, valid_in, valid_out, clk, rst);

input clk, rst, valid_in;
input [31:0] t2_h, t2_s, t2_v, h_add;
output reg [31:0] h, s, v;
output reg valid_out;

wire [31:0] h_temp;
wire valid_out_add;
Addition add (h_temp, t2_h, h_add, valid_in, valid_out_add);

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		h <= 32'd0;
		s <= 32'd0;
		v <= 32'd0;
		valid_out <= 1'b0;
	end
	else begin
		valid_out <= 0;
		if (valid_out_add) begin
			h <= h_temp;
			s <= t2_s;
			v <= t2_v;
			valid_out <= 1;
		end
	end
end
endmodule
	