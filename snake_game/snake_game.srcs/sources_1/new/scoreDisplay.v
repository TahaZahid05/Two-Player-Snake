module scoreDisplay (
    input wire [9:0] horizontal_addr,
    input wire [8:0] vertical_addr,
    input wire [3:0] score_snake_one,
    input wire [3:0] score_snake_two,
    input wire [8:0] pos_x_start,
    input wire [8:0] pos_x_end,
    input wire [7:0] pos_y_start,
    input wire [7:0] pos_y_end,
    input wire [11:0] colour_in,
    output reg [11:0] colour
);

always @(*) begin
    if (score_snake_one + score_snake_two == 4'd0) begin
        if (((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= pos_x_end) && 
                (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == pos_y_end)) || // Top and bottom horizontal lines
            ((horizontal_addr[9:2] == pos_x_start || horizontal_addr[9:2] == pos_x_end) && 
                (vertical_addr[8:2] > pos_y_start && vertical_addr[8:2] < pos_y_end))) begin // Left and right vertical lines
            colour <= colour_in;
        end
        else
            colour <= 12'h000;
    end 
    else if (score_snake_one + score_snake_two == 4'd1) begin
        if ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] == (pos_y_start+3)) || (horizontal_addr[9:2] == (pos_x_start+1) && vertical_addr[8:2] == (pos_y_start + 2))
            || (horizontal_addr[9:2] == pos_x_end && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= pos_y_end)) begin
            colour <= colour_in;
        end
        else
            colour <= 12'h000;
    end
    else if (score_snake_one + score_snake_two == 4'd2) begin
        if (((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= pos_x_end) && 
                    (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start+5) || vertical_addr[8:2] == pos_y_end)) || // Top, middle, bottom lines
                    ((horizontal_addr[9:2] == pos_x_end && vertical_addr[8:2] > pos_y_start && vertical_addr[8:2] <= (pos_y_start+5))) || // Top right vertical
                    ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= (pos_y_start+5) && vertical_addr[8:2] < pos_y_end))) begin // Bottom left vertical
            colour <= colour_in;
        end
        else
            colour <= 12'h000;
    end
    
    else if (score_snake_one + score_snake_two == 4'd3) begin
        if (((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= pos_x_end) && 
                    (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start+5) || vertical_addr[8:2] == pos_y_end)) || // Top, middle, bottom lines
                    (horizontal_addr[9:2] == pos_x_end && vertical_addr[8:2] > pos_y_start && vertical_addr[8:2] < pos_y_end)) begin // Right vertical line
            colour <= colour_in;
        end  
        else
            colour <= 12'h000;
    end
    else if (score_snake_one + score_snake_two == 4'd4) begin
        if (((horizontal_addr[9:2] == pos_x_start || horizontal_addr[9:2] == pos_x_end) && 
                    (vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start+5))) || // Left and right vertical lines (top half)
                    ((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= pos_x_end) && 
                    (vertical_addr[8:2] == (pos_y_start+5))) || (horizontal_addr[9:2] == pos_x_end &&
                    vertical_addr[8:2] > (pos_y_start+5) && vertical_addr[8:2] <= pos_y_end)) begin // Middle horizontal line
            colour <= colour_in;
        end
        else
            colour <= 12'h000;
    end
    else if (score_snake_one + score_snake_two == 4'd5) begin
        if (((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= pos_x_end) && 
                    (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start+5) || vertical_addr[8:2] == pos_y_end)) || // Top, middle, bottom lines
                    ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] > pos_y_start && vertical_addr[8:2] <= (pos_y_start+5))) || // Top left vertical
                    ((horizontal_addr[9:2] == pos_x_end && vertical_addr[8:2] >= (pos_y_start+5) && vertical_addr[8:2] < pos_y_end))) begin // Bottom right vertical
            colour <= colour_in;
        end
        else
            colour <= 12'h000;
    end
    else if (score_snake_one + score_snake_two == 4'd6) begin
        if (((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= pos_x_end) && 
                    (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start+5) || vertical_addr[8:2] == pos_y_end)) || // Top, middle, bottom lines
                    ((horizontal_addr[9:2] == pos_x_start && vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= pos_y_end)) || // Left vertical line
                    ((horizontal_addr[9:2] == pos_x_end && vertical_addr[8:2] >= (pos_y_start+5) && vertical_addr[8:2] < pos_y_end))) begin // Bottom right vertical
            colour <= colour_in;
        end
        else
            colour <= 12'h000;
    end
    else if (score_snake_one + score_snake_two == 4'd7) begin
        if (((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= pos_x_end) && 
                    (vertical_addr[8:2] == pos_y_start)) || // Top horizontal line
                    (horizontal_addr[9:2] == pos_x_end && vertical_addr[8:2] > pos_y_start && vertical_addr[8:2] <= pos_y_end)) begin // Right vertical line
            colour <= colour_in;
        end
        else
            colour <= 12'h000;
    end
    else if (score_snake_one + score_snake_two == 4'd8) begin
        if (((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= pos_x_end) && 
                    (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start+5) || vertical_addr[8:2] == pos_y_end)) || // Top, middle, bottom lines
                    ((horizontal_addr[9:2] == pos_x_start || horizontal_addr[9:2] == pos_x_end) && 
                    (vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= pos_y_end))) begin // Left and right vertical lines
            colour <= colour_in;
        end 
        else
            colour <= 12'h000;
    end 
    else if (score_snake_one + score_snake_two == 4'd9) begin
        if (((horizontal_addr[9:2] >= pos_x_start && horizontal_addr[9:2] <= pos_x_end) && 
            (vertical_addr[8:2] == pos_y_start || vertical_addr[8:2] == (pos_y_start + 5) || vertical_addr[8:2] == pos_y_end)) || // Top, middle, bottom lines
            ((horizontal_addr[9:2] == pos_x_start || horizontal_addr[9:2] == pos_x_end) && 
            (vertical_addr[8:2] >= pos_y_start && vertical_addr[8:2] <= (pos_y_start + 5))) || // Left and right vertical lines (top half)
            (horizontal_addr[9:2] == pos_x_end && vertical_addr[8:2] >= (pos_y_start + 5) && vertical_addr[8:2] <= pos_y_end)) begin // Right vertical line (bottom half)
            colour <= colour_in;
        end 
        else
            colour <= 12'h000;
    end
end

endmodule