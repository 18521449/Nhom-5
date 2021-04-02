`timescale 1ns/1ps
module testbench ();
parameter Infile = "text.txt",
          Outfile = "Out_text.txt";
parameter Width = 100,
          Height = 100;
parameter Total_Pixel = Width * Height;
parameter k = 20;

reg clk, rst, valid_in;
reg [31:0] r, g, b;
wire [31:0] h, s, v;

reg [32*3-1:0] In_Memory [0:Total_Pixel-1];
reg [32*3-1:0] Out_Memory [0:Total_Pixel-1];

initial begin
  $readmemh(Infile, In_Memory);
end

rgb2hsv RGBtoHSV (
      .h(h),
      .v(v),
      .s(s),
      .r(r),
      .g(g),
      .b(b),
      .valid_in(valid_in),
      .valid_out(valid_out),
      .clk(clk),
      .rst(rst)
    );
integer i;
initial begin 
  clk <= 1'b0;
  rst <= 1'b0;
  valid_in <= 1'b0;
  #(k*4) 
  rst <= 1'b1;
  for (i=0; i<Total_Pixel; i=i+1) begin
    r <= In_Memory[i][95:64];
    g <= In_Memory[i][63:32];
    b <= In_Memory[i][31:0];
    valid_in <= 1'b1;
    #(k*2);
  end
  #(k*25)
  valid_in <= 1'b0;
  $writememb(Outfile, Out_Memory);
  $finish;
end

integer addr = 0;
always @(posedge clk) begin
  if (valid_out) begin
    Out_Memory[addr] = {h,s,v};
    addr = addr + 1;
  end
end

always @(clk) begin
  #k clk <= ~clk;
end
endmodule