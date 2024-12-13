module Target_Generator(
    input CLK,
    input RESET,
    input reached_target,
    input reached_target_2,
    input reached_poison,
    input reached_poison_2,
    input [1:0] levels,
    output [14:0] rand_target_address,
    output [14:0] rand_target_address_2,
    output [14:0] rand_poison_address,
    output [14:0] rand_poison_address_2
);

    reg [7:0] lfsr_h; // LFSR for horizontal
    reg [6:0] lfsr_v; // LFSR for vertical
    reg [7:0] lfsr_h_2;
    reg [6:0] lfsr_v_2;
    reg [7:0] lfsr_poison_h; 
    reg [6:0] lfsr_poison_v;
    reg [7:0] lfsr_poison_h_2; 
    reg [6:0] lfsr_poison_v_2;

    reg [7:0] mapped_x; // Mapped x-coordinate for target
    reg [6:0] mapped_y; // Mapped y-coordinate for target
    reg [7:0] mapped_x_2;
    reg [6:0] mapped_y_2;
    reg [7:0] mapped_poison_x; // Mapped x-coordinate for poison
    reg [6:0] mapped_poison_y; // Mapped y-coordinate for poison
    reg [7:0] mapped_poison_x_2; // Mapped x-coordinate for second poison
    reg [6:0] mapped_poison_y_2; // Mapped y-coordinate for second poison

    assign rand_target_address = {mapped_x, mapped_y};
    assign rand_target_address_2 = {mapped_x_2, mapped_y_2};
    assign rand_poison_address = {mapped_poison_x, mapped_poison_y};
    assign rand_poison_address_2 = {mapped_poison_x_2, mapped_poison_y_2};

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            // Reset to valid default values
            lfsr_h <= 8'hAA; // Seed value for LFSR
            lfsr_v <= 7'h55;
            lfsr_h_2 <= 8'hBB; // Seed value for second LFSR
            lfsr_v_2 <= 7'h66;
            lfsr_poison_h <= 8'hFF;
            lfsr_poison_v <= 7'h33;
            lfsr_poison_h_2 <= 8'hEE; // Seed value for second poison LFSR
            lfsr_poison_v_2 <= 7'h77;

            mapped_x <= 8'd80; 
            mapped_y <= 7'd60;
            mapped_x_2 <= 8'd90; 
            mapped_y_2 <= 7'd70;
            mapped_poison_x <= 8'd110;
            mapped_poison_y <= 7'd55;
            mapped_poison_x_2 <= 8'd120;
            mapped_poison_y_2 <= 7'd65;
        end else begin
            // Update LFSR values
            lfsr_h <= {lfsr_h[6:0], lfsr_h[7] ^ lfsr_h[5]};
            lfsr_v <= {lfsr_v[5:0], lfsr_v[6] ^ lfsr_v[3]};
            lfsr_h_2 <= {lfsr_h_2[6:0], lfsr_h_2[7] ^ lfsr_h_2[5]};
            lfsr_v_2 <= {lfsr_v_2[5:0], lfsr_v_2[6] ^ lfsr_v_2[3]};
            lfsr_poison_h <= {lfsr_poison_h[6:0], lfsr_poison_h[7] ^ lfsr_poison_h[5]};
            lfsr_poison_v <= {lfsr_poison_v[5:0], lfsr_poison_v[6] ^ lfsr_poison_v[3]};
            lfsr_poison_h_2 <= {lfsr_poison_h_2[6:0], lfsr_poison_h_2[7] ^ lfsr_poison_h_2[5]};
            lfsr_poison_v_2 <= {lfsr_poison_v_2[5:0], lfsr_poison_v_2[6] ^ lfsr_poison_v_2[3]};

            if (reached_target || reached_target_2 || reached_poison || reached_poison_2) begin
                // Map LFSR outputs to valid ranges for target
                mapped_x <= (lfsr_h % (152 - 8 + 1)) + 8; // x-range: 5 to 155
                mapped_y <= (lfsr_v % (112 - 43 + 1)) + 43;  // y-range: 40 to 115
                
                if (mapped_x >= 5 && mapped_x <= 51 && mapped_y >= 70 && mapped_y <= 102) begin
                    if(mapped_x == 50 && mapped_y >= 71 && mapped_y <= 101)
                        mapped_x <= mapped_x + 2;
                    else if(mapped_y == 71 || mapped_y == 101)
                        mapped_y <= mapped_y + 2;
                    else if(mapped_x == 49)
                        mapped_x <= mapped_x - 1;
                    else if(mapped_x == 51)
                        mapped_x <= mapped_x + 1;
                    else if(mapped_y == 70)
                        mapped_y <= mapped_y - 1;
                    else if(mapped_y == 72)
                        mapped_y <= mapped_y + 1;
                    else if(mapped_y == 100)
                        mapped_y <= mapped_y - 1;
                    else if(mapped_y == 102)
                        mapped_y <= mapped_y + 1;
                end

                // Conditions for horizontal line
                if (mapped_y >= 74 && mapped_y <= 80) begin
                    if (mapped_y == 74)
                        mapped_y <= mapped_y - 1;
                    else if (mapped_y == 80)
                        mapped_y <= mapped_y + 1;
                    else if (mapped_y >= 75 && mapped_y <= 77)
                        mapped_y <= 73;
                    else if (mapped_y == 78 || mapped_y == 79)
                        mapped_y <= 81;
                end
                // Conditions for vertical line
                if (mapped_x >= 75 && mapped_x <= 81) begin
                    if (mapped_x == 75)
                        mapped_x <= mapped_x - 1;
                    else if (mapped_x == 81)
                        mapped_x <= mapped_x + 1;
                    else if (mapped_x >= 76 && mapped_x <= 78)
                        mapped_x <= 74;
                    else if (mapped_x == 79 || mapped_x == 80)
                        mapped_x <= 82;
                end

                // Map LFSR outputs to valid ranges for second target
                mapped_x_2 <= (lfsr_h_2 % (152 - 8 + 1)) + 8; // x-range: 5 to 155
                mapped_y_2 <= (lfsr_v_2 % (112 - 43 + 1)) + 43;  // y-range: 40 to 115
                
                if (mapped_x_2 >= 5 && mapped_x_2 <= 51 && mapped_y_2 >= 70 && mapped_y_2 <= 102) begin
                    if(mapped_x_2 == 50 && mapped_y_2 >= 71 && mapped_y_2 <= 101)
                        mapped_x_2 <= mapped_x_2 + 2;
                    else if(mapped_y_2 == 71 || mapped_y_2 == 101)
                        mapped_y_2 <= mapped_y_2 + 2;
                    else if(mapped_x_2 == 49)
                        mapped_x_2 <= mapped_x_2 - 1;
                    else if(mapped_x_2 == 51)
                        mapped_x_2 <= mapped_x_2 + 1;
                    else if(mapped_y_2 == 70)
                        mapped_y_2 <= mapped_y_2 - 1;
                    else if(mapped_y_2 == 72)
                        mapped_y_2 <= mapped_y_2 + 1;
                    else if(mapped_y_2 == 100)
                        mapped_y_2 <= mapped_y_2 - 1;
                    else if(mapped_y_2 == 102)
                        mapped_y_2 <= mapped_y_2 + 1;
                end

                // Conditions for horizontal line
                if (mapped_y_2 >= 74 && mapped_y_2 <= 80) begin
                    if (mapped_y_2 == 74)
                        mapped_y_2 <= mapped_y_2 - 1;
                    else if (mapped_y_2 == 80)
                        mapped_y_2 <= mapped_y_2 + 1;
                    else if (mapped_y_2 >= 75 && mapped_y_2 <= 77)
                        mapped_y_2 <= 73;
                    else if (mapped_y_2 == 78 || mapped_y_2 == 79)
                        mapped_y_2 <= 81;
                end
                // Conditions for vertical line
                if (mapped_x_2 >= 75 && mapped_x_2 <= 81) begin
                    if (mapped_x_2 == 75)
                        mapped_x_2 <= mapped_x_2 - 1;
                    else if (mapped_x_2 == 81)
                        mapped_x_2 <= mapped_x_2 + 1;
                    else if (mapped_x_2 >= 76 && mapped_x_2 <= 78)
                        mapped_x_2 <= 74;
                    else if (mapped_x_2 == 79 || mapped_x_2 == 80)
                        mapped_x_2 <= 82;
                end

                // Map LFSR outputs to valid ranges for poison
                mapped_poison_x <= (lfsr_poison_h % (152 - 8 + 1)) + 8;
                mapped_poison_y <= (lfsr_poison_v % (112 - 43 + 1)) + 43;
                
                if (mapped_poison_x >= 5 && mapped_poison_x <= 51 && mapped_poison_y >= 70 && mapped_poison_y <= 102) begin
                    if(mapped_poison_x == 50 && mapped_poison_y >= 71 && mapped_poison_y <= 101)
                        mapped_poison_x <= mapped_poison_x + 2;
                    else if(mapped_poison_y == 71 || mapped_poison_y == 101)
                        mapped_poison_y <= mapped_poison_y + 2;
                    else if(mapped_poison_x == 49)
                        mapped_poison_x <= mapped_poison_x - 1;
                    else if(mapped_poison_x == 51)
                        mapped_poison_x <= mapped_poison_x + 1;
                    else if(mapped_poison_y == 70)
                        mapped_poison_y <= mapped_poison_y - 1;
                    else if(mapped_poison_y == 72)
                        mapped_poison_y <= mapped_poison_y + 1;
                    else if(mapped_poison_y == 100)
                        mapped_poison_y <= mapped_poison_y - 1;
                    else if(mapped_poison_y == 102)
                        mapped_poison_y <= mapped_poison_y + 1;
                end

                // Conditions for horizontal line
                if (mapped_poison_y >= 74 && mapped_poison_y <= 80) begin
                    if (mapped_poison_y == 74)
                        mapped_poison_y <= mapped_poison_y - 1;
                    else if (mapped_poison_y == 80)
                        mapped_poison_y <= mapped_poison_y + 1;
                    else if (mapped_poison_y >= 75 && mapped_poison_y <= 77)
                        mapped_poison_y <= 73;
                    else if (mapped_poison_y == 78 || mapped_poison_y == 79)
                        mapped_poison_y <= 81;
                end
                // Conditions for vertical line
                if (mapped_poison_x >= 75 && mapped_poison_x <= 81) begin
                    if (mapped_poison_x == 75)
                        mapped_poison_x <= mapped_poison_x - 1;
                    else if (mapped_poison_x == 81)
                        mapped_poison_x <= mapped_poison_x + 1;
                    else if (mapped_poison_x >= 76 && mapped_poison_x <= 78)
                        mapped_poison_x <= 74;
                    else if (mapped_poison_x == 79 || mapped_poison_x == 80)
                        mapped_poison_x <= 82;
                end

                // Map LFSR outputs to valid ranges for second poison
                mapped_poison_x_2 <= (lfsr_poison_h_2 % (152 - 8 + 1)) + 8;
                mapped_poison_y_2 <= (lfsr_poison_v_2 % (112 - 43 + 1)) + 43;
                
                if (mapped_poison_x_2 >= 5 && mapped_poison_x_2 <= 51 && mapped_poison_y_2 >= 70 && mapped_poison_y_2 <= 102) begin
                    if(mapped_poison_x_2 == 50 && mapped_poison_y_2 >= 71 && mapped_poison_y_2 <= 101)
                        mapped_poison_x_2 <= mapped_poison_x_2 + 2;
                    else if(mapped_poison_y_2 == 71 || mapped_poison_y_2 == 101)
                        mapped_poison_y_2 <= mapped_poison_y_2 + 2;
                    else if(mapped_poison_x_2 == 49)
                        mapped_poison_x_2 <= mapped_poison_x_2 - 1;
                    else if(mapped_poison_x_2 == 51)
                        mapped_poison_x_2 <= mapped_poison_x_2 + 1;
                    else if(mapped_poison_y_2 == 70)
                        mapped_poison_y_2 <= mapped_poison_y_2 - 1;
                    else if(mapped_poison_y_2 == 72)
                        mapped_poison_y_2 <= mapped_poison_y_2 + 1;
                    else if(mapped_poison_y_2 == 100)
                        mapped_poison_y_2 <= mapped_poison_y_2 - 1;
                    else if(mapped_poison_y_2 == 102)
                        mapped_poison_y_2 <= mapped_poison_y_2 + 1;
                end

                // Conditions for horizontal line
                if (mapped_poison_y_2 >= 74 && mapped_poison_y_2 <= 80) begin
                    if (mapped_poison_y_2 == 74)
                        mapped_poison_y_2 <= mapped_poison_y_2 - 1;
                    else if (mapped_poison_y_2 == 80)
                        mapped_poison_y_2 <= mapped_poison_y_2 + 1;
                    else if (mapped_poison_y_2 >= 75 && mapped_poison_y_2 <= 77)
                        mapped_poison_y_2 <= 73;
                    else if (mapped_poison_y_2 == 78 || mapped_poison_y_2 == 79)
                        mapped_poison_y_2 <= 81;
                end
                // Conditions for vertical line
                if (mapped_poison_x_2 >= 75 && mapped_poison_x_2 <= 81) begin
                    if (mapped_poison_x_2 == 75)
                        mapped_poison_x_2 <= mapped_poison_x_2 - 1;
                    else if (mapped_poison_x_2 == 81)
                        mapped_poison_x_2 <= mapped_poison_x_2 + 1;
                    else if (mapped_poison_x_2 >= 76 && mapped_poison_x_2 <= 78)
                        mapped_poison_x_2 <= 74;
                    else if (mapped_poison_x_2 == 79 || mapped_poison_x_2 == 80)
                        mapped_poison_x_2 <= 82;
                end
            end
        end
    end
endmodule

