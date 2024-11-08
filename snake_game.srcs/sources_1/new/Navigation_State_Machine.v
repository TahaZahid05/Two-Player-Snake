`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2016 03:47:24
// Design Name: 
// Module Name: Master_State_Machine
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


module Navigation_State_Machine(
        input CLK,
        input BTNU,
        input BTND,
        input BTNL,
        input BTNR,
        input BTNC,
        output [1:0] STATE
    );
    
    reg [1:0] state_snake;
    reg [1:0] next_snake;
    assign STATE = state_snake;

        
    always@(BTNL or BTNR or BTNU or BTND) begin
        case(state_snake)
            2'd0: begin
                if (BTNU)
                    next_snake <= 2'd2;
                else if (BTND)
                    next_snake <= 2'd1;
                else
                    next_snake <= 2'd0;
            end
            
            2'd1: begin
                if (BTNR)
                    next_snake <= 2'd0;
                else if (BTNL)
                    next_snake <= 2'd3;
                else
                    next_snake <= 2'd1;
            end
            
            2'd2: begin
                if (BTNR)
                    next_snake <= 2'd0;
                else if (BTNL)
                    next_snake <= 2'd3;
                else
                    next_snake <= 2'd2;
            end
            
            2'd3: begin
                if (BTNU)
                    next_snake <= 2'd2;
                else if (BTND)
                    next_snake <= 2'd1;
                else
                    next_snake <= 2'd3;
            end
        
        endcase
    end
    
    always@(posedge CLK) begin
        state_snake <= next_snake;
    end
    
endmodule
