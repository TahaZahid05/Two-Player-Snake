`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2016 01:23:11
// Design Name: 
// Module Name: VGA_Interface
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


module VGA_Interface(
    input CLK,
//    input [1:0] master_state,
    input [11:0] COLOUR_IN,
    output [11:0] COLOUR_OUT,
    output [18:0] ADDR,
    output HS,
    output VS
    );
    
    //Declaration of bus to allocate space in memory for colour, horizontal address and vertial address
//    reg [15:0] FrameCount;
//    reg [11:0] colour;
    wire [9:0] addrh;
    wire [8:0] addrv;
    
    assign ADDR = {addrh[9:0], addrv[8:0]};
    
//    //Wires for the counter
//    wire flip;
//    wire change;
    
//    wire [9:0] shift;
    
    //VGA Controller to select pixel colour on the screen according to the position
    VGA_Driver #() vga(
                        .CLK(CLK),
                        .COLOUR_IN(COLOUR_IN),
                        .COLOUR_OUT(COLOUR_OUT),
                        .HS(HS),
                        .VS(VS),
                        .ADDRV(addrv),
                        .ADDRH(addrh)
                    );
    
//    always@(posedge CLK) begin
//        //Mode is used to switch between module output and my own screen
//        if (addrv == 479) begin
//            FrameCount <= FrameCount + 1; 
//        end
//    end
    
//    always@(posedge CLK) begin
//        if (master_state == 2'b10) begin //Won
//            if (addrv[8:0] > 240) begin
//                if (addrh[9:0] > 320)
//                    colour <= FrameCount[15:8] + addrv[7:0] + addrh[7:0] - 240 - 320;
//                else
//                    colour <= FrameCount[15:8] + addrv[7:0] - addrh[7:0] - 240 + 320;
//            end
//            else begin
//                if (addrh > 320)
//                    colour <= FrameCount[15:8] - addrv[7:0] + addrh[7:0] + 240 - 320;
//                else
//                    colour <= FrameCount[15:8] - addrv[7:0] - addrh[7:0] + 240 + 320;
//            end
//        end
//        else if (master_state == 2'b00) //Before starting
//            colour <= 12'h00f;
//        else if (master_state == 2'b01) //While playing
//            colour <= 12'h000;
//        else //Nothing
//            colour <= 12'h000;
//    end
    
endmodule
