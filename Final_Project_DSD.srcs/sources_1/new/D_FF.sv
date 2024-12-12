`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 11:24:05 AM
// Design Name: 
// Module Name: D_FF
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


module D_FF(
    input logic clk,
    input logic reset,
    input logic D,
    output logic Q 
);

    always_ff @(posedge clk) begin
            Q <= D;
    end
endmodule

