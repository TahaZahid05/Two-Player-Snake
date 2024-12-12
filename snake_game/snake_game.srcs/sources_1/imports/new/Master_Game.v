`timescale 1ns / 1ps

module Master_Game(
        input CLK,
        input PS2Data,
        input PS2Clk,
        output [11:0] COLOUR_OUT,
        output HS,
        output VS
    );
    wire levels; // 0 = 1st level, 1 = 2nd level
    wire [1:0] lives;
    wire [3:0] second_counter_units;
    wire [3:0] minute_counter_units;
    wire [2:0] second_counter_tens;
    wire [2:0] minute_counter_tens;
    wire [3:0] score_snake_one;
    wire [3:0] score_snake_two;
    wire [1:0] state_master;
    wire [1:0] state_navigation;
    wire [1:0] state_navigation_2;
    wire [14:0] target_address;
    wire [14:0] target_address_2;
    wire [14:0] poison_address;
    wire [14:0] poison_address_2;
    wire [18:0] address;
    wire [11:0] colour;
    wire fail;
    wire reached_target_one;
    wire reached_target_two;
    wire reached_target_2_one;
    wire reached_target_2_two;
    wire reached_poison_one;
    wire reached_poison_two;
    wire reached_poison_2_one;
    wire reached_poison_2_two;
    wire reset;
    wire [15:0] keycode;
    wire flag;
    reg BTNU, BTND, BTNL, BTNR, BTNC; // Control signals for first snake
    reg BTNU_2, BTND_2, BTNL_2, BTNR_2; // Control signals for second snake
    
    PS2Receiver keyboard_receiver (
        .clk(CLK),
        .kclk(PS2Clk),
        .kdata(PS2Data),
        .keycode(keycode),
        .oflag(flag)
    );

    // Process received keycodes and set control signals
    always @(posedge CLK) begin
        if (flag) begin
            case (keycode[7:0])
                8'h1C: BTNL <= 1; // A
                8'h1D: BTNU <= 1; // W
                8'h1B: BTND <= 1; // S
                8'h23: BTNR <= 1; // D
                8'h2D: BTNC <= 1; // 'R' Key (Reset)
                8'h6B: BTNL_2 <= 1; // J
                8'h75: BTNU_2 <= 1; // I
                8'h72: BTND_2 <= 1; // K
                8'h74: BTNR_2 <= 1; // L
                default: begin
                    BTNU <= 0; BTND <= 0; BTNL <= 0; BTNR <= 0;
                    BTNC <= 0;
                    BTNU_2 <= 0; BTND_2 <= 0; BTNL_2 <= 0; BTNR_2 <= 0;
                end
            endcase
        end else begin
            // Reset control signals when key is released
            BTNU <= 0; BTND <= 0; BTNL <= 0; BTNR <= 0;
            BTNC <= 0;
            BTNU_2 <= 0; BTND_2 <= 0; BTNL_2 <= 0; BTNR_2 <= 0;
        end
    end
    
    
    Master_State_Machine msm    (
                                    .CLK(CLK),
                                    .BTNU(BTNU),
                                    .BTND(BTND),
                                    .BTNL(BTNL),
                                    .BTNR(BTNR),
                                    .BTNC(BTNC),
                                    .BTNU_2(BTNU_2),
                                    .BTND_2(BTND_2),
                                    .BTNL_2(BTNL_2),
                                    .BTNR_2(BTNR_2),
                                    .SCORE(score_snake_one + score_snake_two),
                                    .fail(fail),
                                    .levels(levels),
                                    .STATE(state_master)
                                );
    
    Navigation_State_Machine nsm1    (
                                        .CLK(CLK),
                                        .BTNU(BTNU),
                                        .BTND(BTND),
                                        .BTNL(BTNL),
                                        .BTNR(BTNR),
                                        .BTNC(BTNC),
                                        .STATE(state_navigation)
                                    );
                                    
    Navigation_State_Machine nsm2    (
                                        .CLK(CLK),
                                        .BTNU(BTNU_2),
                                        .BTND(BTND_2),
                                        .BTNL(BTNL_2),
                                        .BTNR(BTNR_2),
                                        .BTNC(BTNC),
                                        .STATE(state_navigation_2)
                                    );
    
    Snake_control s1 (
                        .CLK(CLK),
                        .RESET(BTNC),
                        .score_snake_one(score_snake_one),
                        .score_snake_two(score_snake_two),
                        .state_master(state_master),
                        .state_navigation(state_navigation),
                        .state_navigation_2(state_navigation_2),
                        .target_address(target_address),
                        .target_address_2(target_address_2),
                        .poison_address(poison_address),
                        .poison_address_2(poison_address_2),
                        .pixel_address(address),
                        .second_counter_units(second_counter_units),
                        .second_counter_tens(second_counter_tens),
                        .minute_counter_units(minute_counter_units),
                        .minute_counter_tens(minute_counter_tens),
                        .lives(lives),
                        .levels(levels),
                        .COLOUR_OUT(colour),
                        .reached_target_one(reached_target_one),
                        .reached_target_two(reached_target_two),
                        .reached_target_2_one(reached_target_2_one),
                        .reached_target_2_two(reached_target_2_two),
                        .reached_poison_one(reached_poison_one),
                        .reached_poison_two(reached_poison_two),
                        .reached_poison_2_one(reached_poison_2_one),
                        .reached_poison_2_two(reached_poison_2_two),
                        .fail(fail)
                    );
                    
                    
    
    Target_Generator tg (
                            .CLK(CLK),
                            .RESET(BTNC),
                            .reached_target(reached_target_one | reached_target_two),
                            .reached_target_2(reached_target_2_one | reached_target_2_two),
                            .reached_poison(reached_poison_one | reached_poison_two),
                            .reached_poison_2(reached_poison_2_one | reached_poison_2_two),
                            .levels(levels),
                            .rand_target_address(target_address),
                            .rand_target_address_2(target_address_2),
                            .rand_poison_address(poison_address),
                            .rand_poison_address_2(poison_address_2)
                        );
                        
    
    VGA_Interface vgai  (
                            .CLK(CLK),
                            .COLOUR_IN(colour),
                            .COLOUR_OUT(COLOUR_OUT),
                            .ADDR(address),
                            .HS(HS),
                            .VS(VS)
                        );
    
    Score_Counter sc    (
                            .CLK(CLK),
                            .RESET(BTNC),
                            .reached_target_one(reached_target_one),
                            .reached_poison_one(reached_poison_one),
                            .reached_target_two(reached_target_two),
                            .reached_poison_two(reached_poison_two),
                            .reached_target_2_one(reached_target_2_one),
                            .reached_target_2_two(reached_target_2_two),
                            .reached_poison_2_one(reached_poison_2_one),
                            .reached_poison_2_two(reached_poison_2_two),
                            .master_state(state_master),
                            .SCORE_SNAKE_ONE(score_snake_one),
                            .SCORE_SNAKE_TWO(score_snake_two),
                            .lives(lives),
                            .levels(levels)
                        );
                        
                        
    timer t1 (
                .CLK(CLK),
                .RESET(BTNC),
                .STATE(state_master),
                .SECONDS_UNITS(second_counter_units),
                .SECONDS_TENS(second_counter_tens),
                .MINUTES_UNITS(minute_counter_units),
                .MINUTES_TENS(minute_counter_tens)
             );
    
endmodule
