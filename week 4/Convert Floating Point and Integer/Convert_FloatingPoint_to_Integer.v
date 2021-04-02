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