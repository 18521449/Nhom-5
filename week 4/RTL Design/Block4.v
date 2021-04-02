module Block4 (max, delta, t1_h, t1_s, t1_v, t2_h, t2_s, t2_v, out_h_add, in_h_add, valid_in, valid_out, clk, rst);

input clk, rst, valid_in;
input [31:0] max, delta, t1_h, t1_s, t1_v, in_h_add;
output reg [31:0] t2_h, t2_s, t2_v;
output reg [31:0] out_h_add;
output reg valid_out;

wire [31:0] h_temp;
wire valid_out_div;

Division div (h_temp, t1_h, delta, valid_in, valid_out_div); // t1_h / delta

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		t2_h <= 32'd0;
		t2_s <= 32'd0;
		t2_v <= 32'd0;
		valid_out <= 1'b0;
	end
	else begin
		valid_out <= 1'b0;
		if (valid_out_div) begin
			if (max == 0 || delta == 0) begin
				t2_h <= 32'd0;
				t2_s <= 32'd0;
			end
			else begin
				t2_h <= h_temp;
				t2_s <= t1_s;
			end
			t2_v <= t1_v;
			out_h_add <= in_h_add;
			valid_out <= 1'b1;
		end
	end
end
endmodule		
	