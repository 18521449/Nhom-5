module lines_buffer_maxpool
	#(	parameter WIDTH = 4)
	(	input clk,
		input rst,
		input valid_in,
		input [DATA_WIDTH-1:0] data,
		output [DATA_WIDTH*4-1:0] pixel,
		output reg valid_out
	);
`include "params.sv"
	
reg [DATA_WIDTH-1:0] Register [0:2*WIDTH-1];
reg [DATA_WIDTH*4-1:0] Temp;

integer i = 0;
integer k, count;
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		for (k=0; k<2*WIDTH-1; k=k+1) begin
			Register[k] <= 32'd0;
		end
	end
	else begin
		if (valid_in) begin
			if (i == 2*WIDTH) begin
				i = 0;
			end
			if (i<2*WIDTH) begin
				for (count=2*WIDTH-1; count>0; count=count-1) begin
					Register[count] = Register[count-1];
				end
				i = i + 1;
				Register[0] = data;
			end
		end
	end
end

integer j = -1;
always @(posedge clk) begin
	if (i == 2*WIDTH) begin
		valid_out <= 1;
		j = 0;
	end
	else begin
		if (j%2 == 0 && j >=0) begin
			valid_out <= 0;
			j = j + 1;
		end
		else begin
			if (j%2 == 1 && j >=0) begin
				valid_out <= 1;
				j = j + 1;
			end
		end
	end
	if (j == WIDTH-1) begin
		valid_out <= 0;
		j = -1;
	end
end

always @(posedge clk) begin
	Temp[DATA_WIDTH*1-1:DATA_WIDTH*0] <= Register[WIDTH*2-1];
	Temp[DATA_WIDTH*2-1:DATA_WIDTH*1] <= Register[WIDTH*2-2];
	Temp[DATA_WIDTH*3-1:DATA_WIDTH*2] <= Register[WIDTH-1];
	Temp[DATA_WIDTH*4-1:DATA_WIDTH*3] <= Register[WIDTH-2];
end

assign pixel = (valid_out) ? Temp : 127'dz;

endmodule

