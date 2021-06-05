module max_fp_2input (max, data, valid_in);
`include "params.sv"

input valid_in;
input [DATA_WIDTH*2-1:0] data;
output [DATA_WIDTH-1:0] max;

wire [DATA_WIDTH-1:0] Sub;

//addition_fp sub (Sub, data[DATA_WIDTH*1-1:0], {1'b1,data[DATA_WIDTH*2-2:DATA_WIDTH*1]}, valid_in);
//assign max = (Sub[DATA_WIDTH-1]) ? data[DATA_WIDTH*2-1:DATA_WIDTH*1] : data[DATA_WIDTH*1-1:0];

endmodule


