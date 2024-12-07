`timescale 1ns / 1ps
module timer(
    input CLK,
    input RESET,
    input [1:0] STATE, // Assuming STATE is a 2-bit input
    output reg [3:0] SECONDS_UNITS, // 4 bits for units digit (0-9)
    output reg [2:0] SECONDS_TENS,  // 3 bits for tens digit (0-5)
    output reg [3:0] MINUTES_UNITS, // 4 bits for units digit (0-9)
    output reg [2:0] MINUTES_TENS   // 3 bits for tens digit (0-5)
    );

    reg [26:0] counter; // 26-bit counter for 1-second intervals (assuming 50 MHz clock)
    reg [3:0] saved_seconds_units;
    reg [2:0] saved_seconds_tens;
    reg [3:0] saved_minutes_units;
    reg [2:0] saved_minutes_tens;

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            counter <= 27'd0;
            SECONDS_UNITS <= 4'd0;
            SECONDS_TENS <= 3'd0;
            MINUTES_UNITS <= 4'd0;
            MINUTES_TENS <= 3'd0;
            saved_seconds_units <= 4'd0;
            saved_seconds_tens <= 3'd0;
            saved_minutes_units <= 4'd0;
            saved_minutes_tens <= 3'd0;
        end else begin
            if (STATE == 2'd2) begin // d2 state
                SECONDS_UNITS <= saved_seconds_units;
                SECONDS_TENS <= saved_seconds_tens;
                MINUTES_UNITS <= saved_minutes_units;
                MINUTES_TENS <= saved_minutes_tens;
            end else if (STATE == 2'd1) begin
                if (counter == 27'd100000000) begin // 50,000,000 clock cycles for 1 second at 50 MHz
                    counter <= 27'd0;
                    if (SECONDS_UNITS == 4'd9) begin
                        SECONDS_UNITS <= 4'd0;
                        if (SECONDS_TENS == 3'd5) begin
                            SECONDS_TENS <= 3'd0;
                            if (MINUTES_UNITS == 4'd9) begin
                                MINUTES_UNITS <= 4'd0;
                                if (MINUTES_TENS == 3'd5) begin
                                    MINUTES_TENS <= 3'd0;
                                end else begin
                                    MINUTES_TENS <= MINUTES_TENS + 3'd1;
                                end
                            end else begin
                                MINUTES_UNITS <= MINUTES_UNITS + 4'd1;
                            end
                        end else begin
                            SECONDS_TENS <= SECONDS_TENS + 3'd1;
                        end
                    end else begin
                        SECONDS_UNITS <= SECONDS_UNITS + 4'd1;
                    end
                end else begin
                    counter <= counter + 27'd1;
                end
                // Save the current time when the state is not d2
                saved_seconds_units <= SECONDS_UNITS;
                saved_seconds_tens <= SECONDS_TENS;
                saved_minutes_units <= MINUTES_UNITS;
                saved_minutes_tens <= MINUTES_TENS;
            end
        end
    end

endmodule