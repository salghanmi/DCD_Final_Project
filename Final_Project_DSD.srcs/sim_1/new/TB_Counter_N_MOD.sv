`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 10:31:59 AM
// Design Name: 
// Module Name: TB_Counter_N_MOD
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


module TB_Counter_N_MOD;

    parameter n = 4;
    reg clk;
    reg reset;
    reg Enable;
    reg [n-1:0] Count_number;
    wire [n-1:0] Counter_out;
    wire Counter_Done;
    Counter_N_Mod #(n) DUT (
        .clk(clk), 
        .reset(reset), 
        .Enable(Enable), 
        .Count_number(Count_number), 
        .Counter_out(Counter_out), 
        .Counter_Done(Counter_Done)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    initial begin
        reset = 0;
        Enable = 0;
        Count_number = 4'd10; // Set target count to 10
        #10 reset = 1;
        #10 reset = 0;
        #10 reset = 1;
        #10 Enable = 1;
        #200;
        Enable = 0;

        #50 $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | reset=%b | Enable=%b | Count_number=%d | Counter_out=%d | Counter_Done=%b", 
                 $time, reset, Enable, Count_number, Counter_out, Counter_Done);
    end

endmodule

