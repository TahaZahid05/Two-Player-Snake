`timescale 1ns / 1ps

module Master_Game(
        input CLK, //k
        input PS2Data,
        input PS2Clk,
        output [11:0] COLOUR_OUT, //k
        output HS, //k
        output VS, //k
        output [3:0] SEG_SELECT,
        output [7:0] HEX_OUT //k
    );
    
    wire [4:0] score;
    wire [1:0] state_master;
    wire [1:0] state_navigation;
    wire [1:0] state_navigation_2;
    wire [14:0] target_address;
    wire [18:0] address;
    wire [18:0] address_2;
    wire [11:0] colour;
    wire [11:0] colour_2;
    wire strobe;
    wire fail;
    wire fail_2;
    wire reached_target;
    wire reached_target_2;
    wire reset;
    // Keyboard input wires
    wire [15:0] keycode;
    wire flag;
    reg BTNU, BTND, BTNL, BTNR, BTNC; // Control signals
    reg BTNU_2, BTND_2, BTNL_2, BTNR_2; // Control signals
    
    // Instantiate PS2Receiver for keyboard input
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
                8'h1A: BTNL <= 1;
                8'h1D: BTNU <= 1; // Down Arrow
                8'h1B: BTND <= 1; // Left Arrow
                8'h23: BTNR <= 1; // Right Arrow
                8'h2D: BTNC <= 1; // 'R' Key (Reset)
                8'h3B: BTNL_2 <= 1; // Up Arrow for Snake 2
                8'h43: BTNU_2 <= 1; // Down Arrow for Snake 2
                8'h42: BTND_2 <= 1; // Left Arrow for Snake 2
                8'h4B: BTNR_2 <= 1; // Right Arrow for Snake 2
                default: begin
                    BTNU <= 0;
                    BTND <= 0;
                    BTNL <= 0;
                    BTNR <= 0;
                    BTNC <= 0;
                    BTNU_2 <= 0; BTND_2 <= 0; BTNL_2 <= 0; BTNR_2 <= 0;
                end
            endcase
        end else begin
            // Reset control signals when key is released
            BTNU <= 0;
            BTND <= 0;
            BTNL <= 0;
            BTNR <= 0;
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
                    
   Snake_control s2 (
                        .CLK(CLK),
                        .RESET(BTNC),
                        .score(score),
                        .state_master(state_master),
                        .state_navigation(state_navigation_2),
                        .target_address(target_address),
                        .pixel_address(address_2),
                        .COLOUR_OUT(colour_2),
                        .reached_target(reached_target_2),
                        .fail(fail_2)
                    );
                    
    
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
                            .STROBE(strobe),
                            .SCORE(score)
                        );
    
    wire [4:0] DecCountAndDOT0;
    wire [4:0] DecCountAndDOT1;
    wire [4:0] DecCountAndDOT2;
    wire [4:0] DecCountAndDOT3;
    
    wire [4:0] MuxOut;
    
    assign DecCountAndDOT0 = {4'b0, score[4]};
    assign DecCountAndDOT1 = {1'b0, score[3:0]};
    assign DecCountAndDOT2 = {5'b0};
    assign DecCountAndDOT3 = {5'b0};
    
    Multiplexer_4way Mux4(
                            .CONTROL({1'b0, strobe}),
                            .IN0(DecCountAndDOT0),
                            .IN1(DecCountAndDOT1),
                            .IN2(DecCountAndDOT2),
                            .IN3(DecCountAndDOT3),
                            .OUT(MuxOut)
                         );
    
    
    Segment_Display_Interface sdi   (
                                        .SEG_SELECT_IN({1'b0, strobe}),
                                        .BIN_IN(MuxOut[3:0]),
                                        .DOT_IN(1'b0),
                                        .SEG_SELECT_OUT(SEG_SELECT),
                                        .HEX_OUT(HEX_OUT)
                                    );
    
endmodule
