module Convert_Integer_to_FloatingPoint (FP, Int, valid_in, valid_out);

input valid_in;
input [8:0] Int;
output [31:0] FP;
output reg valid_out;

assign FP = {1'b0, Exp, Frac};
reg [7:0] Exp;
reg [22:0] Frac;
reg [8:0] Int_temp;
reg [7:0] i;

always @(FP or valid_in) begin
	valid_out = 0;
	if (valid_in) begin
		Int_temp = Int;
		i = 8'd0;
		while (Int_temp != 0) begin
			Int_temp = Int_temp >> 1;
			i = i + 1;
		end
		Exp = 8'd127 + i - 1;
		Frac = Int << (23 - i + 1);
		valid_out = 1;
	end
end

endmodule
