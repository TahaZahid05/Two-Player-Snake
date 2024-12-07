`timescale 1ns / 1ps
module Snake_control(
    input CLK,
    input RESET,
    input signed [3:0] score_snake_one,
    input signed [3:0] score_snake_two,
    input [1:0] state_master,
    input [1:0] state_navigation,
    input [1:0] state_navigation_2,
    input [14:0] target_address,
    input [14:0] poison_address,
    input [18:0] pixel_address,
    input [3:0] second_counter_units,
    input [2:0] second_counter_tens,
    input [3:0] minute_counter_units,
    input [2:0] minute_counter_tens,
    input [1:0] lives,
    input levels,
    output [11:0] COLOUR_OUT,
    output reached_target_one,
    output reached_target_two,
    output reached_poison_one,
    output reached_poison_two,
    output fail
    );
    wire [25:0] counter;
    reg crashed;
    reg [11:0] colour;
    assign fail = crashed;
    reg [25:0] counter_max;
    
    always @(*) begin
        if (levels)
            counter_max = 2500000;
        else 
            counter_max = 5000000;
    end
    
    Generic_counter # (
                        .COUNTER_WIDTH(26)
                      )
                      moveSnake (
                        .CLK(CLK),
                        .RESET(RESET),
                        .ENABLE_IN(1'b1),
                        .COUNTER_MAX(counter_max),
                        .COUNT(counter)
                      );
                      
    reg reached_one;
    reg reached_two;
    assign reached_target_one = reached_one;
    assign reached_target_two = reached_two;
    
    reg reached_p_one;
    reg reached_p_two;
    assign reached_poison_one = reached_p_one;
    assign reached_poison_two = reached_p_two;
   
    wire [6:0] target_vertical_addr;
    wire [7:0] target_horizontal_addr;
    wire [6:0] poison_vertical_addr;
    wire [7:0] poison_horizontal_addr;
    
    wire [9:0] horizontal_addr;
    wire [8:0] vertical_addr;
    
    assign target_horizontal_addr = target_address[14:7]; //8bit
    assign target_vertical_addr = target_address[6:0]; //7bit
    assign poison_horizontal_addr = poison_address[14:7]; 
    assign poison_vertical_addr = poison_address[6:0];
    assign vertical_addr = pixel_address[8:0]; //9 bit
    assign horizontal_addr = pixel_address[18:9]; //10 bit
    
    assign COLOUR_OUT = colour;
    parameter MaxY = 120;
    parameter MaxX = 160;    
    parameter SnakeLength = 27;
    
    reg [7:0] SnakeState_X [0:SnakeLength-1];
    reg [6:0] SnakeState_Y [0:SnakeLength-1];
    
    reg [7:0] SnakeState_X_2 [0:SnakeLength-1];
    reg [6:0] SnakeState_Y_2 [0:SnakeLength-1];
    
    reg executed_once;
    
    //Create snake pixels
    genvar PixNo;
    generate
        for (PixNo = 0; PixNo < SnakeLength - 1; PixNo = PixNo + 1)
        begin: PixShift
            always@(posedge CLK) begin
                if(RESET) begin
                    executed_once <= 0;
                end
                if(~executed_once) begin
                    SnakeState_X[PixNo + 1] <= 5;
                    SnakeState_Y[PixNo + 1] <= 45;
                    SnakeState_X_2[PixNo + 1] <= MaxX-5;
                    SnakeState_Y_2[PixNo + 1] <= 105;
                    executed_once <= 1;
                end
                if (counter == counter_max) begin
                    SnakeState_X[PixNo + 1] <= SnakeState_X[PixNo];
                    SnakeState_Y[PixNo + 1] <= SnakeState_Y[PixNo];
                    SnakeState_X_2[PixNo+1] <= SnakeState_X_2[PixNo];
                    SnakeState_Y_2[PixNo+1] <= SnakeState_Y_2[PixNo];
                end
            end
        end
    endgenerate
    
    
    
    
    
    //Determine next position of snake
    always@(posedge CLK) begin
        if (counter == counter_max) begin
            case(state_navigation)
                2'd0: begin
                    if (SnakeState_X[0] == MaxX-5)
                        SnakeState_X[0] <= 5;
                    else
                        SnakeState_X[0] <= SnakeState_X[0] + 1;
                end
                
                2'd1: begin
                    if (SnakeState_Y[0] == MaxY-5)
                        SnakeState_Y[0] <= 40;
                    else
                        SnakeState_Y[0] <= SnakeState_Y[0] + 1;
                end
                
                2'd2: begin
                    if (SnakeState_Y[0] == 40)
                        SnakeState_Y[0] <= MaxY-5;
                    else
                        SnakeState_Y[0] <= SnakeState_Y[0] - 1;
                end
                
                2'd3: begin
                    if (SnakeState_X[0] == 5)
                        SnakeState_X[0] <= MaxX-5;
                    else
                        SnakeState_X[0] <= SnakeState_X[0] - 1;
                end
            endcase
            case(state_navigation_2)
                2'd0: begin
                    if (SnakeState_X_2[0] == MaxX-5)
                        SnakeState_X_2[0] <= 5;
                    else
                        SnakeState_X_2[0] <= SnakeState_X_2[0] + 1;
                end
                
                2'd1: begin
                    if (SnakeState_Y_2[0] == MaxY-5)
                        SnakeState_Y_2[0] <= 40;
                    else
                        SnakeState_Y_2[0] <= SnakeState_Y_2[0] + 1;
                end
                
                2'd2: begin
                    if (SnakeState_Y_2[0] == 40)
                        SnakeState_Y_2[0] <= MaxY-5;
                    else
                        SnakeState_Y_2[0] <= SnakeState_Y_2[0] - 1;
                end
                
                2'd3: begin
                    if (SnakeState_X_2[0] == 5)
                        SnakeState_X_2[0] <= MaxX-5;
                    else
                        SnakeState_X_2[0] <= SnakeState_X_2[0] - 1;
                end
            endcase
        end
    end    
    
    
    
    always@(posedge CLK) begin
        if (SnakeState_X[0] == target_horizontal_addr[7:0] && SnakeState_Y[0] == target_vertical_addr[6:0])
            reached_one <= 1'b1;
        else if (SnakeState_X_2[0] == target_horizontal_addr[7:0] && SnakeState_Y_2[0] == target_vertical_addr[6:0])
            reached_two <= 1'b1;
        else begin
            reached_one <= 1'b0;
            reached_two <= 1'b0;
        end
        if (SnakeState_X[0] == poison_horizontal_addr[7:0] && SnakeState_Y[0] == poison_vertical_addr[6:0])
            reached_p_one <= 1'b1;
        else if (SnakeState_X_2[0] == poison_horizontal_addr[7:0] && SnakeState_Y_2[0] == poison_vertical_addr[6:0])
            reached_p_two <= 1'b1;
        else begin
            reached_p_one <= 1'b0;
            reached_p_two <= 1'b0;
        end
    end

    integer i;
    integer j;
    
   wire [11:0] score_colour;
   wire [11:0] second_units_colour;
   wire [11:0] second_tens_colour;
   wire [11:0] minute_units_colour;
   wire [11:0] minute_tens_colour;
   wire [11:0] S_colour;
   wire [11:0] C_colour;
   wire [11:0] O_colour;
   wire [11:0] R_colour;
   wire [11:0] E_colour;
   wire [11:0] T_colour;
   wire [11:0] I_colour;
   wire [11:0] M_colour;
   wire [11:0] T_E_colour;
   wire [11:0] T_R_colour;
   wire [11:0] TWO_colour;
   wire [11:0] P_colour;
   wire [11:0] L_colour;
   wire [11:0] A_colour; 
   wire [11:0] Y_colour;
   wire [11:0] P_E_colour;
   wire [11:0] P_R_colour;
   wire [11:0] P_S_colour;
   wire [11:0] N_colour;
   wire [11:0] P_A_colour;
   wire [11:0] K_colour;
   wire [11:0] P_P_E_colour;
   wire [11:0] WIN_Y_colour;
   wire [11:0] WIN_O_colour;
   wire [11:0] WIN_U_colour;
   wire [11:0] WIN_W_colour;
   wire [11:0] WIN_I_colour;
   wire [11:0] WIN_N_colour;
   wire [11:0] LOSE_L_colour;
   wire [11:0] LOSE_O_colour;
   wire [11:0] LOSE_S_colour;
   wire [11:0] LOSE_E_colour;
   wire [11:0] TARGET_T_colour;
   wire [11:0] TARGET_A_colour;
   wire [11:0] TARGET_R_colour;
   wire [11:0] TARGET_G_colour;
   wire [11:0] TARGET_E_colour;
   wire [11:0] TARGET_T_2_colour;
   wire [11:0] TARGET_s_colour;
   wire [11:0] P1_P_colour;
   wire [11:0] P1_1_colour;
   wire [11:0] P1_score_colour;
   wire [11:0] P2_P_colour;
   wire [11:0] P2_2_colour;
   wire [11:0] P2_score_colour;
   wire [11:0] LIVES_L_colour;
   wire [11:0] LIVES_I_colour;
   wire [11:0] LIVES_V_colour;
   wire [11:0] LIVES_E_colour;
   wire [11:0] LIVES_S_colour;
//   wire [11:0] LIVES_score_colour;
   wire [11:0] LIVES_heart_colour_1;
   wire [11:0] LIVES_heart_colour_2;
   wire [11:0] LIVES_heart_colour_3;
   
   alphabetGen TARGET_T(6'd19,horizontal_addr,vertical_addr,4,10,12'h0f0,0,TARGET_T_colour);
   alphabetGen TARGET_A(6'd0,horizontal_addr,vertical_addr,10,10,12'h0f0,0,TARGET_A_colour);
   alphabetGen TARGET_R(6'd17,horizontal_addr,vertical_addr,15,10,12'h0f0,0,TARGET_R_colour);
   alphabetGen TARGET_G(6'd6,horizontal_addr,vertical_addr,20,10,12'h0f0,0,TARGET_G_colour);
   alphabetGen TARGET_E(6'd4,horizontal_addr,vertical_addr,25,10,12'h0f0,0,TARGET_E_colour);
   alphabetGen TARGET_T_2(6'd19,horizontal_addr,vertical_addr,29,10,12'h0f0,0,TARGET_T_2_colour);
   scoreDisplay TARGET_s(horizontal_addr,vertical_addr,4'd8,0,16,18,19,29,12'h0f0,TARGET_s_colour);
   
   scoreDisplay s1(horizontal_addr,vertical_addr,score_snake_one,score_snake_two,47,49,19,29,12'h00f,score_colour);
   scoreDisplay s2(horizontal_addr,vertical_addr,second_counter_units,0,82,84,19,29,12'hf00,second_units_colour);
   scoreDisplay s3(horizontal_addr,vertical_addr,second_counter_tens,0,78,80,19,29,12'hf00,second_tens_colour);
   scoreDisplay s4(horizontal_addr,vertical_addr,minute_counter_units,0,72,74,19,29,12'hf00,minute_units_colour);
   scoreDisplay s5(horizontal_addr,vertical_addr,minute_counter_tens,0,68,70,19,29,12'hf00,minute_tens_colour);
   
   alphabetGen S(6'd18,horizontal_addr,vertical_addr,38,10,12'h00f,0,S_colour);
   alphabetGen C(6'd2,horizontal_addr,vertical_addr,42,10,12'h00f,0,C_colour);
   alphabetGen O(6'd14,horizontal_addr,vertical_addr,46,10,12'h00f,0,O_colour);
   alphabetGen R(6'd17,horizontal_addr,vertical_addr,50,10,12'h00f,0,R_colour);
   alphabetGen E(6'd4,horizontal_addr,vertical_addr,55,10,12'h00f,0,E_colour);
   
   
   alphabetGen T(6'd19,horizontal_addr,vertical_addr,65,10,12'hf00,0,T_colour);
   alphabetGen I(6'd8,horizontal_addr,vertical_addr,71,10,12'hf00,0,I_colour);
   alphabetGen M(6'd12,horizontal_addr,vertical_addr,73,10,12'hf00,0,M_colour);
   alphabetGen T_E(6'd4,horizontal_addr,vertical_addr,79,10,12'hf00,0,T_E_colour);
   alphabetGen T_R(6'd17,horizontal_addr,vertical_addr,83,10,12'hf00,0,T_R_colour);
   
   scoreDisplay s6(horizontal_addr,vertical_addr,4'd2,0,10,16,11,22,12'h0f0,TWO_colour);
   alphabetGen P(6'd15,horizontal_addr,vertical_addr,25,10,12'h0f0,1,P_colour);
   alphabetGen L(6'd11,horizontal_addr,vertical_addr,40,10,12'h0f0,1,L_colour);
   alphabetGen A(6'd0,horizontal_addr,vertical_addr,55,10,12'h0f0,1,A_colour);
   alphabetGen Y(6'd24,horizontal_addr,vertical_addr,70,10,12'h0f0,1,Y_colour);
   alphabetGen P_E(6'd4,horizontal_addr,vertical_addr,85,10,12'h0f0,1,P_E_colour);
   alphabetGen P_R(6'd17,horizontal_addr,vertical_addr,100,10,12'h0f0,1,P_R_colour);
   alphabetGen P_S(6'd18,horizontal_addr,vertical_addr,10,40,12'h0f0,1,P_S_colour);
   alphabetGen N(6'd13,horizontal_addr,vertical_addr,20,40,12'h0f0,1,N_colour);
   alphabetGen P_A(6'd0,horizontal_addr,vertical_addr,37,40,12'h0f0,1,P_A_colour);
   alphabetGen K(6'd10,horizontal_addr, vertical_addr,48,40,12'h0f0,1,K_colour);
   alphabetGen P_P_E(6'd4,horizontal_addr,vertical_addr,60,40,12'h0f0,1,P_P_E_colour);
   
   alphabetGen WIN_Y(6'd24,horizontal_addr,vertical_addr,5,39,12'h0f0,1,WIN_Y_colour);
   alphabetGen WIN_O(6'd14,horizontal_addr,vertical_addr,14,39,12'h0f0,1,WIN_O_colour);
   alphabetGen WIN_U(6'd20,horizontal_addr,vertical_addr,25,39,12'h0f0,1,WIN_U_colour);
   alphabetGen WIN_W(6'd22,horizontal_addr,vertical_addr,40,39,12'h0f0,1,WIN_W_colour);
   alphabetGen WIN_I(6'd8,horizontal_addr,vertical_addr,51,39,12'h0f0,1,WIN_I_colour);
   alphabetGen WIN_N(6'd13,horizontal_addr,vertical_addr,58,39,12'h0f0,1,WIN_N_colour);
   
   alphabetGen LOSE_L(6'd11,horizontal_addr,vertical_addr,40,39,12'h0f0,1,LOSE_L_colour);
   alphabetGen LOSE_O(6'd14,horizontal_addr,vertical_addr,50,39,12'h0f0,1,LOSE_O_colour);
   alphabetGen LOSE_S(6'd18,horizontal_addr,vertical_addr,61,39,12'h0f0,1,LOSE_S_colour);
   alphabetGen LOSE_E(6'd4,horizontal_addr,vertical_addr,71,39,12'h0f0,1,LOSE_E_colour);
   
   alphabetGen P1_P(6'd15,horizontal_addr,vertical_addr,94,10,12'h0ff,0,P1_P_colour);
   alphabetGen P1_1(6'd26,horizontal_addr,vertical_addr,100,10,12'h0ff,1,P1_1_colour);
//   scoreDisplay P1_1(horizontal_addr,vertical_addr,4'd1,4'd0,100,102,10,14,12'h0ff,P1_1_colour);
   scoreDisplay P1_score(horizontal_addr,vertical_addr,score_snake_one,4'd0,97,99,19,29,12'h0ff,P1_score_colour);
   
   alphabetGen P2_P(6'd15,horizontal_addr,vertical_addr,106,10,12'h04f,0,P2_P_colour);
   alphabetGen P2_2(6'd27,horizontal_addr,vertical_addr,112,10,12'h04f,1,P2_2_colour);
//   scoreDisplay P2_1(horizontal_addr,vertical_addr,4'd2,4'd0,112,114,10,15,12'h04f,P2_2_colour);
   scoreDisplay P2_score(horizontal_addr,vertical_addr,score_snake_two,4'd0,109,111,19,29,12'h04f,P2_score_colour);
   
   alphabetGen LIVES_L(6'd11,horizontal_addr,vertical_addr,120,10,12'hf0f,0,LIVES_L_colour);
   alphabetGen LIVES_I(6'd8,horizontal_addr,vertical_addr,125,10,12'hf0f,0,LIVES_I_colour); 
   alphabetGen LIVES_V(6'd21,horizontal_addr,vertical_addr,127,10,12'hf0f,0,LIVES_V_colour);
   alphabetGen LIVES_E(6'd4,horizontal_addr,vertical_addr,134,10,12'hf0f,0,LIVES_E_colour);
   alphabetGen LIVES_S(6'd18,horizontal_addr,vertical_addr,138,10,12'hf0f,0,LIVES_S_colour);
   alphabetGen LIVES_heart_1(6'd28,horizontal_addr,vertical_addr,120,19,12'hf0f,0,LIVES_heart_colour_1);
   alphabetGen LIVES_heart_2(6'd28,horizontal_addr,vertical_addr,130,19,12'hf0f,0,LIVES_heart_colour_2);
   alphabetGen LIVES_heart_3(6'd28,horizontal_addr,vertical_addr,140,19,12'hf0f,0,LIVES_heart_colour_3);
//   scoreDisplay LIVES_score(horizontal_addr,vertical_addr,(2'd3 - lives),4'd0,128,130,19,29,12'hf0f,LIVES_score_colour);
   
   reg [25:0] timer;
   
    always @(posedge CLK) begin
        if (state_master == 2'd1) begin // 
            colour <= 12'h000; // Default color
            crashed <= 1'b0;
            
            if((reached_p_one || reached_p_two)&&((score_snake_one == -4'd1) && (score_snake_two == -4'd1)))
                crashed <= 1'b1;
            // Check for seed and poison addresses
            else if (target_horizontal_addr[7:0] == horizontal_addr[9:2] && target_vertical_addr[6:0] == vertical_addr[8:2]) begin
                colour <= 12'h00f; // Seed color
            end else if (poison_horizontal_addr[7:0] == horizontal_addr[9:2] && poison_vertical_addr[6:0] == vertical_addr[8:2]) begin
                colour <= 12'h0f0; // Poison color
            end else begin
                // Check for snake one segments
                for (i = 0; i < 27; i = i + 1) begin
                    if (SnakeState_X[i] == horizontal_addr[9:2] && SnakeState_Y[i] == vertical_addr[8:2]) begin
                        if (score_snake_one >= (i / 3)) begin
                            colour <= 12'h0ff; // Snake one color
                            for (j = 3; j <= i; j = j + 1) begin
                                if (SnakeState_X[0] == SnakeState_X[j] && SnakeState_Y[0] == SnakeState_Y[j]) begin
                                    crashed <= 1'b1;
                                end
                            end
                        end
                    end
                end

                // Check for snake two segments
                for (i = 0; i < 27; i = i + 1) begin
                    if (SnakeState_X_2[i] == horizontal_addr[9:2] && SnakeState_Y_2[i] == vertical_addr[8:2]) begin
                        if (score_snake_two >= (i / 3)) begin
                            colour <= 12'h04f; // Snake two color
                            for (j = 3; j <= i; j = j + 1) begin
                                if (SnakeState_X_2[0] == SnakeState_X_2[j] && SnakeState_Y_2[0] == SnakeState_Y_2[j]) begin
                                    crashed <= 1'b1;
                                end
                            end
                        end
                    end
                end
                
            end
            
            if(timer <= counter_max*3) begin
                timer <= timer + 26'd1;
            end 
            else begin
                    // Check for collisions between snake one and snake two
                for (i = 0; i < 27; i = i + 1) begin
                    if ((i / 3) <= score_snake_one) begin // Check if the segment is active for snake one
                        for (j = 0; j < 27; j = j + 1) begin
                            if ((j / 3) <= score_snake_two) begin // Check if the segment is active for snake two
                                // Check if snake one collides with snake two
                                if ((SnakeState_X[i] == SnakeState_X_2[j]) && 
                                    (SnakeState_Y[i] == SnakeState_Y_2[j])) begin
                                    crashed <= 1'b1;
                                end
                                // Check if snake two collides with snake one
                                if ((SnakeState_X_2[j] == SnakeState_X[i]) && 
                                    (SnakeState_Y_2[j] == SnakeState_Y[i])) begin
                                    crashed <= 1'b1;
                                end
                            end
                        end
                        // Check if snake one collides with the hollow box
                    if (levels && (SnakeState_X[i] >= 5 && SnakeState_X[i] <= 50) &&
                        (SnakeState_Y[i] == ((MaxY+52) >> 1) - 15 || SnakeState_Y[i] == ((MaxY+52) >> 1) + 15)) begin
                        crashed <= 1'b1;
                    end
                    if (levels && (SnakeState_Y[i] >= ((MaxY+52) >> 1) - 15 && SnakeState_Y[i] <= ((MaxY+52) >> 1) + 15) &&
                        (SnakeState_X[i] == 50)) begin
                        crashed <= 1'b1;
                    end
                end
    
                    if (levels && ((i / 3) <= score_snake_two)) begin // Check if the segment is active for snake two
                        // Check if snake two collides with the hollow box
                        if ((SnakeState_X_2[i] >= 5 && SnakeState_X_2[i] <= 50) &&
                            (SnakeState_Y_2[i] == ((MaxY+52) >> 1) - 15 || SnakeState_Y_2[i] == ((MaxY+52) >> 1) + 15)) begin
                            crashed <= 1'b1;
                        end
                        if ((SnakeState_Y_2[i] >= ((MaxY+52) >> 1) - 15 && SnakeState_Y_2[i] <= ((MaxY+52) >> 1) + 15) &&
                            (SnakeState_X_2[i] == 50)) begin
                            crashed <= 1'b1;
                        end
                    end
                end 
            end

    
            if ((horizontal_addr[9:2] >= 0 && horizontal_addr[9:2] <= 5 && vertical_addr[8:2] >= 35) || 
                (horizontal_addr[9:2] >= MaxX - 5 && horizontal_addr[9:2] <= MaxX && vertical_addr[8:2] >= 35) || 
                (vertical_addr[8:2] >= 35 && vertical_addr[8:2] <= 40) || 
                (vertical_addr[8:2] >= MaxY - 5 && vertical_addr[8:2] <= MaxY) || 
                // Hollow smaller box in the center
                (levels && (horizontal_addr[9:2] >= 5 && horizontal_addr[9:2] <= 50) &&
                 (vertical_addr[8:2] == ((MaxY+52) >> 1) - 15 || vertical_addr[8:2] == ((MaxY+52) >> 1) + 15)) || 
                (levels && (vertical_addr[8:2] >= ((MaxY+52) >> 1) - 15 && vertical_addr[8:2] <= ((MaxY+52) >> 1) + 15) &&
                 (horizontal_addr[9:2] == 50))
                ) begin
                if(~levels)
                    colour <= 12'hf00;
                else
                    colour <= 12'h00f;
                end

            else begin
                if(score_colour != 12'h000) begin
                    colour <= score_colour;
                end else if (second_units_colour != 12'h000) begin
                    colour <= second_units_colour;
                end else if (second_tens_colour != 12'h000) begin
                    colour <= second_tens_colour;
                end else if (minute_units_colour != 12'h000) begin
                    colour <= minute_units_colour;
                end else if (minute_tens_colour != 12'h000) begin
                    colour <= minute_tens_colour;
                end else if (S_colour != 12'h000) begin
                    colour <= S_colour;
                end else if (C_colour != 12'h000) begin
                    colour <= C_colour;
                end else if (O_colour != 12'h000) begin
                    colour <= O_colour;
                end else if (R_colour != 12'h000) begin
                    colour <= R_colour; 
                end else if (E_colour != 12'h000) begin
                    colour <= E_colour;
                end else if (T_colour != 12'h000) begin 
                    colour <= T_colour;
                end else if (I_colour != 12'h000) begin 
                    colour <= I_colour;
                end else if (M_colour != 12'h000) begin
                    colour <= M_colour;
                end else if (T_E_colour != 12'h000) begin
                    colour <= T_E_colour;
                end else if (T_R_colour != 12'h000) begin
                    colour <= T_R_colour;
                end else if (TARGET_s_colour != 12'h000) begin
                    colour <= TARGET_s_colour;
                end else if (TARGET_T_colour != 12'h000) begin
                    colour <= TARGET_T_colour;
                end else if (TARGET_A_colour != 12'h000) begin
                    colour <= TARGET_A_colour;
                end else if (TARGET_R_colour != 12'h000) begin
                    colour <= TARGET_R_colour;
                end else if (TARGET_G_colour != 12'h000) begin
                    colour <= TARGET_G_colour;
                end else if (TARGET_E_colour != 12'h000) begin
                    colour <= TARGET_E_colour;
                end else if (TARGET_T_2_colour != 12'h000) begin
                    colour <= TARGET_T_2_colour;
                end else if (P1_P_colour != 12'h000) begin
                    colour <= P1_P_colour;
                end else if (P1_1_colour != 12'h000) begin
                    colour <= P1_1_colour;
                end else if (P1_score_colour != 12'h000) begin
                    colour <= P1_score_colour;
                end else if (P2_P_colour != 12'h000) begin
                    colour <= P2_P_colour;
                end else if (P2_2_colour != 12'h000) begin
                    colour <= P2_2_colour;
                end else if (P2_score_colour != 12'h000) begin
                    colour <= P2_score_colour;
                end else if (LIVES_L_colour != 12'h000) begin
                    colour <= LIVES_L_colour;
                end else if (LIVES_I_colour != 12'h000) begin
                    colour <= LIVES_I_colour;
                end else if (LIVES_V_colour != 12'h000) begin
                    colour <= LIVES_V_colour;
                end else if (LIVES_E_colour != 12'h000) begin
                    colour <= LIVES_E_colour;
                end else if (LIVES_S_colour != 12'h000) begin
                    colour <= LIVES_S_colour;
                end else if (LIVES_heart_colour_1 != 12'h000 && (2'd3 - lives) == 2'd3) begin
                    colour <= LIVES_heart_colour_1;
                end else if (LIVES_heart_colour_2 != 12'h000 && (2'd3 - lives) >= 2'd2) begin
                    colour <= LIVES_heart_colour_2;
                end else if (LIVES_heart_colour_3 != 12'h000 && (2'd3 - lives) >= 2'd1) begin
                    colour <= LIVES_heart_colour_3;
                end
                   
            end

            
            if ((horizontal_addr[9:2] == 76 && vertical_addr[8:2] == 23) || // Top dot of colon
                (horizontal_addr[9:2] == 76 && vertical_addr[8:2] == 25)) begin // Bottom dot of colon
                colour <= 12'hf00;
            end
        end
        else if (state_master == 2'd0) begin //IDLE
            // Coordinates for displaying "2 PLAYER SNAKE" at a specific position
            // Example coordinates (adjust these based on screen resolution and grid size)
            crashed <= 1'b0;
            colour <= 12'h000;
            if(TWO_colour != 12'h000)
                colour <= TWO_colour;
            else if(P_colour != 12'h000) 
                colour <= P_colour;
            else if(L_colour != 12'h000)
                colour <= L_colour;
            else if(A_colour != 12'h000)
                colour <= A_colour;
            else if(Y_colour != 12'h000)
                colour <= Y_colour;
            else if(P_E_colour != 12'h000)
                colour <= P_E_colour;
            else if(P_R_colour != 12'h000)
                colour <= P_R_colour;
            else if(P_S_colour != 12'h000)
                colour <= P_S_colour;
            else if(N_colour != 12'h000)
                colour <= N_colour;
            else if(P_A_colour != 12'h000)
                colour <= P_A_colour;
            else if(K_colour != 12'h000)
                colour <= K_colour;
            else if(P_P_E_colour != 12'h000)
                colour <= P_P_E_colour;
        end
        else if (state_master == 2'd2) begin
            crashed <= 1'b0;
            colour <= 12'h000;
            
            if ((horizontal_addr[9:2] == 76 && vertical_addr[8:2] == 23) || // Top dot of colon
                (horizontal_addr[9:2] == 76 && vertical_addr[8:2] == 25)) begin // Bottom dot of colon
                colour <= 12'hf00;
            end 
            else begin
                if(score_colour != 12'h000) begin
                    colour <= score_colour;
                end else if (second_units_colour != 12'h000) begin
                    colour <= second_units_colour;
                end else if (second_tens_colour != 12'h000) begin
                    colour <= second_tens_colour;
                end else if (minute_units_colour != 12'h000) begin
                    colour <= minute_units_colour;
                end else if (minute_tens_colour != 12'h000) begin
                    colour <= minute_tens_colour;
                end else if (S_colour != 12'h000) begin
                    colour <= S_colour;
                end else if (C_colour != 12'h000) begin
                    colour <= C_colour;
                end else if (O_colour != 12'h000) begin
                    colour <= O_colour;
                end else if (R_colour != 12'h000) begin
                    colour <= R_colour; 
                end else if (E_colour != 12'h000) begin
                    colour <= E_colour;
                end else if (T_colour != 12'h000) begin 
                    colour <= T_colour;
                end else if (I_colour != 12'h000) begin 
                    colour <= I_colour;
                end else if (M_colour != 12'h000) begin
                    colour <= M_colour;
                end else if (T_E_colour != 12'h000) begin
                    colour <= T_E_colour;
                end else if (T_R_colour != 12'h000) begin
                    colour <= T_R_colour;
                end else if (WIN_Y_colour != 12'h000) begin
                    colour <= WIN_Y_colour;
                end else if (WIN_O_colour != 12'h000) begin
                    colour <= WIN_O_colour;
                end else if (WIN_U_colour != 12'h000) begin
                    colour <= WIN_U_colour;
                end else if (WIN_W_colour != 12'h000) begin
                    colour <= WIN_W_colour;
                end else if (WIN_I_colour != 12'h000) begin
                    colour <= WIN_I_colour;
                end else if (WIN_N_colour != 12'h000) begin 
                    colour <= WIN_N_colour;
                end else if (P1_P_colour != 12'h000) begin
                    colour <= P1_P_colour;
                end else if (P1_1_colour != 12'h000) begin
                    colour <= P1_1_colour;
                end else if (P1_score_colour != 12'h000) begin
                    colour <= P1_score_colour;
                end else if (P2_P_colour != 12'h000) begin
                    colour <= P2_P_colour;
                end else if (P2_2_colour != 12'h000) begin
                    colour <= P2_2_colour;
                end else if (P2_score_colour != 12'h000) begin
                    colour <= P2_score_colour;
                end else if (TARGET_s_colour != 12'h000) begin
                    colour <= TARGET_s_colour;
                end else if (TARGET_T_colour != 12'h000) begin
                    colour <= TARGET_T_colour;
                end else if (TARGET_A_colour != 12'h000) begin
                    colour <= TARGET_A_colour;
                end else if (TARGET_R_colour != 12'h000) begin
                    colour <= TARGET_R_colour;
                end else if (TARGET_G_colour != 12'h000) begin
                    colour <= TARGET_G_colour;
                end else if (TARGET_E_colour != 12'h000) begin
                    colour <= TARGET_E_colour;
                end else if (TARGET_T_2_colour != 12'h000) begin
                    colour <= TARGET_T_2_colour;
                end
            end

        end
        else if (state_master == 2'd3) begin //losing screen
            crashed <= 1'b0;
            colour <= 12'h000;
            
            if ((horizontal_addr[9:2] == 76 && vertical_addr[8:2] == 23) || // Top dot of colon
                (horizontal_addr[9:2] == 76 && vertical_addr[8:2] == 25)) begin // Bottom dot of colon
                colour <= 12'hf00;
            end
            
            else begin
                if(score_colour != 12'h000) begin
                    colour <= score_colour;
                end else if (second_units_colour != 12'h000) begin
                    colour <= second_units_colour;
                end else if (second_tens_colour != 12'h000) begin
                    colour <= second_tens_colour;
                end else if (minute_units_colour != 12'h000) begin
                    colour <= minute_units_colour;
                end else if (minute_tens_colour != 12'h000) begin
                    colour <= minute_tens_colour;
                 end else if (S_colour != 12'h000) begin
                    colour <= S_colour;
                end else if (C_colour != 12'h000) begin
                    colour <= C_colour;
                end else if (O_colour != 12'h000) begin
                    colour <= O_colour;
                end else if (R_colour != 12'h000) begin
                    colour <= R_colour; 
                end else if (E_colour != 12'h000) begin
                    colour <= E_colour;
                end else if (T_colour != 12'h000) begin 
                    colour <= T_colour;
                end else if (I_colour != 12'h000) begin 
                    colour <= I_colour;
                end else if (M_colour != 12'h000) begin
                    colour <= M_colour;
                end else if (T_E_colour != 12'h000) begin
                    colour <= T_E_colour;
                end else if (T_R_colour != 12'h000) begin
                    colour <= T_R_colour;
                end else if (WIN_Y_colour != 12'h000) begin
                    colour <= WIN_Y_colour;
                end else if (WIN_O_colour != 12'h000) begin
                    colour <= WIN_O_colour;
                end else if (WIN_U_colour != 12'h000) begin
                    colour <= WIN_U_colour;
                end else if (LOSE_L_colour != 12'h000) begin
                    colour <= LOSE_L_colour;
                end else if (LOSE_O_colour != 12'h000) begin
                    colour <= LOSE_O_colour;
                end else if (LOSE_S_colour != 12'h000) begin
                    colour <= LOSE_S_colour;
                end else if (LOSE_E_colour != 12'h000) begin
                    colour <= LOSE_E_colour;
                end else if (P1_P_colour != 12'h000) begin
                    colour <= P1_P_colour;
                end else if (P1_1_colour != 12'h000) begin
                    colour <= P1_1_colour;
                end else if (P1_score_colour != 12'h000) begin
                    colour <= P1_score_colour;
                end else if (P2_P_colour != 12'h000) begin
                    colour <= P2_P_colour;
                end else if (P2_2_colour != 12'h000) begin
                    colour <= P2_2_colour;
                end else if (P2_score_colour != 12'h000) begin
                    colour <= P2_score_colour;
                end else if (TARGET_s_colour != 12'h000) begin
                    colour <= TARGET_s_colour;
                end else if (TARGET_T_colour != 12'h000) begin
                    colour <= TARGET_T_colour;
                end else if (TARGET_A_colour != 12'h000) begin
                    colour <= TARGET_A_colour;
                end else if (TARGET_R_colour != 12'h000) begin
                    colour <= TARGET_R_colour;
                end else if (TARGET_G_colour != 12'h000) begin
                    colour <= TARGET_G_colour;
                end else if (TARGET_E_colour != 12'h000) begin
                    colour <= TARGET_E_colour;
                end else if (TARGET_T_2_colour != 12'h000) begin
                    colour <= TARGET_T_2_colour;
                end
            end
              
        end
        else //OTHER
            colour <= 12'h000;
    end 
endmodule
