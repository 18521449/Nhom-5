module max_fp_4input (max, data, valid_in);
`include "params.sv"

input valid_in;
input [DATA_WIDTH*4-1:0] data;
output [DATA_WIDTH-1:0] max;

wire [DATA_WIDTH-1:0] max0, max1;

max_fp_2input Max0 (max0, data[DATA_WIDTH*2-1:0], valid_in);
max_fp_2input Max1 (max1, data[DATA_WIDTH*4-1:DATA_WIDTH*2], valid_in);
max_fp_2input Max2 (max, {max0, max1}, valid_in);

endmodule
