module lines_buffer_conv 
	#(	parameter IMAGE_WIDTH = 5)
	(	input clk,
		input rst_n,
		input valid_in,
		input [DATA_WIDTH-1:0] data,
		output reg [DATA_WIDTH-1:0] d0,
		output reg [DATA_WIDTH-1:0] d1,
		output reg [DATA_WIDTH-1:0] d2,
		output reg [DATA_WIDTH-1:0] d3,
		output reg [DATA_WIDTH-1:0] d4,
		output reg [DATA_WIDTH-1:0] d5,
		output reg [DATA_WIDTH-1:0] d6,
		output reg [DATA_WIDTH-1:0] d7,
		output reg [DATA_WIDTH-1:0] d8,
		output reg valid_out
	);
`include "params.sv"

parameter WIDTH = IMAGE_WIDTH+1;
reg [DATA_WIDTH-1:0] Register [0:2*WIDTH+2];

integer i = 0;
integer k, count;
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin	
		for (k=0; k<2*WIDTH+2; k=k+1) begin
			Register[k] <= 32'd0;
		end
	end
	else begin
		if (valid_in) begin
			if (i == 2*WIDTH+3) begin
				i = WIDTH+3;
			end
			if (row == 0) begin // row = 0 
				for (k=0; k<WIDTH; k=k+1) begin
					Register[k] <= 32'd0;
				end
				i = WIDTH;
			end
			else if (col == 0) begin
				Register[0] <= 32'd0;
				i = i + 1;
			end
			else if (row == WIDTH) begin
				Register[0] <= 32'd0;
			end
			else if (col == WIDTH) begin
				Register[0] <= 32'd0;
			end	
			if (i<2*WIDTH+3) begin
				for (count=2*WIDTH+2; count>0; count=count-1) begin
					Register[count] = Register[count-1];
				end
				i = i + 1;
				Register[0] = data;
			end
		end
	end
end

integer j;
always @(posedge clk) begin
	if (i == 2*WIDTH+2) begin
		valid_out <= 1;
		j = 0;
	end
	else begin
		if (j<WIDTH-2 && j>=0) begin
			j = j + 1;
		end
		else begin
			valid_out <= 0;
			j = -1;
		end
	end
end

always @(posedge clk) begin
	d0 <= (valid_out) ? Register[WIDTH*2+2] : 32'dz;
	d1 <= (valid_out) ? Register[WIDTH*2+1] : 32'dz;
	d2 <= (valid_out) ? Register[WIDTH*2+0] : 32'dz;
	d3 <= (valid_out) ? Register[WIDTH+2] : 32'dz;
	d4 <= (valid_out) ? Register[WIDTH+1] : 32'dz;
	d5 <= (valid_out) ? Register[WIDTH+0] : 32'dz;
	d6 <= (valid_out) ? Register[2] : 32'dz;
	d7 <= (valid_out) ? Register[1] : 32'dz;
	d8 <= (valid_out) ? Register[0] : 32'dz;
end

//assign data_padding = (padding_control) ? 32'd0 : data;

integer row = 0; // hang 
integer col = 0; // cot

always @(posedge clk) begin
	if (col < WIDTH) begin
		col = col + 1;
	end
	else begin
		if (col == WIDTH) begin
			col = 0;
			row = row + 1;
		end
	end
	if (row == 0) begin
		col = WIDTH;
	end
	else begin
		if (col==WIDTH && row==WIDTH) begin
			row = 0;
		end
	end
end

endmodule

