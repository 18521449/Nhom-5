`timescale 1ns/1ps
module testbench ();
parameter Infile = "text.txt",
          Outfile = "Out_text.txt";
parameter Width = 100,
          Height = 100;
parameter Total_Pixel = Width * Height;
parameter k = 10;

reg clk, rst, valid_in;
reg [31:0] r, g, b;
wire [31:0] h, s, v;
wire valid_out;
wire valid_out_H;
wire valid_out_S;
wire valid_out_V;

reg [32*3-1:0] In_Memory [0:Total_Pixel-1];
reg [32*3-1:0] Out_Memory [0:Total_Pixel-1];

initial begin
  $readmemh(Infile, In_Memory);
end

rgb2hsv RGBtoHSV (
      .clk(clk),
      .rst(rst),
      .valid_in(valid_in),
      .r(r),
      .g(g),
      .b(b),
      .h(h),
      .v(v),
      .s(s),
      .valid_out(valid_out),
      .valid_out_H(valid_out_H),
      .valid_out_S(valid_out_S),
      .valid_out_V(valid_out_V)
    );
integer i;
initial begin 
  clk <= 1'b0;
  rst <= 1'b0;
  valid_in <= 1'b0;
  r <= 32'd0;
  g <= 32'd0;
  b <= 32'd0;
  #(k*5) 
  rst <= 1'b1;
  valid_in <= 1'b1;
  #(k*4);
  for (i=0; i<Total_Pixel; i=i+1) begin
    r <= In_Memory[i][95:64];
    g <= In_Memory[i][63:32];
    b <= In_Memory[i][31:0];
    valid_in <= 1'b1;
    #(k*25);
    Out_Memory[i] <= {h,s,v};
  end
  #k#k 
  valid_in <= 1'b0;
  #(k*5)
  $writememb(Outfile, Out_Memory);
  $finish;
end

always @(clk) begin
  #k clk <= ~clk;
end
endmodule




