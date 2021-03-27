module Saturation (s, delta, max, valid_in, valid_out);

input [31:0] delta, max;
input valid_in;
output reg valid_out;
output reg [31:0] s;

wire [31:0] Mul_s, q_s;
wire vout_mul_s, vout_Sat;
//----------------------------------------||
//----------------- Tim s ----------------||
// s = (max == 0) ? 32'd0 : delta * 100 / max;
Multiply mul_s (Mul_s, delta, 32'h42c80000, valid_in, vout_mul_s);
Division Sat (q_s, Mul_s, max, vout_mul_s, vout_Sat);
//----------------------------------------||

always @(*) begin
	valid_out = 0;
	if (max == 0 || delta == 0) begin
		s = 32'd0;
		valid_out = 1;
	end
	else begin
		if (vout_Sat) begin
			s = q_s;
			valid_out = 1;
		end
	end
end

endmodule
