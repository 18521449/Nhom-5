module conv3x3_3D 
	#(	parameter WIDTH = 66)
	(	input clk,
		input rst,
		input valid_in,
		input load_kernel,
		input [DATA_WIDTH*3-1:0] data,
		input [DATA_WIDTH*3-1:0] kernel,
		input [DATA_WIDTH-1:0] bias,
		output [DATA_WIDTH-1:0] data_out,
		output reg valid_out
	);
`include "params.sv"

wire [DATA_WIDTH-1:0] pixel [0:2];
wire valid_out_2D [0:2];

genvar i;
generate 
	for (i=0; i<3; i=i+1) begin: conv3x3_2D_block
		conv3x3_2D 
			#(.WIDTH(WIDTH))
			conv
			(	.clk(clk),
				.rst(rst),
				.valid_in(valid_in),
				.load_kernel(load_kernel),
				.data(data[DATA_WIDTH*(i+1)-1:DATA_WIDTH*i]),
				.kernel(kernel[DATA_WIDTH*(i+1)-1:DATA_WIDTH*i]),
				.data_out(pixel[i]),
				.valid_out(valid_out_2D[i])
			);
	end
endgenerate

wire calculate;
reg [DATA_WIDTH-1:0] Sum;

assign calculate = valid_out_2D[2] & valid_out_2D[1] & valid_out_2D[0];
initial Sum = 0;

//generate khoi addition => Sum
genvar j;
generate 
	for (j=0; j<9; j=j+1) begin: sum_blocks
		addition_fp adds (Sum, Sum, pixel[j], calculate);
	end
endgenerate	

addition_fp add_bias (data_out, Sum, bias, calculate);

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		valid_out <= 0;
	end
	else begin
		if (valid_out_2D[2] && valid_out_2D[1] && valid_out_2D[0]) begin
			valid_out <= 1;
		end
	end
end

endmodule





















	
	
	