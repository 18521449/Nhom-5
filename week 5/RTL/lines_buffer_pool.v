module lines_buffer_pool
	#(	parameter WIDTH = 224)
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

integer k;
always @(negedge rst) begin
	if (!rst) begin
		for (k=0; k<2*WIDTH-1; k=k+1) begin
			Register[k] = 32'd0;
		end
	end
end	

always @(posedge clk) begin
	if (valid_in)
		Register[0] <= data;
end

integer i = 0;
always @(posedge clk) begin
	if (i<2*WIDTH-1) 
	begin
		Register[i+1] <= Register[i];
		i = i + 1;
	end
	if (i == 2*WIDTH-1) 
	begin
		i = 0;
	end
end

assign pixel[DATA_WIDTH*1-1:DATA_WIDTH*0] = Register[WIDTH*2-1];
assign pixel[DATA_WIDTH*2-1:DATA_WIDTH*1] = Register[WIDTH*2-2];
assign pixel[DATA_WIDTH*3-1:DATA_WIDTH*2] = Register[WIDTH-1];
assign pixel[DATA_WIDTH*4-1:DATA_WIDTH*3] = Register[WIDTH-2];

integer j = 0;
always @(posedge clk) begin
	if (j > 0 && j < 2) begin
		valid_out <= 0;
		j = j + 1;
	end
	else begin
		if (j == 2) begin
			j = 1;
			valid_out <= 1;
		end
	end
	if (i == 2*WIDTH-1) begin
		valid_out <= 1;
		j = j + 1;
	end
end

endmodule
