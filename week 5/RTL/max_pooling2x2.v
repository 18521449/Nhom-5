module max_pooling2x2 
	#(	parameter WIDTH = 4)
	(	input clk,
		input rst,
		input valid_in,
		input [DATA_WIDTH-1:0] data,
		output [DATA_WIDTH-1:0] data_out,
		output valid_out		
	);
`include "params.sv"

wire [DATA_WIDTH*4-1:0] pixel_bus;
wire load_data_done;

// Line Buffer
lines_buffer_maxpool 
		#(	.WIDTH(WIDTH))
	LinesBuffer
		(	.clk(clk), 
			.rst(rst), 
			.valid_in(valid_in), 
			.data(data), 
			.pixel(pixel_bus),
			.valid_out(load_data_done)
		);

max_fp_4input max_pool
		(	.max(data_out), 
			.data(pixel_bus), 
			.valid_in(load_data_done)
		);

assign valid_out = load_data_done;
endmodule


