`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 10:54:37 AM
// Design Name: 
// Module Name: Shift_Register_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Shift_Register_TB;


    // Parameters
    parameter WIDTH = 8;

    // Testbench signals
    reg clk;
    reg reset;
    reg En_shift;
    reg serial_in;
    wire [WIDTH-1:0] Data_out;
    wire Data_Done;

    // Instantiate the DUT (Device Under Test)
    Shift_Register #(WIDTH) DUT (
        .clk(clk),
        .reset(reset),
        .En_shift(En_shift),
        .serial_in(serial_in),
        .Data_out(Data_out),
        .Data_Done(Data_Done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Test sequence
    initial begin
        // Initialize signals
        reset = 0;
        En_shift = 0;
        serial_in = 0;

        // Apply reset
        #10 reset = 1;

        // Start shifting sequence
        #10 En_shift = 1;

        // Shift in 8 bits of data
        #10 serial_in = 1;
        #10 serial_in = 0;
        #10 serial_in = 1;
        #10 serial_in = 1;
        #10 serial_in = 0;
        #10 serial_in = 0;
        #10 serial_in = 1;
        #10 serial_in = 1;

        // Wait for Data_Done
        #20 En_shift = 0;
      // End simulation
        #50 $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | reset=%b | En_shift=%b | serial_in=%b | Data_out=%b | Data_Done=%b", 
                 $time, reset, En_shift, serial_in, Data_out, Data_Done);
    end
endmodule
