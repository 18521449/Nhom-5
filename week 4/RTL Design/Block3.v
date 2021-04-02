module Block3 (out_delta, in_delta, out_max, in_max, t0_h, t0_s, t0_v, t1_h, t1_s, t1_v, out_h_add, in_h_add, valid_in, valid_out, clk, rst);

input clk, rst, valid_in;
input [31:0] in_max, in_delta, t0_h, t0_s, t0_v, in_h_add;
output reg [31:0] t1_h, t1_s, t1_v;
output reg [31:0] out_delta, out_max, out_h_add;
output reg valid_out;

wire [31:0] t1_h_temp, t1_s_temp, t1_v_temp;
wire valid_out_mul1, valid_out_mul2, valid_out_div;
Multiply mul1 (t1_h_temp, 32'h42700000, t0_h, valid_in, valid_out_mul1); //t1_h = 60.t0_h
Multiply mul2 (t1_s_temp, in_delta, t0_s, valid_in, valid_out_mul2);			//t1_s = delta.t0_s
Division div (t1_v_temp, t0_v, 32'h437f0000, valid_in, valid_out_div); 	//t1_v = t0_v/255

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		t1_h <= 32'd0;
		t1_s <= 32'd0;
		t1_v <= 32'd0;
		valid_out <= 1'b0;
	end
	else begin
		valid_out <= 1'b0;
		if (valid_out_mul1 && valid_out_mul2 && valid_out_div) begin
			out_delta <= in_delta;
			out_max <= in_max;
			out_h_add <= in_h_add;
			t1_h <= t1_h_temp;
			t1_s <= t1_s_temp;
			t1_v <= t1_v_temp;
			valid_out <= 1'b1;
		end
	end
end
endmodule		
	