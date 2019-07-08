`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/08 09:01:12
// Design Name: 
// Module Name: booth4_multiplier
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


module booth4_multiplier(clk,rst,start_sig,A,B,done_sig,product);
input clk;
input rst;

input start_sig;
input [7:0]A;
input [7:0]B;

output done_sig;
output [15:0]product;

reg [3:0]stage;
reg [3:0]i;
reg [7:0]a;
reg [7:0]_a;
reg [16:0]p;
reg is_done;

always @( posedge clk or negedge rst )
    if(!rst)
        begin 
            a<=4'b0;
            _a<=4'b0;
            p<=16'b0;
            is_done<=1'b0;
            i<=4'b0;
            stage<=4'b0;
        end
    else if(start_sig)
        case (stage)
            0:
                begin a<=A;_a<=(~A +1);p<={8'b0,B,1'b0};stage<=1'b1; end
            1:
                if(i == 4) begin i<=4'b0; stage<=4'd5; end
                else if (p[2:0] == 3'b001 || p[2:0] == 3'b010) begin p<={p[16:9]+a,p[8:0]};stage<=stage +1'b1; end
                else if (p[2:0] == 3'b101|| p[2:0] == 3'b110) begin p<={p[16:9]+_a,p[8:0]};stage<=stage+ 1'b1; end
                else if (p[2:0] == 3'b011) begin stage<= 3'd3; end
                else if (p[2:0] == 3'b100) begin stage <=3'd4;end
                else stage <= stage + 1'b1;
            2:
                begin p<={p[16],p[16],p[16:2]};i<=i+1'b1;stage<=4'b1; end
            3:
                begin p<={p[16],p[16:1]}; p<= {p[16:9]+a,p[8:0]};p<={p[16],p[16:1]}; i <=i + 1;stage<=4'd1;end 
            4:
                begin p<={p[16],p[16:1]}; p<={p[16:9]+_a,p[8:0]};p<={p[16],p[16:1]}; i<=i + 1;stage <= 4'd1;end
            5:
                begin is_done <=1'b1; stage <= 4'b0; end
        endcase
        
        assign done_sig = is_done;
        assign product = p[16:1];

endmodule
