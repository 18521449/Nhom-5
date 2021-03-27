module Multiply (Out, In_A, In_B, valid_in, valid_out);

input valid_in;
input [31:0] In_A, In_B;
output reg [31:0] Out;
output reg valid_out;

reg [7:0] Exponent, Exponent_Temp;
reg [47:0] Fraction_Temp; 
reg [23:0] Frac_A, Frac_B;
reg [22:0] Fraction;
reg Sign;

always @(In_A or In_B or valid_in) begin
	valid_out = 0;
	if (valid_in) begin
		if (In_A == 32'b0 || In_B == 32'b0)
			Out = 32'b0;
		else begin
			Sign = In_A[31] ^ In_B[31]; //sign
			Exponent_Temp = In_A[30:23] + In_B[30:23] - 8'd127; //Exponent
			Frac_A  = {1'b1, In_A[22:0]};
			Frac_B  = {1'b1, In_B[22:0]};
			Fraction_Temp = Frac_A * Frac_B; // Multiply
			if (Fraction_Temp[47] == 0) begin
				Fraction = Fraction_Temp[45:23];
				Exponent = Exponent_Temp;
			end
			else begin
				Fraction = Fraction_Temp[46:24];
				Exponent = Exponent_Temp + 8'd1;
			end
			Out = {Sign, Exponent, Fraction};
		end
		valid_out = 1;
	end
end
endmodule

