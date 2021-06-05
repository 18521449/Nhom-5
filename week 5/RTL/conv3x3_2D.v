module conv3x3_2D 
	#(	parameter IMAGE_WIDTH = 5,
		parameter KERNEL_FILE = "kernel.txt")
	(	input clk,
		input rst_n,
		input valid_in,
		input [DATA_WIDTH-1:0] data,
		input [DATA_WIDTH-1:0] bias,
		output [DATA_WIDTH-1:0] data_out,
		output load_data_done,
		output reg valid_out);
		
`include "params.sv"

reg [DATA_WIDTH-1:0] kernel [0:8];
wire [DATA_WIDTH-1:0] data_in [0:8];

initial begin
	$readmemb(KERNEL_FILE,kernel);
end

lines_buffer_conv 
		#(	.IMAGE_WIDTH(IMAGE_WIDTH))
	LinesBuffer
		(	.clk(clk), 
			.rst_n(rst_n), 
			.valid_in(valid_in), 
			.data(data), 
			.d0(data_in[0]),
			.d1(data_in[1]),
			.d2(data_in[2]),
			.d3(data_in[3]),
			.d4(data_in[4]),
			.d5(data_in[5]),
			.d6(data_in[6]),
			.d7(data_in[7]),
			.d8(data_in[8]),
			.valid_out(load_data_done)
		);

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
	end
	else begin	
		if (mul_done[8]) begin
			valid_out <= 1;
		end
		else begin
			valid_out <= 0;
		end
	end
end

wire [DATA_WIDTH-1:0] mul [0:8];
wire [DATA_WIDTH-1:0] sum [0:7];
wire mul_done[0:8];

genvar i;
generate 
	for (i=0; i<9; i=i+1) begin: mul_generate
		multiple_fp muls (mul[i], kernel[i], data_in[i], clk, rst_n, load_data_done, mul_done[i]);
	end 
endgenerate

generate 
	for (i=0; i<4; i=i+1) begin: add1_generate
		addition_fp adds1 (sum[i], mul[7-i], mul[i]);
	end
endgenerate

generate 
	for (i=0; i<2; i=i+1) begin: add2_generate
		addition_fp adds2 (sum[i+4], sum[3-i], sum[i]);
	end
endgenerate

addition_fp adds3 (sum[6], sum[5], sum[4]);
addition_fp adds4 (sum[7], sum[6], mul[8]);

// Sum <= Sum + bias
addition_fp add_bias (data_out, sum[7], bias);

endmodule 


