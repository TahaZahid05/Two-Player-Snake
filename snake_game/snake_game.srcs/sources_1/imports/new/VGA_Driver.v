`timescale 1ns / 1ps
module VGA_Driver(
    input CLK,
    input [11:0] COLOUR_IN,
    output [9:0] ADDRH,
    output [9:0] ADDRV,
    output [11:0] COLOUR_OUT,
    output HS,
    output VS
    );
    
    reg [11:0] col_out;
    reg hsync;
    reg vsync;
    
    assign COLOUR_OUT = col_out;
    assign HS = hsync;
    assign VS = vsync;
    
    parameter VertTimeToPulseWeidthEnd = 10'd2;
    parameter VertTimeToBackPorchEnd = 10'd31;
    parameter VertTimeToDisplayTimeEnd = 10'd511;
    parameter VertTimeToFrontPorchEnd = 10'd521;
    
    parameter HorzTimeToPulseWidthEnd = 10'd96;
    parameter HorzTimeToBackPorchEnd = 10'd144;
    parameter HorzTimeToDisplayTimeEnd = 10'd784;
    parameter HorzTimeToFrontPorchEnd = 10'd800;
    
    wire [9:0] CounterTo799Trigger;
    wire [9:0] CounterTo520Trigger;
    wire CounterTo4Trigger;
    wire TrigSecondCounter;
    
    Generic_counter # (
                    .COUNTER_WIDTH(2),
                    .COUNTER_MAX(3)
                  )
                  CounterTo3 (
                    .CLK(CLK),
                    .RESET(1'b0),
                    .ENABLE_IN(1'b1),
                    .TRIG_OUT(CounterTo4Trigger)
                  );
    
    Generic_counter # (
                        .COUNTER_WIDTH(10),
                        .COUNTER_MAX(HorzTimeToFrontPorchEnd-10'd1)
                      )
                      CounterTo799 (
                        .CLK(CLK),
                        .RESET(1'b0),
                        .ENABLE_IN(CounterTo4Trigger),
                        .TRIG_OUT(TrigSecondCounter),
                        .COUNT(CounterTo799Trigger)
                      );
                      
    Generic_counter # (
                          .COUNTER_WIDTH(10),
                          .COUNTER_MAX(VertTimeToFrontPorchEnd-10'd1)
                        )
                        CounterTo520 (
                          .CLK(CLK),
                          .RESET(1'b0),
                          .ENABLE_IN(TrigSecondCounter),
                          .COUNT(CounterTo520Trigger)
                        );
     
    always@(posedge CLK) begin
        if (CounterTo799Trigger < HorzTimeToPulseWidthEnd)
            hsync <= 1'b0;
        else
            hsync <= 1'b1;
    end
    
    always@(posedge CLK) begin
        if (CounterTo520Trigger < VertTimeToPulseWeidthEnd)
            vsync <= 1'b0;
        else
            vsync <= 1'b1;
    end
    
    reg [9:0] HorAddr;
    reg [9:0] VerAddr;
    
    always@(posedge CLK) begin
        if ((VertTimeToBackPorchEnd <= CounterTo520Trigger) && (CounterTo520Trigger < VertTimeToDisplayTimeEnd) &&
            (HorzTimeToBackPorchEnd <= CounterTo799Trigger) && (CounterTo799Trigger < HorzTimeToDisplayTimeEnd)) begin
            col_out <= COLOUR_IN;
            HorAddr <= CounterTo799Trigger - HorzTimeToBackPorchEnd;
            VerAddr <= CounterTo520Trigger - VertTimeToBackPorchEnd;
        end
        else begin
            col_out <= 12'h000;
            HorAddr <= 10'd0;
            VerAddr <= 10'd0;
        end
    end
    
    assign ADDRH = HorAddr;
    assign ADDRV = VerAddr;
    
endmodule