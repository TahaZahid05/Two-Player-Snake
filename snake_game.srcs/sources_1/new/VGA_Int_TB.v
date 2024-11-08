`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2016 14:00:58
// Design Name: 
// Module Name: VGA_Int_TB
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


module VGA_Int_TB(
    );
    
    reg CLK;
    reg [11:0] COLOUR_IN;
    
    wire [11:0] COLOUR_OUT;
    wire [18:0] ADDR;
    wire HS;
    wire VS;
    
    VGA_Interface vgi   (
                            .CLK(CLK),
                            .COLOUR_IN(COLOUR_IN),                            
                            .COLOUR_OUT(COLOUR_OUT),
                            .ADDR(ADDR),
                            .HS(HS),
                            .VS(VS)
                        );
                        
    
    initial begin
        CLK = 0;
        COLOUR_IN = 12'b111100001111;
        forever #100 CLK = ~CLK;
    end
    
endmodule
