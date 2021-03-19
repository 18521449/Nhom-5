`timescale 1ns/1ps
module TestBench();

  reg clk;
  reg rst;
  reg [7:0] r;
  reg [7:0] g;
  reg [7:0] b;
  wire [8:0] h;
  wire [7:0] s;
  wire [7:0] v;

RGBtoHSV rgb2hsv (clk, rst, r, g, b, h, s, v);

initial begin
  clk = 0;
  rst = 1;
end
always @(posedge clk)
begin
  #20
    rst = 0;
    r = 8'd129;
    g = 8'd88;
    b = 8'd47;
  #40
    r = 8'd122;
    g = 8'd93;
    b = 8'd46;
  #60 $finish;
end
always @(*)
#10 clk <= ~clk;
endmodule
 