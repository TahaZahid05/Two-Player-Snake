//`timescale 1ns / 1ps
//module Target_Generator(
//    input CLK,
//    input RESET,
//    input reached_target,
//    input reached_poison,
//    output [14:0] rand_target_address,
//    output [14:0] rand_poison_address
//);

//    reg [7:0] horizontal_shift_reg; // 8 bits for horizontal position
//    reg [6:0] vertical_shift_reg;   // 7 bits for vertical position
    
//    reg [7:0] horizontal_poison_shift_reg;
//    reg [6:0] vertical_poison_shift_reg;

//    assign rand_target_address = {horizontal_shift_reg, vertical_shift_reg}; // Concatenate the target address
//    assign rand_poison_address = {horizontal_poison_shift_reg, vertical_poison_shift_reg};

//    always @(posedge CLK or posedge RESET) begin
//        if (RESET) begin
//            // Reset target to a default valid position
//            horizontal_shift_reg <= 8'd80; // Midpoint within 40-150
//            vertical_shift_reg <= 7'd60;   // Midpoint within 0-120
//            horizontal_poison_shift_reg <= 8'd110;
//            vertical_poison_shift_reg <= 7'd30;
//        end 
//        else begin
//            if (reached_target) begin
//                // Generate a new random position within the bounds
//                horizontal_shift_reg <= $urandom_range(130,50); // Range: 40 to 150
//                vertical_shift_reg <= $urandom_range(90,20);        // Range: 0 to 120
//            end
//            if (reached_poison) begin
//                horizontal_poison_shift_reg <= $urandom_range(130,50);
//                vertical_poison_shift_reg <= $urandom_range(90,20); 
//            end
//        end
//    end

//endmodule

//`timescale 1ns / 1ps
//module Target_Generator(
//    input CLK,
//    input RESET,
//    input reached_target,
//    input reached_poison,
//    output [14:0] rand_target_address,
//    output [14:0] rand_poison_address
//);

//    reg [7:0] horizontal_shift_reg; // 8 bits for horizontal position
//    reg [6:0] vertical_shift_reg;   // 7 bits for vertical position
    
//    reg [7:0] horizontal_poison_shift_reg;
//    reg [6:0] vertical_poison_shift_reg;

//    assign rand_target_address = {horizontal_shift_reg, vertical_shift_reg}; // Concatenate the target address
//    assign rand_poison_address = {horizontal_poison_shift_reg, vertical_poison_shift_reg};

//    always @(posedge CLK or posedge RESET) begin
//        if (RESET) begin
//            // Reset target to a default valid position
//            horizontal_shift_reg <= 8'd80; // Midpoint within 40-150
//            vertical_shift_reg <= 7'd60;   // Midpoint within 0-120
//        end 
//        else begin
//            if (reached_target) begin
//                // Generate a new random position within the bounds
//                horizontal_shift_reg <= ({horizontal_shift_reg} % 4) + 1 + 50 + {$random} % 91; // Range: 40 to 150
//                vertical_shift_reg <= ({vertical_shift_reg} % 4) + 1 + 20 + {$random} % 91;        // Range: 0 to 120
//            end
//            if (reached_poison) begin
//                horizontal_poison_shift_reg <= ({horizontal_poison_shift_reg} % 4) + 1 + 50 + {$random} % 91; // Range: 40 to 150
//                vertical_poison_shift_reg <= ({vertical_poison_shift_reg} % 4) + 1 + 20 + {$random} % 91;        // Range: 0 to 120 
//            end
//        end
//    end

//endmodule

module Target_Generator(
    input CLK,
    input RESET,
    input reached_target,
    input reached_poison,
    output [14:0] rand_target_address,
    output [14:0] rand_poison_address
);

    reg [7:0] lfsr_h; // LFSR for horizontal
    reg [6:0] lfsr_v; // LFSR for vertical
    reg [7:0] lfsr_poison_h; 
    reg [6:0] lfsr_poison_v;

    reg [7:0] mapped_x; // Mapped x-coordinate for target
    reg [6:0] mapped_y; // Mapped y-coordinate for target
    reg [7:0] mapped_poison_x; // Mapped x-coordinate for poison
    reg [6:0] mapped_poison_y; // Mapped y-coordinate for poison

    assign rand_target_address = {mapped_x, mapped_y};
    assign rand_poison_address = {mapped_poison_x, mapped_poison_y};

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            // Reset to valid default values
            lfsr_h <= 8'hAA; // Seed value for LFSR
            lfsr_v <= 7'h55;
            lfsr_poison_h <= 8'hFF;
            lfsr_poison_v <= 7'h33;

            mapped_x <= 8'd80; 
            mapped_y <= 7'd60;
            mapped_poison_x <= 8'd110;
            mapped_poison_y <= 7'd30;
        end else begin
            // Update LFSR values
            lfsr_h <= {lfsr_h[6:0], lfsr_h[7] ^ lfsr_h[5]};
            lfsr_v <= {lfsr_v[5:0], lfsr_v[6] ^ lfsr_v[3]};
            lfsr_poison_h <= {lfsr_poison_h[6:0], lfsr_poison_h[7] ^ lfsr_poison_h[5]};
            lfsr_poison_v <= {lfsr_poison_v[5:0], lfsr_poison_v[6] ^ lfsr_poison_v[3]};

            if (reached_target) begin
                // Map LFSR outputs to valid ranges for target
                mapped_x <= (lfsr_h % (130 - 50 + 1)) + 50; // x-range: 50 to 130
                mapped_y <= (lfsr_v % (90 - 20 + 1)) + 20;  // y-range: 20 to 90
            end

            if (reached_poison) begin
                // Map LFSR outputs to valid ranges for poison
                mapped_poison_x <= (lfsr_poison_h % (130 - 50 + 1)) + 50;
                mapped_poison_y <= (lfsr_poison_v % (90 - 20 + 1)) + 20;
            end
        end
    end
endmodule

