`timescale 1ns / 1ps
module Score_Counter(
    input CLK,
    input RESET,
    input reached_target,
    input [1:0] master_state,
    output reg [5:0] SCORE
    );
    
    // Score increment and reset logic
    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            // Reset score to 0
            SCORE <= 5'd0;
        end else if (master_state == 2'd1 && reached_target) begin
            // Increment score if target is reached and master_state is 1
            SCORE <= SCORE + 5'd1;
        end else if (master_state == 2'd2) begin
            SCORE <= 5'd0;
        end
    end
    
endmodule
