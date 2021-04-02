module Division (Out, In_A, In_B, valid_in, valid_out);

input valid_in; 
input [31:0] In_A, In_B;
output reg [31:0] Out;
output reg valid_out;

reg [7:0] Exponent, Exponent_Temp;
reg [47:0] Fraction_Temp, Dividend_Frac, Divisor_Frac;
reg [22:0] Fraction;
reg Sign;

always @(In_A or In_B or valid_in) begin
	valid_out <= 0;
	if (valid_in) begin
		if (In_A == 32'b0 && In_B == 32'b0) // 0/0
			Out = 32'bz;
		else if (In_A == 32'b0) // 0/B
			Out = 32'b0;
		else if (In_B == 32'b0) // A/0
			Out = 32'bz;
		else begin // A/B
			Sign = In_A[31] ^ In_B[31]; // Sign
			Exponent_Temp = In_A[30:23] - In_B[30:23] + 8'd127; // Expotent
			Dividend_Frac = {1'b1, In_A[22:0], 24'b0}; 
			Divisor_Frac = {24'b0,1'b1, In_B[22:0]};
			Fraction_Temp = Dividend_Frac / Divisor_Frac; // Division
			if (Fraction_Temp[23] == 1'b1) begin 
				Fraction = Fraction_Temp[22:0];
				Exponent = Exponent_Temp - 8'd1;
			end
			else begin 
				Fraction = Fraction_Temp[23:1];
				Exponent = Exponent_Temp;
			end
			Out = {Sign, Exponent, Fraction};
		end
		valid_out <= 1;
	end
end	
endmodule
