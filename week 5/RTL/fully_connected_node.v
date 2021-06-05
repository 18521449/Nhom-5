module fully_connected_node 
	#(	parameter NODES_INPUT = 5) // 7*7*512 = 25088 nodes_input
	(	input clk,
		input rst,
		input valid_in,
		input [DATA_WIDTH-1:0] data,
		input [DATA_WIDTH-1:0] weight,
		input [DATA_WIDTH-1:0] bias,
		output [DATA_WIDTH-1:0] node,
		output [DATA_WIDTH-1:0] mul,
		output [DATA_WIDTH-1:0] sum,
		output reg [DATA_WIDTH-1:0] temp,
		output reg load_weight_done,
		output reg valid_out
	);
`include "params.sv"

reg valid_mul_weight, valid_add_bias;
wire valid_out_add;
//wire [DATA_WIDTH-1:0] mul;
//wire [DATA_WIDTH-1:0] sum;
//reg [DATA_WIDTH-1:0] temp;

integer i = 0;
integer k;
always @(posedge clk or negedge rst) begin
	if (!rst) begin
	//	temp <= 32'd0;
	end
	else begin
		if (valid_in) begin
			if (i < NODES_INPUT-1) begin
				valid_mul_weight <= 1;
			end
			else begin
				if (i == NODES_INPUT-1) begin
					load_weight_done <= 1;
				end
				if (i == NODES_INPUT) begin
					load_weight_done <= 0;
					valid_mul_weight <= 0;
					valid_add_bias <= 1;
					valid_out <= 1;
				end
				if (i == NODES_INPUT + 1) begin
					valid_add_bias <= 0;
					valid_out <= 0;
					i = 0;
				end
			end
			i = i + 1;
		end
	end	
end

always @(valid_out_add) begin
//	if (i == 0) begin
//		temp <= 32'd0;
//	end
		temp <= sum;
end

multiple_fp muls (mul, weight, data, valid_mul_weight);
addition_fp adds (sum, temp, mul, valid_mul_weight);

addition_fp add_bias (node, temp, bias, valid_add_bias);

endmodule
