module padding2 
	#(	parameter WIDTH = 224)
	(	input clk,
		input rst,
		input valid_in,
		input [DATA_WIDTH-1:0] data,
		output [DATA_WIDTH-1:0] data_out,
		output reg valid_out
	);
`include "params.sv"

integer i;
always @(posedge clk or negedge rst) begin
	if (!rst) begin
	end
end
endmodule	