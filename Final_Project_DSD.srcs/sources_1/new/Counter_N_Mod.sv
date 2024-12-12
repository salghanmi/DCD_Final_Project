`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 10:31:30 AM
// Design Name: 
// Module Name: Counter_N_Mod
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

module Counter_N_Mod#(parameter n=4)(
    input logic clk, 
    input logic reset, 
    input logic Enable,
    input logic [n-1:0] Count_number, 
    output logic [n-1:0] Counter_out, 
    output logic Counter_Done
);

    always_ff @(posedge clk , negedge reset) begin 
        if (!reset) begin
            Counter_out <= 0; 
        //    Counter_Done <= 0;
        end else if (Enable) begin
            if (Counter_out < Count_number) begin
                Counter_out <= Counter_out + 1; 
               // Counter_Done <= 0; // Reset Done signal during counting
            end else if (Counter_out == Count_number) begin
//                Counter_Done <= 1; // Signal Done when count is reached
                Counter_out <= 0; 
            end
        end
    end 
    assign Counter_Done = (Counter_out == Count_number) ;
endmodule

