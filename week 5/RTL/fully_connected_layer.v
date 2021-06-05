module fully_connected_layer
	#(	parameter NODES_OUTPUT = 2) // 4096 nodes_output
	(	input clk,
		input rst,
		input valid_in,
		input [DATA_WIDTH-1:0] data,
		input [DATA_WIDTH-1:0] weight,
		output [DATA_WIDTH-1:0] data_out,
		output reg valid_out
	);
`include "params.sv"
endmodule 
