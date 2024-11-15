`timescale 1ns / 1ps
module Master_State_Machine(
        input CLK,
        input BTNU,
        input BTND,
        input BTNL,
        input BTNR,
        input BTNC,
        input BTNU_2,
        input BTND_2,
        input BTNL_2,
        input BTNR_2,
        input [4:0] SCORE,
        input fail,
        output [1:0] STATE
    );
    
    reg [1:0] state_game;

    assign STATE = state_game;
    
    always@(posedge CLK) begin
        if (state_game == 2'd0 && (BTNU || BTND || BTNL || BTNR || BTNU_2 || BTND_2 || BTNL_2 || BTNR_2))
            state_game <= 2'd1;
        else if (state_game == 2'd2 && BTNC)
            state_game <= 2'd0;
        else if (state_game == 2'd1 && SCORE == 5'b10000)
            state_game <= 2'd2;
        else if (state_game == 2'd1 && fail)
            state_game <= 2'd0;
        else
            state_game <= state_game;
    end
    
endmodule