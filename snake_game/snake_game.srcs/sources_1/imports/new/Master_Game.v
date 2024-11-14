`timescale 1ns / 1ps

module Master_Game(
        input CLK,
        input PS2Data,
        input PS2Clk,
        output [11:0] COLOUR_OUT,
        output HS,
        output VS
    );
    
    wire [5:0] score;
    wire [1:0] state_master;
    wire [1:0] state_navigation;
    wire [1:0] state_navigation_2;
    wire [14:0] target_address;
    wire [18:0] address;
//    wire [18:0] address_2;
    wire [11:0] colour;
//    wire [11:0] colour_2;
    wire fail;
//    wire fail_2;
    wire reached_target;
//    wire reached_target_2;
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
                8'h1A: BTNL <= 1; // Z
                8'h1D: BTNU <= 1; // W
                8'h1B: BTND <= 1; // S
                8'h23: BTNR <= 1; // D
                8'h2D: BTNC <= 1; // 'R' Key (Reset)
                8'h3B: BTNL_2 <= 1; // J
                8'h43: BTNU_2 <= 1; // I
                8'h42: BTND_2 <= 1; // K
                8'h4B: BTNR_2 <= 1; // L
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
                                    .SCORE(score),
                                    .fail(fail),
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
                        .score(score),
                        .state_master(state_master),
                        .state_navigation(state_navigation),
                        .target_address(target_address),
                        .pixel_address(address),
                        .COLOUR_OUT(colour),
                        .reached_target(reached_target),
                        .fail(fail)
                    );
                    
//   Snake_control s2 (
//                        .CLK(CLK),
//                        .RESET(BTNC),
//                        .score(score),
//                        .state_master(state_master),
//                        .state_navigation(state_navigation_2),
//                        .target_address(target_address),
//                        .pixel_address(address_2),
//                        .COLOUR_OUT(colour_2),
//                        .reached_target(reached_target_2),
//                        .fail(fail_2)
//                    );
                    
    
    Target_Generator tg (
                            .CLK(CLK),
                            .RESET(BTNC),
                            .reached_target(reached_target),
                            .rand_target_address(target_address)
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
                            .reached_target(reached_target),
                            .master_state(state_master),
                            .SCORE(score)
                        );
    
endmodule
