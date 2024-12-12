`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 02:56:45 PM
// Design Name: 
// Module Name: Parity_Checker
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


module Parity_Checker(
    input wire [7:0] data,
    input wire parity_bit,
    output wire parity_correct
);
    assign parity_correct = (^{data, parity_bit}) == 0; // XOR for even parity
endmodule
