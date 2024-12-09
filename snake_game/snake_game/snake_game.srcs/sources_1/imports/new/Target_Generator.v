module Target_Generator(
    input CLK,
    input RESET,
    input reached_target,
    input reached_poison,
    input levels,
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
            mapped_poison_y <= 7'd55;
        end else begin
            // Update LFSR values
            lfsr_h <= {lfsr_h[6:0], lfsr_h[7] ^ lfsr_h[5]};
            lfsr_v <= {lfsr_v[5:0], lfsr_v[6] ^ lfsr_v[3]};
            lfsr_poison_h <= {lfsr_poison_h[6:0], lfsr_poison_h[7] ^ lfsr_poison_h[5]};
            lfsr_poison_v <= {lfsr_poison_v[5:0], lfsr_poison_v[6] ^ lfsr_poison_v[3]};

            if (reached_target) begin
                // Map LFSR outputs to valid ranges for target
                mapped_x <= (lfsr_h % (145 - 15 + 1)) + 15; // x-range: 50 to 130
                mapped_y <= (lfsr_v % (105 - 50 + 1)) + 50;  // y-range: 20 to 90
                
                if (((mapped_x >= 5 && mapped_x <= 50 && (mapped_y == 71 || mapped_y == 101))
                    || (mapped_x == 50 && mapped_y >= 71 && mapped_y <= 101)) && levels) begin
                    mapped_x = 60;
                end
                
            end

            if (reached_poison) begin
                // Map LFSR outputs to valid ranges for poison
                mapped_poison_x <= (lfsr_poison_h % (145 - 15 + 1)) + 15;
                mapped_poison_y <= (lfsr_poison_v % (105 - 50 + 1)) + 50;
                
                if (((mapped_poison_x >= 5 && mapped_poison_x <= 50 && (mapped_poison_y == 71 || mapped_poison_y == 101))
                    || (mapped_poison_x == 50 && mapped_poison_y >= 71 && mapped_poison_y <= 101)) && levels) begin
                    mapped_poison_x = 89;
                end
                
            end
        end
    end
endmodule

