`timescale 1ns / 1ps

module Snake_control(
    input CLK,
    input RESET,
    input [3:0] score,
    input [1:0] state_master,
    input [1:0] state_navigation,
    input [14:0] target_address,
    input [18:0] pixel_address,
    output [11:0] COLOUR_OUT,
    output reached_target,
    output fail
    );
    
    wire [25:0] counter;
    reg crashed;
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
    
    reg reached;
    
    assign reached_target = reached;
    
    reg [11:0] colour;
    //reg [1:0] direction;
    
    wire [6:0] target_vertical_addr;
    wire [7:0] target_horizontal_addr;
    
    wire [9:0] horizontal_addr;
    wire [8:0] vertical_addr;
    
    assign target_horizontal_addr = target_address[14:7]; //8bit
    assign target_vertical_addr = target_address[6:0]; //7bit
    assign vertical_addr = pixel_address[8:0]; //9 bit
    assign horizontal_addr = pixel_address[18:9]; //10 bit
    
    assign COLOUR_OUT = colour;
    //assign state_navigation = direction;
    parameter MaxY = 120;
    parameter MaxX = 160;    
    parameter SnakeLength = 40;
    
    reg [7:0] SnakeState_X [0:SnakeLength-1];
    reg [6:0] SnakeState_Y [0:SnakeLength-1];
    
    //Create snake pixels
    genvar PixNo;
    generate
        for (PixNo = 0; PixNo < SnakeLength - 1; PixNo = PixNo + 1)
        begin: PixShift
            always@(posedge CLK) begin
                if (counter == 5000000) begin
                    SnakeState_X[PixNo + 1] <= SnakeState_X[PixNo];
                    SnakeState_Y[PixNo + 1] <= SnakeState_Y[PixNo];
                end
                else if(RESET) begin
                    SnakeState_X[PixNo + 1] <= 80;
                    SnakeState_Y[PixNo + 1] <= 100;
                end
            end
        end
    endgenerate
    
    //Determine next position of snake
    always@(posedge CLK) begin
        if (counter == 5000000) begin
            case(state_navigation)
                2'd0: begin
                    if (SnakeState_X[0] == MaxX)
                        SnakeState_X[0] <= 0;
                    else
                        SnakeState_X[0] <= SnakeState_X[0] + 1;
                end
                
                2'd1: begin
                    if (SnakeState_Y[0] == MaxY)
                        SnakeState_Y[0] <= 0;
                    else
                        SnakeState_Y[0] <= SnakeState_Y[0] + 1;
                end
                
                2'd2: begin
                    if (SnakeState_Y[0] == 0)
                        SnakeState_Y[0] <= MaxY;
                    else
                        SnakeState_Y[0] <= SnakeState_Y[0] - 1;
                end
                
                2'd3: begin
                    if (SnakeState_X[0] == 0)
                        SnakeState_X[0] <= MaxX;
                    else
                        SnakeState_X[0] <= SnakeState_X[0] - 1;
                end
            endcase
        end
    end    
    
    always@(posedge CLK) begin
        if (SnakeState_X[0] == target_horizontal_addr[7:0] && SnakeState_Y[0] == target_vertical_addr[6:0])
            reached <= 1'b1;
        else
            reached <= 1'b0;
    end
    
    always@(posedge CLK) begin
        if (state_master == 2'd1) begin //PLAY
            if (target_horizontal_addr[7:0] == horizontal_addr[9:2] && target_vertical_addr[6:0] == vertical_addr[8:2]) //Seed address
                colour <= 12'h00f;
			else if (SnakeState_X[0] == horizontal_addr[9:2] && SnakeState_Y[0] == vertical_addr[8:2]) begin
                if (score >= 4'd0) begin
                    colour <= 12'h000;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[1] == horizontal_addr[9:2] && SnakeState_Y[1] == vertical_addr[8:2]) begin
                if (score >= 4'd0) begin
                    colour <= 12'h000;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[2] == horizontal_addr[9:2] && SnakeState_Y[2] == vertical_addr[8:2]) begin
                if (score >= 4'd0) begin
                    colour <= 12'h000;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[3] == horizontal_addr[9:2] && SnakeState_Y[3] == vertical_addr[8:2]) begin
                if (score >= 4'd1) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[3] && SnakeState_Y[0] == SnakeState_Y[3])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[4] == horizontal_addr[9:2] && SnakeState_Y[4] == vertical_addr[8:2]) begin
                if (score >= 4'd1) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[4] && SnakeState_Y[0] == SnakeState_Y[4])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[5] == horizontal_addr[9:2] && SnakeState_Y[5] == vertical_addr[8:2]) begin
                if (score >= 4'd1) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[5] && SnakeState_Y[0] == SnakeState_Y[5])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[6] == horizontal_addr[9:2] && SnakeState_Y[6] == vertical_addr[8:2]) begin
                if (score >= 4'd1) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[6] && SnakeState_Y[0] == SnakeState_Y[6])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[7] == horizontal_addr[9:2] && SnakeState_Y[7] == vertical_addr[8:2]) begin
                if (score >= 4'd1) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[7] && SnakeState_Y[0] == SnakeState_Y[7])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[8] == horizontal_addr[9:2] && SnakeState_Y[8] == vertical_addr[8:2]) begin
                if (score >= 4'd2) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[8] && SnakeState_Y[0] == SnakeState_Y[8])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[9] == horizontal_addr[9:2] && SnakeState_Y[9] == vertical_addr[8:2]) begin
                if (score >= 4'd2) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[9] && SnakeState_Y[0] == SnakeState_Y[9])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[10] == horizontal_addr[9:2] && SnakeState_Y[10] == vertical_addr[8:2]) begin
                if (score >= 4'd2) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[10] && SnakeState_Y[0] == SnakeState_Y[10])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[11] == horizontal_addr[9:2] && SnakeState_Y[11] == vertical_addr[8:2]) begin
                if (score >= 4'd2) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[11] && SnakeState_Y[0] == SnakeState_Y[11])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[12] == horizontal_addr[9:2] && SnakeState_Y[12] == vertical_addr[8:2]) begin
                if (score >= 4'd3) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[12] && SnakeState_Y[0] == SnakeState_Y[12])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[13] == horizontal_addr[9:2] && SnakeState_Y[13] == vertical_addr[8:2]) begin
                if (score >= 4'd3) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[13] && SnakeState_Y[0] == SnakeState_Y[13])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[14] == horizontal_addr[9:2] && SnakeState_Y[14] == vertical_addr[8:2]) begin
                if (score >= 4'd3) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[14] && SnakeState_Y[0] == SnakeState_Y[14])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[15] == horizontal_addr[9:2] && SnakeState_Y[15] == vertical_addr[8:2]) begin
                if (score >= 4'd3) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[15] && SnakeState_Y[0] == SnakeState_Y[15])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[16] == horizontal_addr[9:2] && SnakeState_Y[16] == vertical_addr[8:2]) begin
                if (score >= 4'd4) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[16] && SnakeState_Y[0] == SnakeState_Y[16])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[17] == horizontal_addr[9:2] && SnakeState_Y[17] == vertical_addr[8:2]) begin
                if (score >= 4'd4) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[17] && SnakeState_Y[0] == SnakeState_Y[17])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[18] == horizontal_addr[9:2] && SnakeState_Y[18] == vertical_addr[8:2]) begin
                if (score >= 4'd4) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[18] && SnakeState_Y[0] == SnakeState_Y[18])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[19] == horizontal_addr[9:2] && SnakeState_Y[19] == vertical_addr[8:2]) begin
                if (score >= 4'd4) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[19] && SnakeState_Y[0] == SnakeState_Y[19])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[20] == horizontal_addr[9:2] && SnakeState_Y[20] == vertical_addr[8:2]) begin
                if (score >= 4'd5) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[20] && SnakeState_Y[0] == SnakeState_Y[20])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[21] == horizontal_addr[9:2] && SnakeState_Y[21] == vertical_addr[8:2]) begin
                if (score >= 4'd5) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[21] && SnakeState_Y[0] == SnakeState_Y[21])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[22] == horizontal_addr[9:2] && SnakeState_Y[22] == vertical_addr[8:2]) begin
                if (score >= 4'd5) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[22] && SnakeState_Y[0] == SnakeState_Y[22])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[23] == horizontal_addr[9:2] && SnakeState_Y[23] == vertical_addr[8:2]) begin
                if (score >= 4'd5) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[23] && SnakeState_Y[0] == SnakeState_Y[23])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[24] == horizontal_addr[9:2] && SnakeState_Y[24] == vertical_addr[8:2]) begin
                if (score >= 4'd6) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[24] && SnakeState_Y[0] == SnakeState_Y[24])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[25] == horizontal_addr[9:2] && SnakeState_Y[25] == vertical_addr[8:2]) begin
                if (score >= 4'd6) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[25] && SnakeState_Y[0] == SnakeState_Y[25])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[26] == horizontal_addr[9:2] && SnakeState_Y[26] == vertical_addr[8:2]) begin
                if (score >= 4'd6) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[26] && SnakeState_Y[0] == SnakeState_Y[26])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[27] == horizontal_addr[9:2] && SnakeState_Y[27] == vertical_addr[8:2]) begin
                if (score >= 4'd6) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[27] && SnakeState_Y[0] == SnakeState_Y[27])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[28] == horizontal_addr[9:2] && SnakeState_Y[28] == vertical_addr[8:2]) begin
                if (score >= 4'd7) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[28] && SnakeState_Y[0] == SnakeState_Y[28])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[29] == horizontal_addr[9:2] && SnakeState_Y[29] == vertical_addr[8:2]) begin
                if (score >= 4'd7) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[29] && SnakeState_Y[0] == SnakeState_Y[29])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[30] == horizontal_addr[9:2] && SnakeState_Y[30] == vertical_addr[8:2]) begin
                if (score >= 4'd7) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[30] && SnakeState_Y[0] == SnakeState_Y[30])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[31] == horizontal_addr[9:2] && SnakeState_Y[31] == vertical_addr[8:2]) begin
                if (score >= 4'd7) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[31] && SnakeState_Y[0] == SnakeState_Y[31])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[32] == horizontal_addr[9:2] && SnakeState_Y[32] == vertical_addr[8:2]) begin
                if (score >= 4'd8) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[32] && SnakeState_Y[0] == SnakeState_Y[32])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[33] == horizontal_addr[9:2] && SnakeState_Y[33] == vertical_addr[8:2]) begin
                if (score >= 4'd8) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[33] && SnakeState_Y[0] == SnakeState_Y[33])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[34] == horizontal_addr[9:2] && SnakeState_Y[34] == vertical_addr[8:2]) begin
                if (score >= 4'd8) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[34] && SnakeState_Y[0] == SnakeState_Y[34])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[35] == horizontal_addr[9:2] && SnakeState_Y[35] == vertical_addr[8:2]) begin
                if (score >= 4'd8) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[35] && SnakeState_Y[0] == SnakeState_Y[35])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[36] == horizontal_addr[9:2] && SnakeState_Y[36] == vertical_addr[8:2]) begin
                if (score >= 4'd9) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[36] && SnakeState_Y[0] == SnakeState_Y[36])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[37] == horizontal_addr[9:2] && SnakeState_Y[37] == vertical_addr[8:2]) begin
                if (score >= 4'd9) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[37] && SnakeState_Y[0] == SnakeState_Y[37])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[38] == horizontal_addr[9:2] && SnakeState_Y[38] == vertical_addr[8:2]) begin
                if (score >= 4'd9) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[38] && SnakeState_Y[0] == SnakeState_Y[38])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else if (SnakeState_X[39] == horizontal_addr[9:2] && SnakeState_Y[39] == vertical_addr[8:2]) begin
                if (score >= 4'd9) begin
                    colour <= 12'h000;
                    if (SnakeState_X[0] == SnakeState_X[39] && SnakeState_Y[0] == SnakeState_Y[39])
                        crashed <= 1'b1; else crashed <= 1'b0;
                end else
                    colour <= 12'hfff;
            end
            else //Background
                colour <= 12'hfff;
        end
        else if (state_master == 2'd0) //IDLE
            colour <= 12'hf00;
        else if (state_master == 2'd2) //WIN
            colour <= 12'hf0f;
        else //OTHER
            colour <= 12'h000;
    end
    
//    always@(posedge CLK) begin
//        crashed <= 1'b0;
//    end
    
endmodule
