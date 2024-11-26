`timescale 1ns / 1ps
module Score_Counter(
    input CLK,
    input RESET,
    input reached_target_one,
    input reached_poison_one,
    input reached_target_two,
    input reached_poison_two,
    input [1:0] master_state,
    output reg [3:0] SCORE_SNAKE_ONE,
    output reg [3:0] SCORE_SNAKE_TWO
    );

    reg target_reached_flag;
    reg poison_reached_flag;

    // Score increment and reset logic
    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            // Reset score to 0
            SCORE_SNAKE_ONE <= 4'd0;
            SCORE_SNAKE_TWO <= 4'd0;
            target_reached_flag <= 1'b0;
            poison_reached_flag <= 1'b0;
        end else if (master_state == 2'd1) begin
            // Increment score if target is reached and master_state is 1
            if (reached_target_one && !target_reached_flag) begin
                SCORE_SNAKE_ONE <= SCORE_SNAKE_ONE + 4'd1;
                target_reached_flag <= 1'b1;
            end
            else if (reached_target_two && !target_reached_flag) begin
                SCORE_SNAKE_TWO <= SCORE_SNAKE_TWO + 4'd1;
                target_reached_flag <= 1'b1;
            end else if (!reached_target_one) begin
                target_reached_flag <= 1'b0;
            end

            if (reached_poison_one && !poison_reached_flag) begin
                if (SCORE_SNAKE_ONE + SCORE_SNAKE_TWO > 4'd0) begin
                    if (SCORE_SNAKE_ONE > 4'd0) begin
                        SCORE_SNAKE_ONE <= SCORE_SNAKE_ONE - 4'd1;
                    end
                    else begin
                        SCORE_SNAKE_TWO <= SCORE_SNAKE_TWO - 4'd1;
                    end
                    poison_reached_flag <= 1'b1;
                end
            end
            else if (reached_poison_two && !poison_reached_flag) begin
                if (SCORE_SNAKE_ONE + SCORE_SNAKE_TWO > 4'd0) begin
                    if (SCORE_SNAKE_TWO > 4'd0) begin
                        SCORE_SNAKE_TWO <= SCORE_SNAKE_TWO - 4'd1;
                    end
                    else begin
                        SCORE_SNAKE_ONE <= SCORE_SNAKE_ONE - 4'd1;
                    end
                    poison_reached_flag <= 1'b1;
                end
            end
            else if (!reached_poison_one) begin
                poison_reached_flag <= 1'b0;
            end
        end else if (master_state == 2'd2 || master_state == 2'd0) begin
            if (master_state == 2'd0) begin
                SCORE_SNAKE_ONE <= 4'd0;
                SCORE_SNAKE_TWO <= 4'd0;
            end
            target_reached_flag <= 1'b0;
            poison_reached_flag <= 1'b0;
        end
    end

endmodule