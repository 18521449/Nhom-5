module ReLU (out, in, valid_in);
`include "params.sv"

input valid_in;
input [DATA_WIDTH-1:0] in;
output [DATA_WIDTH-1:0] out;

assign out = (in[31]) ? 32'd0 : in;

endmodule
