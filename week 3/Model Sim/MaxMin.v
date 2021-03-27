module MaxMin (max, min, r, g, b, valid_in, valid_out);

input [31:0] r, g, b;
input valid_in;
output reg valid_out;
output reg [31:0] max, min;

always @(r or g or b or valid_in) begin
	valid_out = 0;
	if (valid_in) begin
//--------------- Tim Max -----------------\\
		if (r[30:23] == g[30:23]) begin
			if (r[22:0] >= g[22:0])
				max = r;
			else max = g;
		end
		else begin
			if (r[30:23] > g[30:23])
				max = r;
			else max = g;
		end
		if (b[30:23] == max[30:23]) begin
			if (b[22:0] > max[22:0])
				max = b;
		end
		else begin
			if (b[30:23] > max[30:23])
				max = b;
		end
		if (g[30:23] == max[30:23]) begin
			if (g[22:0] > max[22:0])
				max = g;
		end
		else begin 
			if (g[30:23] > max[30:23])
				max = g;
		end
//----------------------------------------\\
//--------------- Tim Min -----------------\\
		if (r[30:23] == g[30:23]) begin
			if (r[22:0] <= g[22:0])
				min = r;
			else min = g;
		end
		else begin
			if (r[30:23] < g[30:23])
				min = r;
			else min = g;
		end
		if (b[30:23] == min[30:23]) begin
			if (b[22:0] < min[22:0])
				min = b;
		end
		else begin
			if (b[30:23] < min[30:23])
				min = b;
		end
		if (g[30:23] == min[30:23]) begin
			if (g[22:0] < min[22:0])
				min = g;
		end
		else begin 
			if (g[30:23] < min[30:23])
				min = g;
		end
		valid_out = 1;
	end
	else valid_out = 0;
end

endmodule
