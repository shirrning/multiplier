`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/08 10:12:22
// Design Name: 
// Module Name: booth4_multiplier_tb
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


module booth4_multiplier_tb();
reg clk;
reg rst;

reg start_sig;
reg[7:0]A;
reg[7:0]B;

wire done_sig;
wire [15:0]product;

booth4_multiplier bm(
    .clk(clk),
    .rst(rst),
    .start_sig(start_sig),
    .A(A),
    .B(B),
    .done_sig(done_sig),
    .product(product)
);

initial 
begin
    rst=0;
    #20
    rst=1;
    clk=0;
    start_sig=1;
    A=1;
    B=2;
    forever #20 
    begin
    rst=0;
    #10
    rst=1;
    clk=~clk;
    A=A+1;
    B=B+1;
    end
end

endmodule
