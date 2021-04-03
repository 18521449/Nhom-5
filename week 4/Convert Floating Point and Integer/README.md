## Convert_FloatingPoint_to_Integer Module
module Convert_FloatingPoint_to_Integer (Int, FP, valid_in, valid_out);

input valid_in;
input [31:0] FP;
output [8:0] Int;
output reg valid_out;

assign Int = Int_temp;
reg [7:0] Int_temp;
reg [22:0] FP_temp;
reg [7:0] shift;

always @(FP or valid_in) begin
	valid_out = 0;
	if (valid_in) begin
		shift = 8'd23 - (FP[30:23] - 8'd127);
		FP_temp = {1'b1,FP[22:0]} >> shift;
		Int_temp = FP_temp[8:0];
		valid_out = 1;
	end
end

endmodule


## Convert_Integer_to_FloatingPoint Module
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

