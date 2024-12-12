`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 03:46:49 PM
// Design Name: 
// Module Name: Rx_Top_TB
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



module Rx_Top_TB;


    // Parameters
    parameter n = 8;

    // Testbench Signals
    logic clk;
    logic reset;
    logic Serial_in;
    logic [n-1:0] Data_out;
    logic Parity_check_Correct;
    logic Stop_Correct;

    // Clock Generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns clock period

    // Instantiate the Rx_Top Module
    Rx_Top #(.n(n)) uut (
        .clk(clk),
        .reset(reset),
        .Serial_in(Serial_in),
        .Data_out(Data_out),
        .Parity_check_Correct(Parity_check_Correct),
        .Stop_Correct(Stop_Correct)
    );

    // Test Stimuli
    initial begin
        // Initialize signals
        reset = 1;
        Serial_in = 1; // Idle state (high for UART)

        // Apply reset
        #20;
        reset = 0; 
        #20;
        reset = 1;
        // Start bit (low)
        repeat(10) @(negedge clk);
        Serial_in = 0; // Start bit
        repeat(16) @(negedge clk);  
        
          
        // Send data bits (example: 8'b10101010)
        Serial_in = 1; // Bit 0
        repeat(16) @(negedge clk);    
        Serial_in = 0; // Bit 1
        repeat(16) @(negedge clk);    
        Serial_in = 1; // Bit 2
        repeat(16) @(negedge clk);    
        Serial_in = 0; // Bit 3
        repeat(16) @(negedge clk);    
        Serial_in = 1; // Bit 4
        repeat(16) @(negedge clk);    
        Serial_in = 0; // Bit 5
        repeat(16) @(negedge clk);    
        Serial_in = 1; // Bit 6
        repeat(16) @(negedge clk);    
        Serial_in = 0; // Bit 7
        repeat(16) @(negedge clk);    

        Serial_in = 0; // Parity
        repeat(16) @(negedge clk); 

        Serial_in = 1; // Stop
        repeat(16) @(negedge clk); 
        Serial_in = 1;

        // Idle state
        #40; Serial_in = 1;

        // End simulation
        #100;
        $stop;
    end

    // Monitor Outputs
    initial begin
        $monitor("Time=%0t | Serial_in=%b | Data_out=%b | Parity_check_Correct=%b | Stop_Correct=%b",
                 $time, Serial_in, Data_out, Parity_check_Correct, Stop_Correct);
    end

endmodule
