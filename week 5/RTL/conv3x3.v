module conv3x3_2D 
	#(	parameter WIDTH = 66)
	(	input clk,
		input rst,
		input valid_in,
		input load_kernel,
		input [31:0] data,
		input [31:0] kernel,
		output [31:0] data_out,
		output load_kernel_done,
		output valid_out
	);
	
wire load_data_done;
wire [31:0] k0, k1, k2, k3, k4, k5, k6, k7, k8, bias;
wire [31:0] o0, o1, o2, o3, o4, o5, o6, o7, o8;
wire [31:0] Out0, Out1, Out2, Out3, Out4, Out5, Out6, Out7, Out8;
wire [31:0] Sum0, Sum1, Sum2, Sum3, Sum4, Sum5, Sum6, Sum7, Sum8;  

storage_conv Storage (clk, rst, load_kernel, kernel, k0, k1, k2, k3, k4, k5, k6, k7, k8, bias, load_kernel_done);	
lines_buffer_conv LinesBuffer #(WIDTH)(clk, rst, valid_in, data, o0, o1, o2, o3, o4, o5, o6, o7, o8, load_data_done);

always @(posedge clk) begin
	calculate <= 0;
	if (load_kernel_done && load_data_done) begin
		calculate <= 1;
	end
end


multiple_fp mul0 (Out0, k0, o0, calculate);
multiple_fp mul1 (Out1, k1, o1, calculate);
multiple_fp mul2 (Out2, k2, o2, calculate);
multiple_fp mul3 (Out3, k3, o3, calculate);
multiple_fp mul4 (Out4, k4, o4, calculate);
multiple_fp mul5 (Out5, k5, o5, calculate);
multiple_fp mul6 (Out6, k6, o6, calculate);
multiple_fp mul7 (Out7, k7, o7, calculate);
multiple_fp mul8 (Out8, k8, o8, calculate);

addition_fp add0 (Sum0, Out0, Out1, calculate);
addition_fp add1 (Sum1, Out2, Out3, calculate);
addition_fp add2 (Sum2, Out4, Out5, calculate);
addition_fp add3 (Sum3, Out6, Out7, calculate);
addition_fp add4 (Sum4, Out8, bias, calculate);


addition_fp add5 (Sum5, Sum0, Sum1, calculate);
addition_fp add6 (Sum6, Sum2, Sum3, calculate);
addition_fp add7 (Sum7, Sum4, Sum5, calculate);
addition_fp add8 (Sum8, Sum6, Sum7, calculate);

assign data_out = (valid_out) ? Sum8 : 32'dz;

endmodule



