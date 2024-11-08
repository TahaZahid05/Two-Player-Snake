`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2016 17:57:42
// Design Name: 
// Module Name: Snake_TB
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


module Snake_TB(
    );
    
    wire CLK; //k
    wire BTNU; //k
    wire BTND; //k
    wire BTNL; //k
    wire BTNR; //k
    wire BTNC; //k
    
    reg [11:0] COLOUR_OUT; //k
    reg HS; //k
    reg VS; //k
    reg [3:0] SEG_SELECT;
    reg [7:0] HEX_OUT; //k
    
    Master_Game mg  (
                        .CLK(CLK), //k
                        .BTNU(BTNU), //k
                        .BTND(BTND), //k
                        .BTNL(BTNL), //k
                        .BTNR(BTNR), //k
                        .BTNC(BTNC), //k
                        .COLOUR_OUT(COLOUR_OUT), //k
                        .HS(HS), //k
                        .VS(VS), //k
                        .SEG_SELECT(SEG_SELECT),
                        .HEX_OUT(HEX_OUT) //k
                    );
                    
        initial begin
            CLK = 0;
            forever #100 CLK = ~CLK;
        end
        
        initial begin
            #50 BTNC = 1;
            #230 BTNC = 0;
            

        end
                    
endmodule
