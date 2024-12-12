`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 02:58:59 PM
// Design Name: 
// Module Name: Stop_bit_Check
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

module Stop_bit_Check (
    input logic serial_in,        // Serial input to check the stop bit
    output logic stop_correct     // Indicates if the stop bit is correct
);

    // The stop bit in UART should always be high (1)
    always_comb begin
        stop_correct = (serial_in == 1'b1); // Stop bit is valid if serial_in is high
    end

endmodule

