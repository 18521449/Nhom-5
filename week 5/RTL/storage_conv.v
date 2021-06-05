module storage_conv (clk, rst, valid_in, data, kernel, valid_out);
`include "params.sv"

input clk;
input rst;
input valid_in;
input [DATA_WIDTH-1:0] data;
output [DATA_WIDTH*9-1:0] kernel;
output reg valid_out;

// Reg de luu kernel
reg [DATA_WIDTH-1:0] storage [0:8];

integer i = 0;
integer k, count;
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		for (k=0; k<9; k=k+1) begin
			storage[k] <= 32'd0;
		end
	end
	else begin
		if (valid_in) begin
			if (i == 8) begin
				valid_out <= 1;
				i = 0;
			end
			else begin
				if (i<8) begin
					valid_out <= 0;
					i = i + 1;
				end
			end
			for (count=8; count>0; count=count-1) begin
				storage[count] = storage[count-1];
			end
			storage[0] = data;
		end
	end
end

assign kernel[31:0] = (valid_out) ? storage[8] : 32'dz;
assign kernel[63:32] = (valid_out) ? storage[7] : 32'dz;
assign kernel[95:64] = (valid_out) ? storage[6] : 32'dz;
assign kernel[127:96] = (valid_out) ? storage[5] : 32'dz;
assign kernel[159:128] = (valid_out) ? storage[4] : 32'dz;
assign kernel[191:160] = (valid_out) ? storage[3] : 32'dz;
assign kernel[223:192] = (valid_out) ? storage[2] : 32'dz;
assign kernel[255:224] = (valid_out) ? storage[1] : 32'dz;
assign kernel[287:256] = (valid_out) ? storage[0] : 32'dz;
endmodule 
