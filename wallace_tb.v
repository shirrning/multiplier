`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/03 10:38:47
// Design Name: 
// Module Name: wallace_tb
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


module wallace_tb;
reg [3:0] x,y;
wire [7:0]out;
wallace W1(.x(x),.y(y),.out(out));

initial 
    begin
        x=2;y=3;
        #30
        x=1;y =4;
        #30
        x=8;y=6;
    end

endmodule
