`timescale 1ns / 1ps
module VGA_Interface(
    input CLK,
    input [11:0] COLOUR_IN,
    output [11:0] COLOUR_OUT,
    output [18:0] ADDR,
    output HS,
    output VS
    );
    
    wire [9:0] addrh;
    wire [8:0] addrv;
    
    assign ADDR = {addrh[9:0], addrv[8:0]};
    
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
    
endmodule
