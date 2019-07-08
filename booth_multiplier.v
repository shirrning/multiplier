`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/27 21:44:32
// Design Name: 
// Module Name: booth_multiplier
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


module booth_multiplier(
input clk,
input rst,

input start_sig,
input [7:0]A,
input [7:0]B,

output done_sig,
output [15:0]product
    );
    
    reg [3:0]i;//i用来指示不同的阶段；
    reg [7:0]a;//a用来存储=A;
    reg [7:0]_a;//_a用来存反码；
    reg [16:0]p;//p用来表示p空间；
    reg [3:0]x;//x用来存迭代的轮数；
    reg flag;
    
    always@(posedge clk or negedge rst)
        if(!rst)
            //电路中间变量初始化
            begin
                i<=4'b0;
                a<=8'b0;
                _a<=8'b0;
                p<=17'b0;
                x<=4'b0;
                flag<=1'b0;
                  end
        else if (start_sig)
            case(i)
                0:
                    begin
                    a<=A;
                    _a<=(~A +1'b1);
                    p<={8'd0 , B , 1'b0};
                    i<=i+1'b1;                
                    end
                1:
                    begin
                        if(p[1:0]==2'b10)
                            p<= {p[16:9] +a ,p[8:0]};
                         else
                            p<={p[16:9]+_a,p[8:0]};     
                          
                          i<=i+1'b1;                       
                    end
                2:
                    begin
                        if(x==8)
                            begin
                                x<=4'b0;
                                i<=i+1'b1;
                            end
                         else begin
                            p<={p[16],p[16:1]};
                            x<=x+1'b1;
                            i<=i-1'b1;  
                         end                           
                    end
                3:
                    begin flag <= 1'b1;i<=i+1'b1;end
                4:
                    begin flag<=1'b0; i<=4'b0; end
             endcase
     assign done_sig = flag;
     assign product = p[16:1];
        
endmodule
