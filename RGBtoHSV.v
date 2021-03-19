module RGBtoHSV (

input clk,
input rst,
input [7:0] r,
input [7:0] g,
input [7:0] b,
output reg [8:0] h,
output reg [7:0] s,
output reg [7:0] v);

reg [7:0] max;
reg [7:0] min;
reg [7:0] delta;

always @(posedge clk or negedge rst)
begin 
	if (rst)
		begin 
			max <= 8'd0;
			min <= 8'd0;
			delta <= 8'd0;
		end
	else 
		begin
			max = (r >= g) ? r : g;
			max = (b >= max) ? b : max;
			max = (g >= max) ? g : max;
			
			min = (r <= g) ? r : g;
			min = (b <= min) ? b : min;
			min = (g <= min) ? g : min;
			delta = max - min;
			v = max * 100 / 255;
			if (delta == 0)
				h = 8'd0;
			else if (max == r)
				h = (g - b) * 60 / delta + ((g < b) ? 8'd360 : 8'd0);
			else if (max == g)
				h = (b - r) * 60 / delta + 8'd120;
			else if (max == b)	
				h = (r - g) * 60 / delta + 8'd240;
			s <= (max == 0) ? 8'd0 : delta * 100 / max;		
		end
end
endmodule
