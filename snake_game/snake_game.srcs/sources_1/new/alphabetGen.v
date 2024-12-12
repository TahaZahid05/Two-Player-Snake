`timescale 1ns / 1ps

module alphabetGen(
    input wire [5:0] alph_input, 
    input wire [9:0] horizontal_addr,
    input wire [8:0] vertical_addr,
    input wire [8:0] pos_x_start,
    input wire [7:0] pos_y_start,
    input wire [11:0] colour_in,
    input wire heading,
    output reg [11:0] colour
    );
    always @(*) begin
        colour <= 12'h000;
        if(alph_input == 6'd0) begin
            if(heading) begin
                if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                    (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == pos_y_start) ||
                    (horizontal_addr[9:2] == (pos_x_start + 6) && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                    (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 6)))
                    colour <= colour_in;
            end
            else begin
                if ((vertical_addr[8:2] == pos_y_start && horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= (pos_x_start + 3))
                    || ((horizontal_addr[9:2] == pos_x_start || horizontal_addr[9:2] == (pos_x_start + 3)) && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 6))
                    || (vertical_addr[8:2] == (pos_y_start + 3) && horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= (pos_x_start + 3)))
                        colour <= colour_in;
            end
        end else if(alph_input == 6'd1) begin
            // Code for 'B'
            if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start + 6) || vertical_addr[8:2] == (pos_y_start + 12))) ||
                (horizontal_addr[9:2] == (pos_x_start + 6) && (vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 6) || vertical_addr[8:2] >= (pos_y_start + 6) && vertical_addr[8:2] <= (pos_y_start + 12))))
                colour <= colour_in;
        end else if(alph_input == 6'd2) begin
            // Code for 'C'
            if (((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= (pos_x_start+2)) && 
                (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start + 6))) || // Top, bottom
                (horizontal_addr[9:2] == pos_x_start && (vertical_addr[8:2] > pos_y_start && vertical_addr[8:2] < (pos_y_start + 6)))) // Left vertical
                colour <= colour_in;
        end else if(alph_input == 6'd3) begin
            // Code for 'D'
            if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start + 12))) ||
                (horizontal_addr[9:2] == (pos_x_start + 6) && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)))
                colour <= colour_in;
        end else if(alph_input == 6'd4) begin
            // Code for 'E'
            if (heading) begin
                if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                    (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == pos_y_start) ||
                    (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 6)) ||
                    (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 12)))
                    colour <= colour_in;
            end 
            else begin
                if (((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= (pos_x_start + 2)) && 
                    (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start + 3) || vertical_addr[8:2] == (pos_y_start + 6))) || // Top, middle, bottom
                    (horizontal_addr[9:2] == pos_x_start && (vertical_addr[8:2] > pos_y_start && vertical_addr[8:2] < (pos_y_start + 6)))) // Left vertical
                    colour <= colour_in;
            end
        end else if(alph_input == 6'd5) begin
            // Code for 'F'
            if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 6) && (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start + 6))))
                colour <= colour_in;
        end
        else if(alph_input == 6'd6) begin
            // Code for 'G'
            if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 6)) ||
                (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 3) && (vertical_addr[8:2] == pos_y_start)) ||
                (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 3) && (vertical_addr[8:2] == (pos_y_start+ 6))) ||
                (horizontal_addr[9:2] == (pos_x_start + 3) && (vertical_addr[8:2] == (pos_y_start + 5) || vertical_addr[8:2] == (pos_y_start + 4))) ||
                (horizontal_addr[9:2] == (pos_x_start + 2) && vertical_addr[8:2] == (pos_y_start + 4)))
                colour <= colour_in;
        end
        else if(alph_input == 6'd7) begin
            // Code for 'H'
            if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                (horizontal_addr[9:2] == (pos_x_start + 6) && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 6))) begin
                colour <= colour_in;
            end
        end
        else if(alph_input == 6'd8) begin
            // Code for 'I'
            if (heading) begin
                if ((horizontal_addr[9:2] == (pos_x_start + 1) && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                    (horizontal_addr[9:2] == pos_x_start && (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start + 12))) ||
                    (horizontal_addr[9:2] == (pos_x_start + 2) && (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start + 12))))
                    colour <= colour_in;  // Colour for "I"
            end
            else begin
                if (horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 6))
                    colour <= colour_in;
            end
        end
        else if(alph_input == 6'd9) begin
            // Code for 'J'
            if ((horizontal_addr[9:2] == (pos_x_start + 3) && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == pos_y_start) ||
                (horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 6)))
                colour <= colour_in;
        end
        else if(alph_input == 6'd10) begin
            // Code for 'K'
            if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                    (horizontal_addr[9:2] == (pos_x_start+1) && vertical_addr[8:2] == (pos_y_start + 6)) ||
                    (horizontal_addr[9:2] == (pos_x_start+2) && vertical_addr[8:2] == (pos_y_start + 7)) ||
                    (horizontal_addr[9:2] == (pos_x_start+3) && vertical_addr[8:2] == (pos_y_start + 8)) ||
                    (horizontal_addr[9:2] == (pos_x_start+2) && vertical_addr[8:2] == (pos_y_start + 5)) ||
                    (horizontal_addr[9:2] == (pos_x_start+3) && vertical_addr[8:2] == (pos_y_start + 4)) ||
                    (horizontal_addr[9:2] == (pos_x_start+4) && vertical_addr[8:2] == (pos_y_start + 9)) ||
                    (horizontal_addr[9:2] == (pos_x_start+5) && vertical_addr[8:2] == (pos_y_start + 10)) ||
                    (horizontal_addr[9:2] == (pos_x_start+6) && vertical_addr[8:2] == (pos_y_start + 11)) ||
                    (horizontal_addr[9:2] == (pos_x_start+7) && vertical_addr[8:2] == (pos_y_start + 12)) ||
                    (horizontal_addr[9:2] == (pos_x_start+4) && vertical_addr[8:2] == (pos_y_start + 3)) ||
                    (horizontal_addr[9:2] == (pos_x_start+5) && vertical_addr[8:2] == (pos_y_start + 2)) ||
                    (horizontal_addr[9:2] == (pos_x_start+6) && vertical_addr[8:2] == (pos_y_start + 1)) ||
                    (horizontal_addr[9:2] == (pos_x_start+7) && vertical_addr[8:2] == pos_y_start))
                    colour <= colour_in;
            
        end
        else if(alph_input == 6'd11) begin
            // Code for 'L'
            if(heading) begin
                if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                    (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 12)))
                    colour <= colour_in;
            end
            else begin 
                if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 6)) ||
                    (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 3) && vertical_addr[8:2] == (pos_y_start + 6)))
                    colour <= colour_in;
            end
        end
        else if(alph_input == 6'd12) begin
            // Code for 'M'
            if (((horizontal_addr[9:2] == pos_x_start || horizontal_addr[9:2] == (pos_x_start + 4)) && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 6)) || // Left and right vertical lines
                (horizontal_addr[9:2] == (pos_x_start + 2) && vertical_addr[8:2] == (pos_y_start + 2)) || (horizontal_addr[9:2] == (pos_x_start + 1) && vertical_addr[8:2] == (pos_y_start + 1)) ||
                (horizontal_addr[9:2] == (pos_x_start + 3) && vertical_addr[8:2] == (pos_y_start + 1))) // Middle peak
                colour <= colour_in;
        end
        else if(alph_input == 6'd13) begin
            // Code for 'N'
            if(heading) begin
                if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                        (horizontal_addr[9:2] == (pos_x_start + 12) && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                        (horizontal_addr[9:2] == (pos_x_start + vertical_addr[8:2] - pos_y_start) && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)))
                    colour <= colour_in;
            end
        end
        else if(alph_input == 6'd14) begin
            // Code for 'O'
            if (heading) begin
                if ((horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 12)) ||
                    (horizontal_addr[9:2] == (pos_x_start + 6) && vertical_addr[8:2] <= (pos_y_start + 11) && vertical_addr[8:2] >= (pos_y_start + 1)) ||
                    (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == pos_y_start) ||
                    (horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= (pos_y_start + 1) && vertical_addr[8:2] <= (pos_y_start + 11)))
                    colour <= colour_in;  // Colour for "O"
            end
            else begin
                if (((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= (pos_x_start + 2)) && 
                    (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start + 6))) || // Top, bottom
                    ((horizontal_addr[9:2] == pos_x_start || horizontal_addr[9:2] == (pos_x_start + 2)) && 
                    (vertical_addr[8:2] > pos_y_start && vertical_addr[8:2] < (pos_y_start + 6)))) // Left and right vertical
                    colour <= colour_in;
            end
        end
        else if(alph_input == 6'd15) begin
            // Code for 'P'
            if (heading) begin
                if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||  // Vertical line
                    (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == pos_y_start) || // Top horizontal line
                    (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 6)) || // Middle horizontal line
                    (horizontal_addr[9:2] == (pos_x_start + 6) && vertical_addr[8:2] >= (pos_y_start + 1) && vertical_addr[8:2] <= (pos_y_start + 5))) // Right vertical line (top half)
                    colour <= colour_in;
            end
            else begin
                if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 6)) ||  // Vertical line
                    (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 3) && vertical_addr[8:2] == pos_y_start) || // Top horizontal line
                    (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 3) && vertical_addr[8:2] == (pos_y_start + 3)) || // Middle horizontal line
                    (horizontal_addr[9:2] == (pos_x_start + 3) && vertical_addr[8:2] >= (pos_y_start + 1) && vertical_addr[8:2] <= (pos_y_start + 2))) // Right vertical line (top half)
                    colour <= colour_in;
            end
        end
        else if(alph_input == 6'd16) begin
            // Code for 'Q'
            if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                (horizontal_addr[9:2] == (pos_x_start + 6) && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start + 12))) ||
                (horizontal_addr[9:2] == (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 6)) ||
                (horizontal_addr[9:2] == (pos_x_start + 6) && vertical_addr[8:2] == (pos_y_start + 7)))
                colour <= colour_in;
        end
        else if(alph_input == 6'd17) begin
            // Code for 'R'
            if (heading) begin 
                if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                    (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == pos_y_start) ||
                    (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 6)) ||
                    (horizontal_addr[9:2] == (pos_x_start + 6) && vertical_addr[8:2] >= (pos_y_start + 1) && vertical_addr[8:2] <= (pos_y_start + 5)) ||
                    (horizontal_addr[9:2] == (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 7)) ||
                    (horizontal_addr[9:2] == (pos_x_start + 6) && vertical_addr[8:2] >= (pos_y_start + 8) && vertical_addr[8:2] <= (pos_y_start + 12))) 
                    colour <= colour_in;
            end 
            else begin
                if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 6)) || // Left vertical line
                    ((horizontal_addr[9:2] == (pos_x_start+2) || horizontal_addr[9:2] == (pos_x_start + 1)) && (vertical_addr[8:2] == pos_y_start)) || // Top right curve
                    ((horizontal_addr[9:2] == (pos_x_start+2) || horizontal_addr[9:2] == (pos_x_start + 1)) && vertical_addr[8:2] == (pos_y_start + 3)) ||
                    (horizontal_addr[9:2] == (pos_x_start+3) && (vertical_addr[8:2] == (pos_y_start + 1) || vertical_addr[8:2] == (pos_y_start + 2))) ||
                    (horizontal_addr[9:2] == (pos_x_start+3) && (vertical_addr[8:2] == (pos_y_start + 5) || vertical_addr[8:2] == (pos_y_start + 6) || vertical_addr[8:2] == (pos_y_start + 4)))) // Bottom right diagonal
                    colour <= colour_in;
            end
        end
        else if(alph_input == 6'd18) begin
            // Code for 'S'
            if (heading) begin
                if ((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == pos_y_start) ||
                    (horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= (pos_y_start + 1) && vertical_addr[8:2] <= (pos_y_start + 6)) ||
                    (horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 6)) ||
                    (horizontal_addr[9:2] == (pos_x_start + 5) && vertical_addr[8:2] >= (pos_y_start + 7) && vertical_addr[8:2] <= (pos_y_start + 12)) ||
                    (horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 12)))
                    colour <= colour_in;
            end
            else begin
                if (((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= (pos_x_start+2)) && 
                    (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start + 3) || vertical_addr[8:2] == (pos_y_start + 6))) || // Top, middle, bottom
                    ((horizontal_addr[9:2] == pos_x_start && (vertical_addr[8:2] > pos_y_start && vertical_addr[8:2] < (pos_y_start + 3))) || // Left vertical (top half)
                    (horizontal_addr[9:2] == (pos_x_start+2) && (vertical_addr[8:2] > (pos_y_start + 3) && vertical_addr[8:2] < (pos_y_start + 6))))) // Right vertical (bottom half)
                    colour <= colour_in;
            end
        end
        else if(alph_input == 6'd19) begin
            // Code for 'T'
            if ((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= (pos_x_start + 4) && vertical_addr[8:2] == pos_y_start) || // Top horizontal line
                (horizontal_addr[9:2] == (pos_x_start + 2) && vertical_addr[8:2] > pos_y_start && vertical_addr[8:2] <= (pos_y_start + 6))) // Vertical line
                colour <= colour_in;
        end
        else if(alph_input == 6'd20) begin
            // Code for 'U'
            if (heading) begin
                if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 11)) ||
                        (horizontal_addr[9:2] == (pos_x_start + 5) && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 11)) ||
                        (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 4) && vertical_addr[8:2] == (pos_y_start + 12)))
                    colour <= colour_in;  // Colour for "U"
            end
            else begin
                if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 6) && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 12)) 
                    || (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 12)))
                    colour <= colour_in;
            end
        end
        else if(alph_input == 6'd21) begin
            // Code for 'V'
            if(heading) begin
                if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] == pos_y_start) 
                    || (horizontal_addr[9:2] == (pos_x_start + 1) && vertical_addr[8:2] == (pos_y_start + 1)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 2) && vertical_addr[8:2] == (pos_y_start + 2)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 3) && vertical_addr[8:2] == (pos_y_start + 3)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 4) && vertical_addr[8:2] == (pos_y_start + 4)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 5)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 6) && vertical_addr[8:2] == (pos_y_start + 6)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 1) && vertical_addr[8:2] == (pos_y_start + 12)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 2) && vertical_addr[8:2] == (pos_y_start + 11)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 3) && vertical_addr[8:2] == (pos_y_start + 10))
                    || (horizontal_addr[9:2] == (pos_x_start + 4) && vertical_addr[8:2] == (pos_y_start + 9))
                    || (horizontal_addr[9:2] == (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 8)))
                    colour <= colour_in;
            end
            else begin
                if (((horizontal_addr[9:2] == pos_x_start || horizontal_addr[9:2] == (pos_x_start + 4)) && (vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 4))) 
                    || ((horizontal_addr[9:2] == (pos_x_start + 1) || horizontal_addr[9:2] == (pos_x_start + 3)) && vertical_addr[8:2] == pos_y_start + 5)
                    || (horizontal_addr[9:2] == (pos_x_start + 2) && vertical_addr[8:2] == pos_y_start + 6))
                    colour <= colour_in;
            end
        end
        else if(alph_input == 6'd22) begin
            // Code for 'W'
            if (heading) begin 
                if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 11)) ||
                    (vertical_addr[8:2] == (pos_y_start + 12) && (horizontal_addr[9:2] == (pos_x_start + 1) || horizontal_addr[9:2] == (pos_x_start + 5))) ||
                    (horizontal_addr[9:2] >= (pos_x_start + 2) && horizontal_addr[9:2] <= (pos_x_start + 4) && vertical_addr[8:2] == (pos_y_start + 11)) ||
                    (horizontal_addr[9:2] == (pos_x_start + 3) && vertical_addr[8:2] <= (pos_y_start + 10) && vertical_addr[8:2] >= (pos_y_start + 9)) ||
                    (horizontal_addr[9:2] == (pos_x_start + 6) && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 11)))
                    colour <= colour_in;  // Colour for "W"
            end
            else begin
                if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] == pos_y_start) 
                    || (horizontal_addr[9:2] == (pos_x_start + 1) && vertical_addr[8:2] == (pos_y_start + 1)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 2) && vertical_addr[8:2] == (pos_y_start + 2)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 3) && vertical_addr[8:2] == (pos_y_start + 3)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 4) && vertical_addr[8:2] == (pos_y_start + 4)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 5)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 6) && vertical_addr[8:2] == (pos_y_start + 6)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 1) && vertical_addr[8:2] == (pos_y_start + 12)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 2) && vertical_addr[8:2] == (pos_y_start + 11)) 
                    || (horizontal_addr[9:2] == (pos_x_start + 3) && vertical_addr[8:2] == (pos_y_start + 10))
                    || (horizontal_addr[9:2] == (pos_x_start + 4) && vertical_addr[8:2] == (pos_y_start + 9))
                    || (horizontal_addr[9:2] == (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 8)))
                    colour <= colour_in;
            end
        end
        else if(alph_input == 6'd23) begin
            // Code for 'X'
            if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2 ] == pos_y_start) 
                || (horizontal_addr[9:2] == (pos_x_start + 6) && vertical_addr[8:2] == pos_y_start) 
                || (horizontal_addr[9:2] == (pos_x_start + 1) && vertical_addr[8:2] == (pos_y_start + 1)) 
                || (horizontal_addr[9:2] == (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 1)) 
                || (horizontal_addr[9:2] == (pos_x_start + 2) && vertical_addr[8:2] == (pos_y_start + 2)) 
                || (horizontal_addr[9:2] == (pos_x_start + 4) && vertical_addr[8:2] == (pos_y_start + 2)) 
                || (horizontal_addr[9:2] == (pos_x_start + 3) && vertical_addr[8:2] == (pos_y_start + 3)) 
                || (horizontal_addr[9:2] == (pos_x_start + 4) && vertical_addr[8:2] == (pos_y_start + 4)) 
                || (horizontal_addr[9:2] == (pos_x_start + 2) && vertical_addr[8:2] == (pos_y_start + 5)) 
                || (horizontal_addr[9:2] == (pos_x_start + 5) && vertical_addr[8:2] == (pos_y_start + 5)) 
                || (horizontal_addr[9:2] == (pos_x_start + 1) && vertical_addr[8:2] == (pos_y_start + 6)) 
                || (horizontal_addr[9:2] == (pos_x_start + 6) && vertical_addr[8:2] == (pos_y_start + 6)))
                colour <= colour_in;
        end
        else if(alph_input == 6'd24) begin
            // Code for 'Y'
            if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 5)) ||
                    (horizontal_addr[9:2] == (pos_x_start + 4) && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 5)) ||
                    (horizontal_addr[9:2] >= (pos_x_start + 1) && horizontal_addr[9:2] <= (pos_x_start + 3) && vertical_addr[8:2] == (pos_y_start + 6)) ||
                    (horizontal_addr[9:2] == (pos_x_start + 2) && vertical_addr[8:2] >= (pos_y_start + 7) && vertical_addr[8:2] <= (pos_y_start + 12))) 
                colour <= colour_in;
        end
        else if(alph_input == 6'd25) begin
            // Code for 'Z'
            if ((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= (pos_x_start + 6) && (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start + 12))) ||
                (horizontal_addr[9:2] == (pos_x_start + 6 - (vertical_addr[8:2] - pos_y_start))))
                colour <= colour_in;
        end
        else if(alph_input == 6'd26) begin
            if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] == (pos_y_start+3)) || (horizontal_addr[9:2] == (pos_x_start+1) && vertical_addr[8:2] == (pos_y_start + 2))
                || (horizontal_addr[9:2] == (pos_x_start + 2) && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 6)))
                colour <= colour_in;
        end
        else if(alph_input == 6'd27) begin
            if (((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= (pos_x_start + 2)) && 
                (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start+6) || vertical_addr[8:2] == pos_y_start+4)) || // Top, middle, bottom lines
                ((horizontal_addr[9:2] == (pos_x_start + 2) && vertical_addr[8:2] > pos_y_start && vertical_addr[8:2] <= pos_y_start+4)) || // Top right vertical
                ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start+4 && vertical_addr[8:2] < pos_y_start+6))) // Bottom left vertical
                colour <= colour_in;
        end
        else if(alph_input == 6'd28) begin 
                if (
                    // Top left curve
                    (horizontal_addr[9:2] == pos_x_start + 2 && vertical_addr[8:2] == pos_y_start) ||
                    (horizontal_addr[9:2] == pos_x_start + 3 && vertical_addr[8:2] == pos_y_start) ||
                    (horizontal_addr[9:2] == pos_x_start + 1 && vertical_addr[8:2] == pos_y_start + 1) ||
                    (horizontal_addr[9:2] == pos_x_start + 4 && vertical_addr[8:2] == pos_y_start + 1) ||
                    (horizontal_addr[9:2] >= (pos_x_start + 2) && horizontal_addr[9:2] <= (pos_x_start + 6) && vertical_addr[8:2] == pos_y_start + 1) ||

                    // Top right curve
                    (horizontal_addr[9:2] == pos_x_start + 5 && vertical_addr[8:2] == pos_y_start) ||
                    (horizontal_addr[9:2] == pos_x_start + 6 && vertical_addr[8:2] == pos_y_start) ||
                    (horizontal_addr[9:2] == pos_x_start + 4 && vertical_addr[8:2] == pos_y_start + 1) ||
                    (horizontal_addr[9:2] == pos_x_start + 7 && vertical_addr[8:2] == pos_y_start + 1) ||

                    // Middle section
                    (horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= pos_x_start + 8 &&
                    vertical_addr[8:2] == pos_y_start + 2) ||
                    (horizontal_addr[9:2] >= pos_x_start + 1 && horizontal_addr[9:2] <= pos_x_start + 7 &&
                    vertical_addr[8:2] == pos_y_start + 3) ||
                    (horizontal_addr[9:2] >= pos_x_start + 2 && horizontal_addr[9:2] <= pos_x_start + 6 &&
                    vertical_addr[8:2] == pos_y_start + 4) ||
                    (horizontal_addr[9:2] >= pos_x_start + 3 && horizontal_addr[9:2] <= pos_x_start + 5 &&
                    vertical_addr[8:2] == pos_y_start + 5) ||

                    // Bottom point
                    (horizontal_addr[9:2] == pos_x_start + 4 && vertical_addr[8:2] == pos_y_start + 6)
                ) begin
                    // Set color for the heart
                    if (
                        // White highlight pixels
                        (horizontal_addr[9:2] == pos_x_start + 2 && vertical_addr[8:2] == pos_y_start + 1) ||
                        (horizontal_addr[9:2] == pos_x_start + 3 && vertical_addr[8:2] == pos_y_start + 1) ||
                        (horizontal_addr[9:2] == pos_x_start + 1 && vertical_addr[8:2] == pos_y_start + 2)
                    )
                        colour <= 12'hFFF; // White
                    else
                        colour <= 12'h00F; // Red
                end

        end
    end
endmodule
