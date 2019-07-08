`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/03 10:07:38
// Design Name: 
// Module Name: wallace
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module wallace(x,y,out);
 parameter size = 4;
 input [size-1:0]x,y;
 output [2*size-1:0] out;
 
 wire [size*size-1:0] a;//a为部分积；
 wire [1:0]b0,b1;
 wire [1:0]c0,c1,c2,c3;
 wire [5:0] add_a,add_b;
 wire [6:0]add_out;
 wire out;
 
 assign a={x[3],x[2],x[3],x[1],x[2],x[3],x[0],x[1],x[2],x[3],x[0],x[1],x[2],x[0],x[1],x[0]}
 &{y[3],y[2],y[3],y[1],y[2],y[3],y[0],y[1],y[2],y[3],y[0],y[1],y[2],y[0],y[1],y[0]};
 
 hadd H1(.x(a[8]),.y(a[9]),.out(b0));
 hadd H2(.x(a[11]),.y(a[12]),.out(b1));
 
 hadd H3(.x(a[4]),.y(a[5]),.out(c0));
 fadd F1(.x(a[6]),.y(a[7]),.z(b0[0]),.out(c1));
 fadd F2(.x(a[10]),.y(b1[0]),.z(b0[1]),.out(c2));
 fadd F3(.x(a[13]),.y(a[14]),.z(b1[1]),.out(c3));
 
 assign add_a ={a[15],c3[0],c2[0],c1[0],a[3],a[1]};
 assign add_b = {c3[1],c2[1],c1[1],c0[1],c0[0],a[2]};
 assign add_out = add_a + add_b;
 assign out = {add_out,a[0]};
 
endmodule

