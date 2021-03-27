module Value (v, max, valid_in, valid_out);

input [31:0] max;
input valid_in;
output reg valid_out;
output reg [31:0] v;

wire [31:0] Mul_v, q_v;
wire vout_mul_v, vout_Val;
//----------------------------------------||
//----------------- Tim v ----------------||
// v = max * 100 / 255;
Multiply mul_v (Mul_v, max, 32'h42c80000, valid_in, vout_mul_v);
Division Val (q_v, Mul_v, 32'h437f0000, vout_mul_v, vout_Val);
//------------------------------------------------------------------------\\

always @(*) begin 
	valid_out = 0;
	if (vout_Val) begin 
		v = q_v;
		valid_out = 1;
	end
end

endmodule
