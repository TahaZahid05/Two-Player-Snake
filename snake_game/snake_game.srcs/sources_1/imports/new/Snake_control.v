`timescale 1ns / 1ps
module Snake_control(
    input CLK,
    input RESET,
    input [3:0] score_snake_one,
    input [3:0] score_snake_two,
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
    Generic_counter # (
                        .COUNTER_WIDTH(26),
                        .COUNTER_MAX(5000000)
                      )
                      moveSnake (
                        .CLK(CLK),
                        .RESET(RESET),
                        .ENABLE_IN(1'b1),
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
    
    //Create snake pixels
    genvar PixNo;
    generate
        for (PixNo = 0; PixNo < SnakeLength - 1; PixNo = PixNo + 1)
        begin: PixShift
            always@(posedge CLK) begin
                if (counter == 5000000) begin
                    SnakeState_X[PixNo + 1] <= SnakeState_X[PixNo];
                    SnakeState_Y[PixNo + 1] <= SnakeState_Y[PixNo];
                    SnakeState_X_2[PixNo+1] <= SnakeState_X_2[PixNo];
                    SnakeState_Y_2[PixNo+1] <= SnakeState_Y_2[PixNo];
                end
                else if(RESET) begin
                    SnakeState_X[PixNo + 1] <= 80;
                    SnakeState_Y[PixNo + 1] <= 100;
                    SnakeState_X_2[PixNo + 1] <= 150;
                    SnakeState_Y_2[PixNo + 1] <= 50;
                end
            end
        end
    endgenerate
    
    
    
    //Determine next position of snake
    always@(posedge CLK) begin
        if (counter == 5000000) begin
            case(state_navigation)
                2'd0: begin
                    if (SnakeState_X[0] == MaxX-10)
                        SnakeState_X[0] <= 40;
                    else
                        SnakeState_X[0] <= SnakeState_X[0] + 1;
                end
                
                2'd1: begin
                    if (SnakeState_Y[0] == MaxY-10)
                        SnakeState_Y[0] <= 10;
                    else
                        SnakeState_Y[0] <= SnakeState_Y[0] + 1;
                end
                
                2'd2: begin
                    if (SnakeState_Y[0] == 10)
                        SnakeState_Y[0] <= MaxY-10;
                    else
                        SnakeState_Y[0] <= SnakeState_Y[0] - 1;
                end
                
                2'd3: begin
                    if (SnakeState_X[0] == 40)
                        SnakeState_X[0] <= MaxX-10;
                    else
                        SnakeState_X[0] <= SnakeState_X[0] - 1;
                end
            endcase
            case(state_navigation_2)
                2'd0: begin
                    if (SnakeState_X_2[0] == MaxX-10)
                        SnakeState_X_2[0] <= 40;
                    else
                        SnakeState_X_2[0] <= SnakeState_X_2[0] + 1;
                end
                
                2'd1: begin
                    if (SnakeState_Y_2[0] == MaxY-10)
                        SnakeState_Y_2[0] <= 10;
                    else
                        SnakeState_Y_2[0] <= SnakeState_Y_2[0] + 1;
                end
                
                2'd2: begin
                    if (SnakeState_Y_2[0] == 10)
                        SnakeState_Y_2[0] <= MaxY-10;
                    else
                        SnakeState_Y_2[0] <= SnakeState_Y_2[0] - 1;
                end
                
                2'd3: begin
                    if (SnakeState_X_2[0] == 40)
                        SnakeState_X_2[0] <= MaxX-10;
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

    always @(posedge CLK) begin
        if (state_master == 2'd1) begin // PLAY
            colour <= 12'h000; // Default color
            crashed <= 1'b0;

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
                end
            end

            // Check for seed and poison addresses
            if (target_horizontal_addr[7:0] == horizontal_addr[9:2] && target_vertical_addr[6:0] == vertical_addr[8:2]) begin
                colour <= 12'h00f; // Seed color
            end else if (poison_horizontal_addr[7:0] == horizontal_addr[9:2] && poison_vertical_addr[6:0] == vertical_addr[8:2]) begin
                colour <= 12'h0f0; // Poison color
            end else begin
                // Check for snake one segments
                for (i = 0; i < 27; i = i + 1) begin
                    if (SnakeState_X[i] == horizontal_addr[9:2] && SnakeState_Y[i] == vertical_addr[8:2]) begin
                        if (score_snake_one >= (i / 3)) begin
                            colour <= 12'h0f0; // Snake one color
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
                            colour <= 12'h00f; // Snake two color
                            for (j = 3; j <= i; j = j + 1) begin
                                if (SnakeState_X_2[0] == SnakeState_X_2[j] && SnakeState_Y_2[0] == SnakeState_Y_2[j]) begin
                                    crashed <= 1'b1;
                                end
                            end
                        end
                    end
                end
            end
            if ((horizontal_addr[9:2] >= 30 && horizontal_addr[9:2] <= 40) || (horizontal_addr[9:2] >= MaxX - 10 && horizontal_addr[9:2] <= MaxX) || (vertical_addr[8:2] >= 0 && vertical_addr[8:2] <= 10 && horizontal_addr[9:2] >= 30) || (vertical_addr[8:2] >= MaxY - 10 && vertical_addr[8:2] <= MaxY && horizontal_addr[9:2] >= 30))
                colour <= 12'hf00; 
            if (score_snake_one + score_snake_two == 4'd0) begin
                if (((horizontal_addr[9:2] >= 10 && horizontal_addr[9:2] <= 12) && 
                        (vertical_addr[8:2] == 47 || vertical_addr[8:2] == 57)) || // Top and bottom horizontal lines
                    ((horizontal_addr[9:2] == 10 || horizontal_addr[9:2] == 12) && 
                        (vertical_addr[8:2] > 47 && vertical_addr[8:2] < 57))) begin // Left and right vertical lines
                    colour <= 12'h00f;
                end
            end 
            else if (score_snake_one + score_snake_two == 4'd1) begin
                if ((horizontal_addr[9:2] == 10 && vertical_addr[8:2] == 50) || (horizontal_addr[9:2] == 11 && vertical_addr[8:2] == 49)
                    || (horizontal_addr[9:2] == 12 && vertical_addr[8:2] >= 47 && vertical_addr[8:2] <= 57)) begin
                    colour <= 12'h00f;
                end
            end
            else if (score_snake_one + score_snake_two == 4'd2) begin
                if (((horizontal_addr[9:2] >= 10 && horizontal_addr[9:2] <= 12) && 
                            (vertical_addr[8:2] == 47 || vertical_addr[8:2] == 52 || vertical_addr[8:2] == 57)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 12 && vertical_addr[8:2] > 47 && vertical_addr[8:2] <= 52)) || // Top right vertical
                            ((horizontal_addr[9:2] == 10 && vertical_addr[8:2] >= 52 && vertical_addr[8:2] < 57))) begin // Bottom left vertical
                    colour <= 12'h00f;
                end
            end

            else if (score_snake_one + score_snake_two == 4'd3) begin
                if (((horizontal_addr[9:2] >= 10 && horizontal_addr[9:2] <= 12) && 
                            (vertical_addr[8:2] == 47 || vertical_addr[8:2] == 52 || vertical_addr[8:2] == 57)) || // Top, middle, bottom lines
                            (horizontal_addr[9:2] == 12 && vertical_addr[8:2] > 47 && vertical_addr[8:2] < 57)) begin // Right vertical line
                    colour <= 12'h00f;
                end  
            end
            else if (score_snake_one + score_snake_two == 4'd4) begin
                if (((horizontal_addr[9:2] == 10 || horizontal_addr[9:2] == 12) && 
                            (vertical_addr[8:2] >= 47 && vertical_addr[8:2] <= 52)) || // Left and right vertical lines (top half)
                            ((horizontal_addr[9:2] >= 10 && horizontal_addr[9:2] <= 12) && 
                            (vertical_addr[8:2] == 52)) || (horizontal_addr[9:2] == 12 &&
                            vertical_addr[8:2] > 52 && vertical_addr[8:2] <= 58)) begin // Middle horizontal line
                    colour <= 12'h00f;
                end
            end
            else if (score_snake_one + score_snake_two == 4'd5) begin
                if (((horizontal_addr[9:2] >= 10 && horizontal_addr[9:2] <= 12) && 
                            (vertical_addr[8:2] == 47 || vertical_addr[8:2] == 52 || vertical_addr[8:2] == 57)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 10 && vertical_addr[8:2] > 47 && vertical_addr[8:2] <= 52)) || // Top left vertical
                            ((horizontal_addr[9:2] == 12 && vertical_addr[8:2] >= 52 && vertical_addr[8:2] < 57))) begin // Bottom right vertical
                    colour <= 12'h00f;
                end
            end
            else if (score_snake_one + score_snake_two == 4'd6) begin
                if (((horizontal_addr[9:2] >= 10 && horizontal_addr[9:2] <= 12) && 
                            (vertical_addr[8:2] == 47 || vertical_addr[8:2] == 52 || vertical_addr[8:2] == 57)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 10 && vertical_addr[8:2] >= 47 && vertical_addr[8:2] <= 57)) || // Left vertical line
                            ((horizontal_addr[9:2] == 12 && vertical_addr[8:2] >= 52 && vertical_addr[8:2] < 57))) begin // Bottom right vertical
                    colour <= 12'h00f;
                end
            end
            else if (score_snake_one + score_snake_two == 4'd7) begin
                if (((horizontal_addr[9:2] >= 10 && horizontal_addr[9:2] <= 12) && 
                            (vertical_addr[8:2] == 47)) || // Top horizontal line
                            (horizontal_addr[9:2] == 12 && vertical_addr[8:2] > 47 && vertical_addr[8:2] <= 57)) begin // Right vertical line
                    colour <= 12'h00f;
                end
            end
            else if (score_snake_one + score_snake_two == 4'd8) begin
                if (((horizontal_addr[9:2] >= 10 && horizontal_addr[9:2] <= 12) && 
                            (vertical_addr[8:2] == 47 || vertical_addr[8:2] == 52 || vertical_addr[8:2] == 57)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 10 || horizontal_addr[9:2] == 12) && 
                            (vertical_addr[8:2] >= 47 && vertical_addr[8:2] <= 57))) begin // Left and right vertical lines
                    colour <= 12'h00f;
                end 
            end
            if (second_counter_units == 4'd0) begin
                if (((horizontal_addr[9:2] >= 24 && horizontal_addr[9:2] <= 26) && 
                        (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 87)) || // Top and bottom horizontal lines
                    ((horizontal_addr[9:2] == 24 || horizontal_addr[9:2] == 26) && 
                        (vertical_addr[8:2] > 77 && vertical_addr[8:2] < 87))) begin // Left and right vertical lines
                    colour <= 12'h00f;
                end
            end 
            else if (second_counter_units == 4'd1) begin
                if ((horizontal_addr[9:2] == 24 && vertical_addr[8:2] == 80) || (horizontal_addr[9:2] == 25 && vertical_addr[8:2] == 79)
                    || (horizontal_addr[9:2] == 26 && vertical_addr[8:2] >= 77 && vertical_addr[8:2] <= 87)) begin
                    colour <= 12'h00f;
                end
            end
            else if (second_counter_units == 4'd2) begin
                if (((horizontal_addr[9:2] >= 24 && horizontal_addr[9:2] <= 26) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 26 && vertical_addr[8:2] > 77 && vertical_addr[8:2] <= 82)) || // Top right vertical
                            ((horizontal_addr[9:2] == 24 && vertical_addr[8:2] >= 82 && vertical_addr[8:2] < 87))) begin // Bottom left vertical
                    colour <= 12'h00f;
                end
            end

            else if (second_counter_units == 4'd3) begin
                if (((horizontal_addr[9:2] >= 24 && horizontal_addr[9:2] <= 26) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            (horizontal_addr[9:2] == 26 && vertical_addr[8:2] > 77 && vertical_addr[8:2] < 87)) begin // Right vertical line
                    colour <= 12'h00f;
                end  
            end
            else if (second_counter_units == 4'd4) begin
                if (((horizontal_addr[9:2] == 24 || horizontal_addr[9:2] == 26) && 
                            (vertical_addr[8:2] >= 77 && vertical_addr[8:2] <= 82)) || // Left and right vertical lines (top half)
                            ((horizontal_addr[9:2] >= 24 && horizontal_addr[9:2] <= 26) && 
                            (vertical_addr[8:2] == 82)) || (horizontal_addr[9:2] == 26 &&
                            vertical_addr[8:2] > 82 && vertical_addr[8:2] <= 87)) begin // Middle horizontal line
                    colour <= 12'h00f;
                end
            end
            else if (second_counter_units == 4'd5) begin
                if (((horizontal_addr[9:2] >= 24 && horizontal_addr[9:2] <= 26) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 24 && vertical_addr[8:2] > 77 && vertical_addr[8:2] <= 82)) || // Top left vertical
                            ((horizontal_addr[9:2] == 26 && vertical_addr[8:2] >= 82 && vertical_addr[8:2] < 87))) begin // Bottom right vertical
                    colour <= 12'h00f;
                end
            end
            else if (second_counter_units == 4'd6) begin
                if (((horizontal_addr[9:2] >= 24 && horizontal_addr[9:2] <= 26) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 24 && vertical_addr[8:2] >= 77 && vertical_addr[8:2] <= 87)) || // Left vertical line
                            ((horizontal_addr[9:2] == 26 && vertical_addr[8:2] >= 82 && vertical_addr[8:2] < 87))) begin // Bottom right vertical
                    colour <= 12'h00f;
                end
            end
            else if (second_counter_units == 4'd7) begin
                if (((horizontal_addr[9:2] >= 24 && horizontal_addr[9:2] <= 26) && 
                            (vertical_addr[8:2] == 77)) || // Top horizontal line
                            (horizontal_addr[9:2] == 26 && vertical_addr[8:2] > 77 && vertical_addr[8:2] <= 87)) begin // Right vertical line
                    colour <= 12'h00f;
                end
            end
            else if (second_counter_units == 4'd8) begin
                if (((horizontal_addr[9:2] >= 24 && horizontal_addr[9:2] <= 26) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 24 || horizontal_addr[9:2] == 26) && 
                            (vertical_addr[8:2] >= 77 && vertical_addr[8:2] <= 87))) begin // Left and right vertical lines
                    colour <= 12'h00f;
                end 
            end
            else if (second_counter_units == 4'd9) begin
                if (((horizontal_addr[9:2] >= 24 && horizontal_addr[9:2] <= 26) && 
                    (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                    ((horizontal_addr[9:2] == 24 || horizontal_addr[9:2] == 26) && 
                    (vertical_addr[8:2] >= 77 && vertical_addr[8:2] <= 82)) || // Left and right vertical lines (top half)
                    (horizontal_addr[9:2] == 26 && vertical_addr[8:2] >= 82 && vertical_addr[8:2] <= 87)) begin // Right vertical line (bottom half)
                    colour <= 12'h00f;
                end 
            end
            if (second_counter_tens == 4'd0) begin
                if (((horizontal_addr[9:2] >= 20 && horizontal_addr[9:2] <= 22) && 
                        (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 87)) || // Top and bottom horizontal lines
                    ((horizontal_addr[9:2] == 20 || horizontal_addr[9:2] == 22) && 
                        (vertical_addr[8:2] > 77 && vertical_addr[8:2] < 87))) begin // Left and right vertical lines
                    colour <= 12'h00f;
                end
            end 
            else if (second_counter_tens == 4'd1) begin
                if ((horizontal_addr[9:2] == 20 && vertical_addr[8:2] == 80) || (horizontal_addr[9:2] == 21 && vertical_addr[8:2] == 79)
                    || (horizontal_addr[9:2] == 22 && vertical_addr[8:2] >= 77 && vertical_addr[8:2] <= 87)) begin
                    colour <= 12'h00f;
                end
            end
            else if (second_counter_tens == 4'd2) begin
                if (((horizontal_addr[9:2] >= 20 && horizontal_addr[9:2] <= 22) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 22 && vertical_addr[8:2] > 77 && vertical_addr[8:2] <= 82)) || // Top right vertical
                            ((horizontal_addr[9:2] == 20 && vertical_addr[8:2] >= 82 && vertical_addr[8:2] < 87))) begin // Bottom left vertical
                    colour <= 12'h00f;
                end
            end

            else if (second_counter_tens == 4'd3) begin
                if (((horizontal_addr[9:2] >= 20 && horizontal_addr[9:2] <= 22) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            (horizontal_addr[9:2] == 22 && vertical_addr[8:2] > 77 && vertical_addr[8:2] < 87)) begin // Right vertical line
                    colour <= 12'h00f;
                end  
            end
            else if (second_counter_tens == 4'd4) begin
                if (((horizontal_addr[9:2] == 20 || horizontal_addr[9:2] == 22) && 
                            (vertical_addr[8:2] >= 77 && vertical_addr[8:2] <= 82)) || // Left and right vertical lines (top half)
                            ((horizontal_addr[9:2] >= 20 && horizontal_addr[9:2] <= 22) && 
                            (vertical_addr[8:2] == 82)) || (horizontal_addr[9:2] == 22 &&
                            vertical_addr[8:2] > 82 && vertical_addr[8:2] <= 87)) begin // Middle horizontal line
                    colour <= 12'h00f;
                end
            end
            else if (second_counter_tens == 4'd5) begin
                if (((horizontal_addr[9:2] >= 20 && horizontal_addr[9:2] <= 22) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 20 && vertical_addr[8:2] > 77 && vertical_addr[8:2] <= 82)) || // Top left vertical
                            ((horizontal_addr[9:2] == 22 && vertical_addr[8:2] >= 82 && vertical_addr[8:2] < 87))) begin // Bottom right vertical
                    colour <= 12'h00f;
                end
            end
            if (minute_counter_units == 4'd0) begin
                if (((horizontal_addr[9:2] >= 14 && horizontal_addr[9:2] <= 16) && 
                        (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 87)) || // Top and bottom horizontal lines
                    ((horizontal_addr[9:2] == 14 || horizontal_addr[9:2] == 16) && 
                        (vertical_addr[8:2] > 77 && vertical_addr[8:2] < 87))) begin // Left and right vertical lines
                    colour <= 12'h00f;
                end
            end 
            else if (minute_counter_units == 4'd1) begin
                if ((horizontal_addr[9:2] == 14 && vertical_addr[8:2] == 80) || (horizontal_addr[9:2] == 15 && vertical_addr[8:2] == 79)
                    || (horizontal_addr[9:2] == 16 && vertical_addr[8:2] >= 77 && vertical_addr[8:2] <= 87)) begin
                    colour <= 12'h00f;
                end
            end
            else if (minute_counter_units == 4'd2) begin
                if (((horizontal_addr[9:2] >= 14 && horizontal_addr[9:2] <= 16) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 16 && vertical_addr[8:2] > 77 && vertical_addr[8:2] <= 82)) || // Top right vertical
                            ((horizontal_addr[9:2] == 14 && vertical_addr[8:2] >= 82 && vertical_addr[8:2] < 87))) begin // Bottom left vertical
                    colour <= 12'h00f;
                end
            end

            else if (minute_counter_units == 4'd3) begin
                if (((horizontal_addr[9:2] >= 14 && horizontal_addr[9:2] <= 16) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            (horizontal_addr[9:2] == 16 && vertical_addr[8:2] > 77 && vertical_addr[8:2] < 87)) begin // Right vertical line
                    colour <= 12'h00f;
                end  
            end
            else if (minute_counter_units == 4'd4) begin
                if (((horizontal_addr[9:2] == 14 || horizontal_addr[9:2] == 16) && 
                            (vertical_addr[8:2] >= 77 && vertical_addr[8:2] <= 82)) || // Left and right vertical lines (top half)
                            ((horizontal_addr[9:2] >= 14 && horizontal_addr[9:2] <= 16) && 
                            (vertical_addr[8:2] == 82)) || (horizontal_addr[9:2] == 16 &&
                            vertical_addr[8:2] > 82 && vertical_addr[8:2] <= 87)) begin // Middle horizontal line
                    colour <= 12'h00f;
                end
            end
            else if (minute_counter_units == 4'd5) begin
                if (((horizontal_addr[9:2] >= 14 && horizontal_addr[9:2] <= 16) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 14 && vertical_addr[8:2] > 77 && vertical_addr[8:2] <= 82)) || // Top left vertical
                            ((horizontal_addr[9:2] == 16 && vertical_addr[8:2] >= 82 && vertical_addr[8:2] < 87))) begin // Bottom right vertical
                    colour <= 12'h00f;
                end
            end
            else if (minute_counter_units == 4'd6) begin
                if (((horizontal_addr[9:2] >= 14 && horizontal_addr[9:2] <= 16) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 14 && vertical_addr[8:2] >= 77 && vertical_addr[8:2] <= 87)) || // Left vertical line
                            ((horizontal_addr[9:2] == 16 && vertical_addr[8:2] >= 82 && vertical_addr[8:2] < 87))) begin // Bottom right vertical
                    colour <= 12'h00f;
                end
            end
            else if (minute_counter_units == 4'd7) begin
                if (((horizontal_addr[9:2] >= 14 && horizontal_addr[9:2] <= 16) && 
                            (vertical_addr[8:2] == 77)) || // Top horizontal line
                            (horizontal_addr[9:2] == 16 && vertical_addr[8:2] > 77 && vertical_addr[8:2] <= 87)) begin // Right vertical line
                    colour <= 12'h00f;
                end
            end
            else if (minute_counter_units == 4'd8) begin
                if (((horizontal_addr[9:2] >= 14 && horizontal_addr[9:2] <= 16) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 14 || horizontal_addr[9:2] == 16) && 
                            (vertical_addr[8:2] >= 77 && vertical_addr[8:2] <= 87))) begin // Left and right vertical lines
                    colour <= 12'h00f;
                end 
            end
            else if (minute_counter_units == 4'd9) begin
                if (((horizontal_addr[9:2] >= 14 && horizontal_addr[9:2] <= 16) && 
                    (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                    ((horizontal_addr[9:2] == 14 || horizontal_addr[9:2] == 16) && 
                    (vertical_addr[8:2] >= 77 && vertical_addr[8:2] <= 82)) || // Left and right vertical lines (top half)
                    (horizontal_addr[9:2] == 16 && vertical_addr[8:2] >= 82 && vertical_addr[8:2] <= 87)) begin // Right vertical line (bottom half)
                    colour <= 12'h00f;
                end  
            end
            if (minute_counter_tens == 4'd0) begin
                if (((horizontal_addr[9:2] >= 10 && horizontal_addr[9:2] <= 12) && 
                        (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 87)) || // Top and bottom horizontal lines
                    ((horizontal_addr[9:2] == 10 || horizontal_addr[9:2] == 12) && 
                        (vertical_addr[8:2] > 77 && vertical_addr[8:2] < 87))) begin // Left and right vertical lines
                    colour <= 12'h00f;
                end
            end 
            else if (minute_counter_tens == 4'd1) begin
                if ((horizontal_addr[9:2] == 10 && vertical_addr[8:2] == 80) || (horizontal_addr[9:2] == 11 && vertical_addr[8:2] == 79)
                    || (horizontal_addr[9:2] == 12 && vertical_addr[8:2] >= 77 && vertical_addr[8:2] <= 87)) begin
                    colour <= 12'h00f;
                end
            end
            else if (minute_counter_tens == 4'd2) begin
                if (((horizontal_addr[9:2] >= 10 && horizontal_addr[9:2] <= 12) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 12 && vertical_addr[8:2] > 77 && vertical_addr[8:2] <= 82)) || // Top right vertical
                            ((horizontal_addr[9:2] == 10 && vertical_addr[8:2] >= 82 && vertical_addr[8:2] < 87))) begin // Bottom left vertical
                    colour <= 12'h00f;
                end
            end

            else if (minute_counter_tens == 4'd3) begin
                if (((horizontal_addr[9:2] >= 10 && horizontal_addr[9:2] <= 12) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            (horizontal_addr[9:2] == 12 && vertical_addr[8:2] > 77 && vertical_addr[8:2] < 87)) begin // Right vertical line
                    colour <= 12'h00f;
                end  
            end
            else if (minute_counter_tens == 4'd4) begin
                if (((horizontal_addr[9:2] == 10 || horizontal_addr[9:2] == 12) && 
                            (vertical_addr[8:2] >= 77 && vertical_addr[8:2] <= 82)) || // Left and right vertical lines (top half)
                            ((horizontal_addr[9:2] >= 10 && horizontal_addr[9:2] <= 12) && 
                            (vertical_addr[8:2] == 82)) || (horizontal_addr[9:2] == 12 &&
                            vertical_addr[8:2] > 82 && vertical_addr[8:2] <= 87)) begin // Middle horizontal line
                    colour <= 12'h00f;
                end
            end
            else if (minute_counter_tens == 4'd5) begin
                if (((horizontal_addr[9:2] >= 10 && horizontal_addr[9:2] <= 12) && 
                            (vertical_addr[8:2] == 77 || vertical_addr[8:2] == 82 || vertical_addr[8:2] == 87)) || // Top, middle, bottom lines
                            ((horizontal_addr[9:2] == 10 && vertical_addr[8:2] > 77 && vertical_addr[8:2] <= 82)) || // Top left vertical
                            ((horizontal_addr[9:2] == 12 && vertical_addr[8:2] >= 82 && vertical_addr[8:2] < 87))) begin // Bottom right vertical
                    colour <= 12'h00f;
                end
            end
            if ((horizontal_addr[9:2] == 18 && vertical_addr[8:2] == 80) || // Top dot of colon
                (horizontal_addr[9:2] == 18 && vertical_addr[8:2] == 82)) begin // Bottom dot of colon
                colour <= 12'h00f;
            end
        end
        else if (state_master == 2'd0) begin //IDLE
            // Coordinates for displaying "2 PLAYER SNAKE" at a specific position
            // Example coordinates (adjust these based on screen resolution and grid size)
            crashed <= 1'b0;
            if (horizontal_addr[9:2] >= 0 && horizontal_addr[9:2] <= 160 &&
                vertical_addr[8:2] >= 0 && vertical_addr[8:2] <= 120) begin
                if ((horizontal_addr[9:2] == 10 && vertical_addr[8:2] == 11) ||
                    (horizontal_addr[9:2] == 16 && vertical_addr[8:2] >= 11 && vertical_addr[8:2] <= 14) ||
                    (horizontal_addr[9:2] >= 11 && horizontal_addr[9:2] <= 15 && vertical_addr[8:2] == 10) || 
                    (horizontal_addr[9:2] == 15 && vertical_addr[8:2] == 15) || 
                    (horizontal_addr[9:2] == 14 && vertical_addr[8:2] == 16) ||
                    (horizontal_addr[9:2] == 13 && vertical_addr[8:2] == 17) ||
                    (horizontal_addr[9:2] == 12 && vertical_addr[8:2] == 18) ||
                    (horizontal_addr[9:2] == 11 && vertical_addr[8:2] == 19) ||
                    (horizontal_addr[9:2] == 10 && vertical_addr[8:2] >= 20 && vertical_addr[8:2] <= 22) ||
                    (horizontal_addr[9:2] >= 10 && horizontal_addr[9:2] <= 16 && vertical_addr[8:2] == 22))begin
                    colour <= 12'h0f0;
                end
                else if ((horizontal_addr[9:2] == 25 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 22) ||  // Vertical line
                         (horizontal_addr[9:2] >= 26 && horizontal_addr[9:2] <= 30 && vertical_addr[8:2] == 10) || // Top horizontal line
                         (horizontal_addr[9:2] >= 26 && horizontal_addr[9:2] <= 30 && vertical_addr[8:2] == 16) || // Middle horizontal line
                         (horizontal_addr[9:2] == 31 && vertical_addr[8:2] >= 11 && vertical_addr[8:2] <= 15)) begin // Right vertical line (top half)
                    colour <= 12'h0f0;
                end
                else if ((horizontal_addr[9:2] == 40 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 22) || // Vertical line
                         (horizontal_addr[9:2] >= 41 && horizontal_addr[9:2] <= 45 && vertical_addr[8:2] == 22)) begin // Bottom horizontal line
                    colour <= 12'h0f0;
                end
                // "A" at X=55, Y=10
                else if ((horizontal_addr[9:2] == 55 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 22) ||
                         (horizontal_addr[9:2] >= 56 && horizontal_addr[9:2] <= 60 && vertical_addr[8:2] == 10) ||
                         (horizontal_addr[9:2] == 61 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 22) ||
                         (horizontal_addr[9:2] >= 56 && horizontal_addr[9:2] <= 60 && vertical_addr[8:2] == 16)) begin
                    colour <= 12'h0f0;
                end
            
                // "Y" at X=70, Y=10
                else if ((horizontal_addr[9:2] == 70 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 15) ||
                         (horizontal_addr[9:2] == 74 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 15) ||
                         (horizontal_addr[9:2] >= 71 && horizontal_addr[9:2] <= 73 && vertical_addr[8:2] == 16) ||
                         (horizontal_addr[9:2] == 72 && vertical_addr[8:2] >= 17 && vertical_addr[8:2] <= 22)) begin
                    colour <= 12'h0f0;
                end
            
                // "E" at X=85, Y=10
                else if ((horizontal_addr[9:2] == 85 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 22) ||
                         (horizontal_addr[9:2] >= 86 && horizontal_addr[9:2] <= 90 && vertical_addr[8:2] == 10) ||
                         (horizontal_addr[9:2] >= 86 && horizontal_addr[9:2] <= 90 && vertical_addr[8:2] == 16) ||
                         (horizontal_addr[9:2] >= 86 && horizontal_addr[9:2] <= 90 && vertical_addr[8:2] == 22)) begin
                    colour <= 12'h0f0;
                end
            
                // "R" at X=100, Y=10
                else if ((horizontal_addr[9:2] == 100 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 22) ||
                         (horizontal_addr[9:2] >= 101 && horizontal_addr[9:2] <= 105 && vertical_addr[8:2] == 10) ||
                         (horizontal_addr[9:2] >= 101 && horizontal_addr[9:2] <= 105 && vertical_addr[8:2] == 16) ||
                         (horizontal_addr[9:2] == 106 && vertical_addr[8:2] >= 11 && vertical_addr[8:2] <= 15) ||
                         (horizontal_addr[9:2] == 105 && vertical_addr[8:2] == 17) ||
                         (horizontal_addr[9:2] == 106 && vertical_addr[8:2] >= 18 && vertical_addr[8:2] <= 22)) begin
                    colour <= 12'h0f0;
                end
            
                // "S" at X=115, Y=10
                else if ((horizontal_addr[9:2] >= 115-105 && horizontal_addr[9:2] <= 120-105 && vertical_addr[8:2] == 10+30) ||
                         (horizontal_addr[9:2] == 115-105 && vertical_addr[8:2] >= 11+30 && vertical_addr[8:2] <= 16+30) ||
                         (horizontal_addr[9:2] >= 115-105 && horizontal_addr[9:2] <= 120-105 && vertical_addr[8:2] == 16+30) ||
                         (horizontal_addr[9:2] == 120-105 && vertical_addr[8:2] >= 17+30 && vertical_addr[8:2] <= 22+30) ||
                         (horizontal_addr[9:2] >= 115-105 && horizontal_addr[9:2] <= 120-105 && vertical_addr[8:2] == 22+30)) begin
                    colour <= 12'h0f0;
                end
            
                // "N" at X=130, Y=10
                else if ((horizontal_addr[9:2] == 130-105 && vertical_addr[8:2] >= 10+30 && vertical_addr[8:2] <= 22+30) ||
                         (horizontal_addr[9:2] == 142-105 && vertical_addr[8:2] >= 10+30 && vertical_addr[8:2] <= 22+30) ||
                         (horizontal_addr[9:2] == (130-105 + vertical_addr[8:2] - (10 + 30)) && vertical_addr[8:2] >= 10+30 && vertical_addr[8:2] <= 22+30)) begin
                    colour <= 12'h0f0;
                end
            
                // "A" at X=150, Y=10
                else if ((horizontal_addr[9:2] == 150-105 && vertical_addr[8:2] >= 10+30 && vertical_addr[8:2] <= 22+30) ||
                         (horizontal_addr[9:2] >= 151-105 && horizontal_addr[9:2] <= 155-105 && vertical_addr[8:2] == 10+30) ||
                         (horizontal_addr[9:2] == 156-105 && vertical_addr[8:2] >= 10+30 && vertical_addr[8:2] <= 22+30) ||
                         (horizontal_addr[9:2] >= 151-105 && horizontal_addr[9:2] <= 155-105 && vertical_addr[8:2] == 16+30)) begin
                    colour <= 12'h0f0;
                end
            
                // "K" at X=165, Y=10
                else if ((horizontal_addr[9:2] == 165-105 && vertical_addr[8:2] >= 10+30 && vertical_addr[8:2] <= 22+30) ||
                         (horizontal_addr[9:2] == 166-105 && vertical_addr[8:2] == 16+30) ||
                         (horizontal_addr[9:2] == 167-105 && vertical_addr[8:2] == 17+30) ||
                         (horizontal_addr[9:2] == 168-105 && vertical_addr[8:2] == 18+30) ||
                         (horizontal_addr[9:2] == 167-105 && vertical_addr[8:2] == 15+30) ||
                         (horizontal_addr[9:2] == 168-105 && vertical_addr[8:2] == 14+30) ||
                         (horizontal_addr[9:2] == 169-105 && vertical_addr[8:2] == 19+30) ||
                         (horizontal_addr[9:2] == 170-105 && vertical_addr[8:2] == 20+30) ||
                         (horizontal_addr[9:2] == 171-105 && vertical_addr[8:2] == 21+30) ||
                         (horizontal_addr[9:2] == 172-105 && vertical_addr[8:2] == 22+30) ||
                         (horizontal_addr[9:2] == 169-105 && vertical_addr[8:2] == 13+30) ||
                         (horizontal_addr[9:2] == 170-105 && vertical_addr[8:2] == 12+30) ||
                         (horizontal_addr[9:2] == 171-105 && vertical_addr[8:2] == 11+30) ||
                         (horizontal_addr[9:2] == 172-105 && vertical_addr[8:2] == 10+30)) begin
                    colour <= 12'h0f0;
                end
            
                // "E" at X=185, Y=10
                else if ((horizontal_addr[9:2] == 180-105 && vertical_addr[8:2] >= 10+30 && vertical_addr[8:2] <= 22+30) ||
                         (horizontal_addr[9:2] >= 181-105 && horizontal_addr[9:2] <= 185-105 && vertical_addr[8:2] == 10+30) ||
                         (horizontal_addr[9:2] >= 181-105 && horizontal_addr[9:2] <= 185-105 && vertical_addr[8:2] == 16+30) ||
                         (horizontal_addr[9:2] >= 181-105 && horizontal_addr[9:2] <= 185-105 && vertical_addr[8:2] == 22+30)) begin
                    colour <= 12'h0f0;
                end
                else begin
                    colour <= 12'h000;
                end 
            end 
        end
        else if (state_master == 2'd2) begin
            crashed <= 1'b0;
            // "Y" at X=10, Y=10
            if ((horizontal_addr[9:2] == 10 && vertical_addr[8:2] == 10) ||
                (horizontal_addr[9:2] == 11 && vertical_addr[8:2] == 11) ||
                (horizontal_addr[9:2] == 12 && vertical_addr[8:2] == 12) ||
                (horizontal_addr[9:2] == 13 && vertical_addr[8:2] == 13) ||
                (horizontal_addr[9:2] == 14 && vertical_addr[8:2] == 14) ||
                (horizontal_addr[9:2] == 15 && vertical_addr[8:2] == 15) ||
                (horizontal_addr[9:2] == 16 && vertical_addr[8:2] == 16) ||
                (horizontal_addr[9:2] == 16 && vertical_addr[8:2] >= 17 && vertical_addr[8:2] <= 22) ||
                (horizontal_addr[9:2] == 17 && vertical_addr[8:2] == 15) ||
                (horizontal_addr[9:2] == 18 && vertical_addr[8:2] == 14) ||
                (horizontal_addr[9:2] == 19 && vertical_addr[8:2] == 13) ||
                (horizontal_addr[9:2] == 20 && vertical_addr[8:2] == 12) ||
                (horizontal_addr[9:2] == 21 && vertical_addr[8:2] == 11) ||
                (horizontal_addr[9:2] == 22 && vertical_addr[8:2] == 10)) begin
                colour <= 12'h0f0;  // Colour for "Y"
            end
            
            // "O" at X=25, Y=10
            else if ((horizontal_addr[9:2] >= 28 && horizontal_addr[9:2] <= 32 && vertical_addr[8:2] == 22) ||
                     (horizontal_addr[9:2] == 33 && vertical_addr[8:2] <= 21 && vertical_addr[8:2] >= 11) ||
                     (horizontal_addr[9:2] >= 28 && horizontal_addr[9:2] <= 32 && vertical_addr[8:2] == 10) ||
                     (horizontal_addr[9:2] == 27 && vertical_addr[8:2] >= 11 && vertical_addr[8:2] <= 21)) begin
                colour <= 12'h0f0;  // Colour for "O"
            end
            
            // "U" at X=40, Y=10
            else if ((horizontal_addr[9:2] == 38 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 21) ||
                     (horizontal_addr[9:2] == 43 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 21) ||
                     (horizontal_addr[9:2] >= 39 && horizontal_addr[9:2] <= 42 && vertical_addr[8:2] == 22)) begin
                colour <= 12'h0f0;  // Colour for "U"
            end
            
            // "W" at X=55, Y=10
            else if ((horizontal_addr[9:2] == 60 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 21) ||
                     (vertical_addr[8:2] == 22 && (horizontal_addr[9:2] == 61 || horizontal_addr[9:2] == 65)) ||
                     (horizontal_addr[9:2] >= 62 && horizontal_addr[9:2] <= 64 && vertical_addr[8:2] == 21) ||
                     (horizontal_addr[9:2] == 63 && vertical_addr[8:2] <= 20 && vertical_addr[8:2] >= 19) ||
                     (horizontal_addr[9:2] == 66 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 21)) begin
                colour <= 12'h0f0;  // Colour for "W"
            end
            
            // "I" at X=75, Y=10
            else if ((horizontal_addr[9:2] == 72 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 22) ||
                     (horizontal_addr[9:2] == 71 && (vertical_addr[8:2] == 10 || vertical_addr[8:2] == 22)) ||
                     (horizontal_addr[9:2] == 73 && (vertical_addr[8:2] == 10 || vertical_addr[8:2] == 22))) begin
                colour <= 12'h0f0;  // Colour for "I"
            end
            
            // "N" at X=85, Y=10
            else if ((horizontal_addr[9:2] == 78 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 22) ||
                     (horizontal_addr[9:2] == 90 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 22) ||
                     (horizontal_addr[9:2] == (78 + vertical_addr[8:2] - 10 ) && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 22)) begin
                colour <= 12'h0f0;
            end
            
            else begin
                colour <= 12'h000;  // Background color
            end
        end
        else if (state_master == 2'd3) begin //losing screen
            crashed <= 1'b0;
            // "Y" at X=10, Y=10
            if ((horizontal_addr[9:2] == 10 && vertical_addr[8:2] == 10) ||
                (horizontal_addr[9:2] == 11 && vertical_addr[8:2] == 11) ||
                (horizontal_addr[9:2] == 12 && vertical_addr[8:2] == 12) ||
                (horizontal_addr[9:2] == 13 && vertical_addr[8:2] == 13) ||
                (horizontal_addr[9:2] == 14 && vertical_addr[8:2] == 14) ||
                (horizontal_addr[9:2] == 15 && vertical_addr[8:2] == 15) ||
                (horizontal_addr[9:2] == 16 && vertical_addr[8:2] == 16) ||
                (horizontal_addr[9:2] == 16 && vertical_addr[8:2] >= 17 && vertical_addr[8:2] <= 22) ||
                (horizontal_addr[9:2] == 17 && vertical_addr[8:2] == 15) ||
                (horizontal_addr[9:2] == 18 && vertical_addr[8:2] == 14) ||
                (horizontal_addr[9:2] == 19 && vertical_addr[8:2] == 13) ||
                (horizontal_addr[9:2] == 20 && vertical_addr[8:2] == 12) ||
                (horizontal_addr[9:2] == 21 && vertical_addr[8:2] == 11) ||
                (horizontal_addr[9:2] == 22 && vertical_addr[8:2] == 10)) begin
                colour <= 12'h0f0;  // Colour for "Y"
            end
            
            // "O" at X=25, Y=10
            else if ((horizontal_addr[9:2] >= 28 && horizontal_addr[9:2] <= 32 && vertical_addr[8:2] == 22) ||
                     (horizontal_addr[9:2] == 33 && vertical_addr[8:2] <= 21 && vertical_addr[8:2] >= 11) ||
                     (horizontal_addr[9:2] >= 28 && horizontal_addr[9:2] <= 32 && vertical_addr[8:2] == 10) ||
                     (horizontal_addr[9:2] == 27 && vertical_addr[8:2] >= 11 && vertical_addr[8:2] <= 21)) begin
                colour <= 12'h0f0;  // Colour for "O"
            end
            
            // "U" at X=40, Y=10
            else if ((horizontal_addr[9:2] == 38 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 21) ||
                     (horizontal_addr[9:2] == 43 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 21) ||
                     (horizontal_addr[9:2] >= 39 && horizontal_addr[9:2] <= 42 && vertical_addr[8:2] == 22)) begin
                colour <= 12'h0f0;  // Colour for "U"
            end
            
            // "L" at X=55, Y=10
            else if ((horizontal_addr[9:2] == 60 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 22) ||
                     (vertical_addr[8:2] == 22 && horizontal_addr[9:2] >= 60 && horizontal_addr[9:2] <= 65)) begin
                colour <= 12'h0f0;  // Colour for "L"
            end
            
            // "O" at X=70, Y=10
            else if ((horizontal_addr[9:2] == 70 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 22) ||
                     (horizontal_addr[9:2] == 77 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 22) ||
                     (vertical_addr[8:2] == 10 && horizontal_addr[9:2] >= 70 && horizontal_addr[9:2] <= 77) ||
                     (vertical_addr[8:2] == 22 && horizontal_addr[9:2] >= 70 && horizontal_addr[9:2] <= 77)) begin
                colour <= 12'h0f0;  // Colour for "O"
            end
            
            // "S" at X=85, Y=10
            else if ((vertical_addr[8:2] == 10 && horizontal_addr[9:2] >= 85 && horizontal_addr[9:2] <= 92) ||
                     (vertical_addr[8:2] == 16 && horizontal_addr[9:2] >= 85 && horizontal_addr[9:2] <= 92) ||
                     (vertical_addr[8:2] == 22 && horizontal_addr[9:2] >= 85 && horizontal_addr[9:2] <= 92) ||
                     (horizontal_addr[9:2] == 85 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 16) ||
                     (horizontal_addr[9:2] == 92 && vertical_addr[8:2] >= 16 && vertical_addr[8:2] <= 22)) begin
                colour <= 12'h0f0;  // Colour for "S"
            end
            
            // "E" at X=100, Y=10
            else if ((horizontal_addr[9:2] == 100 && vertical_addr[8:2] >= 10 && vertical_addr[8:2] <= 22) ||
                     (vertical_addr[8:2] == 10 && horizontal_addr[9:2] >= 100 && horizontal_addr[9:2] <= 107) ||
                     (vertical_addr[8:2] == 16 && horizontal_addr[9:2] >= 100 && horizontal_addr[9:2] <= 105) ||
                     (vertical_addr[8:2] == 22 && horizontal_addr[9:2] >= 100 && horizontal_addr[9:2] <= 107)) begin
                colour <= 12'h0f0;  // Colour for "E"
            end 

            
            else begin
                colour <= 12'h000;  // Background color
            end
        end
        else //OTHER
            colour <= 12'h000;
    end
    
endmodule
