module register (Out, In, clk, en);

input clk, en;
input [31:0] In;
output reg [31:0] Out;

always @(posedge clk) begin
	if (en)
		Out = In;
end
endmodule 