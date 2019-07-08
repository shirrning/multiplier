`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/29 10:25:23
// Design Name: 
// Module Name: booth_multiplier_tb
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


module booth_multiplier_tb(

    );
    
    reg clk;
    reg rst;
    
    reg start_sig;
    reg [7:0]A;
    reg [7:0]B;
    
    wire done_sig;
    wire [16:0]product;
    
    booth_multiplier booth_m(
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
        rst= 0;#10 ;rst=1;
        clk=0;forever #10 clk=~clk;
    end
    
    reg [3:0]i;
    always@(posedge clk or negedge rst)
        if(!rst)begin
            i<=4'b0; A<=8'b0; B<=8'b0; start_sig<=8'b0;
        end
        else 
            case(i)
                0:
                if(done_sig) begin start_sig<=1'b0;i<=i+1'b1;end
                else begin A<=8'd2;B<=8'd4;start_sig<=1'b1;end
                1:
                if(done_sig) begin start_sig<=1'b0;i<=i+1'b1;end
                else begin A<=8'b11111100;B<=8'd4;start_sig<=1'b1;end
                2:
                if(done_sig) begin start_sig<=1'b0;i<=i+1'b1;end
                else begin A<=8'd127;B<=8'b10000001;start_sig<=1'b1; end
                3:
                if(done_sig) begin start_sig<=1'b0;i<=i+1'b1;end
                else begin A<=8'b10000001;B<=8'd127;start_sig <=1'b1; end
                4:
                i<=4'd4;
              endcase    
endmodule
