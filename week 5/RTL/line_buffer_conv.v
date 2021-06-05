module lines_buffer_conv
	#(	parameter WIDTH = 66)
	(	input clk,
		input rst,
		input valid_in,
		input [31:0] data,
		output [31:0] o0,
		output [31:0] o1,
		output [31:0] o2,
		output [31:0] o3,
		output [31:0] o4,
		output [31:0] o5,
		output [31:0] o6,
		output [31:0] o7,
		output [31:0] o8,
		output reg valid_out
	);

// Kich thuoc moi kernel la 3*3 => Lines Buffer co kich thuoc 3*WIDTH
reg [31:0] Register [0:3*WIDTH-1];

// Luu 9 gia tri Pixel de tich chap voi filter
reg [31:0] Temp [0:8];

// Reset
integer k;
always @(negedge rst) begin
	if (!rst) begin
		for (k=0; k<3*WIDTH-1; k=k+1) begin
			Register[k] = 32'd0;
		end
	end
end	

// Push data dau vao -> Reg[0] dau tien sau moi clk & valid_in
always @(posedge clk) begin
	if (valid_in)
		Register[0] <= data;
end

// Truyen data theo thu tu tu tren xuong duoi
// Dua du lieu vao tren va lay ra o ben duoi
integer i = 0;
always @(posedge clk) begin

	// i la bien chay den khi 3 line buffer full
	if (i<3*WIDTH-1) 
	begin
	
		// Truyen data [i+1] = data [i]
		Register[i+1] <= Register[i];
		i <= i + 1;
	end
	
	// Neu da truyen data full thi valid_out = 1
	if (i == 3*WIDTH-1) 
	begin
	
		// Khi full thi pop Line buffer o cuoi ra 
		// Va push Line buffer moi vao dau
		// i = 2*WIDTH -> 3*WIDTH
		i = 2*WIDTH;
		valid_out <= 1;
		
		// Gan Temp = 3 gia tri dau tien cua moi Line buffer
		Temp[0] <= Register[WIDTH-3];
		Temp[1] <= Register[WIDTH-2];
		Temp[2] <= Register[WIDTH-1];
		Temp[3] <= Register[WIDTH*2-3];
		Temp[4] <= Register[WIDTH*2-2];
		Temp[5] <= Register[WIDTH*2-1];
		Temp[6] <= Register[WIDTH*3-3];
		Temp[7] <= Register[WIDTH*3-3];
		Temp[8] <= Register[WIDTH*3-3];
	end
end

// Truot tren Line buffer cuoi cung (Line buffer vao dau tien)
integer j = 0;
always @(posedge clk) begin

	// Khi data full => j = 1 -> 3
	// Dao chieu valid_out de delay data du 3 gia tri
	if (j > 0 && j < 3) begin
		valid_out <= 0;
		j = j + 1;
	end
	else begin
	
		// Moi khi dua du 3 data thi gan lai Temp o cuoi cung -> cua so truot 
		if (j == 3) begin
		
			// Lap lai buoc truot 
			j = 1;
			valid_out <= 1;
			Temp[6] <= Register[WIDTH*3-3];
			Temp[7] <= Register[WIDTH*3-3];
			Temp[8] <= Register[WIDTH*3-3];
		end
	end
	
	// Moi khi Line buffer full thi bat dau 
	if (i == 3*WIDTH-1) begin
		j = j + 1;
	end
end

// Moi khi valid_out = 1 -> gan out = Temp
assign o0 = (valid_out) ? Temp[0] : 32'dz;
assign o1 = (valid_out) ? Temp[1] : 32'dz;
assign o2 = (valid_out) ? Temp[2] : 32'dz;
assign o3 = (valid_out) ? Temp[3] : 32'dz;
assign o4 = (valid_out) ? Temp[4] : 32'dz;
assign o5 = (valid_out) ? Temp[5] : 32'dz;
assign o6 = (valid_out) ? Temp[6] : 32'dz;
assign o7 = (valid_out) ? Temp[7] : 32'dz;
assign o8 = (valid_out) ? Temp[8] : 32'dz;

endmodule

