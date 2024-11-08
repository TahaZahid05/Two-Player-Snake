`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2016 02:38:41
// Design Name: 
// Module Name: rand_TB
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


module rand_TB(
    );
    
    reg CLK;
    reg RESET;
    reg reached_target;
    wire [14:0] rand_target_address;
    
    Target_Generator tg (
                            .CLK(CLK),
                            .RESET(RESET),
                            .reached_target(reached_target),
                            .rand_target_address(rand_target_address)
                        );
    
    initial begin
        CLK = 0;
        RESET = 1;
        reached_target = 0;
        forever #100 CLK = ~CLK;
    end
    
    initial begin
        #150 RESET = 0;
        forever #300 reached_target = ~reached_target;
    end
    
endmodule
