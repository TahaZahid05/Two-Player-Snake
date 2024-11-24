`timescale 1ns / 1ps
module timer(
    input CLK,
    input RESET,
    output reg [3:0] SECONDS_UNITS, // 4 bits for units digit (0-9)
    output reg [2:0] SECONDS_TENS,  // 3 bits for tens digit (0-5)
    output reg [3:0] MINUTES_UNITS, // 4 bits for units digit (0-9)
    output reg [2:0] MINUTES_TENS   // 3 bits for tens digit (0-5)
    );

    reg [25:0] counter; // 26-bit counter for 1-second intervals (assuming 50 MHz clock)

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            counter <= 26'd0;
            SECONDS_UNITS <= 4'd0;
            SECONDS_TENS <= 3'd0;
            MINUTES_UNITS <= 4'd0;
            MINUTES_TENS <= 3'd0;
        end else begin
            if (counter == 26'd50000000) begin // 50,000,000 clock cycles for 1 second at 50 MHz
                counter <= 26'd0;
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
                counter <= counter + 26'd1;
            end
        end
    end

endmodule