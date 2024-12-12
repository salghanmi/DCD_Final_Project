`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 10:50:33 AM
// Design Name: 
// Module Name: Shift_Register
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


module Shift_Register #(parameter WIDTH = 8)(
    input logic clk,
    input logic reset,
    input logic En_shift,
    input logic Serial_in,
    output logic [WIDTH-1:0] Data_out,
    output logic Data_Done
);

    logic [WIDTH-1:0] shift_reg;
    logic [$clog2(WIDTH):0] bit_count;

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            shift_reg <= 0;
            bit_count <= 0;
//            Data_Done <= 0;
        end else if (En_shift) begin
            // Shift data into the register
            shift_reg <= {shift_reg[WIDTH-2:0], Serial_in};
            bit_count <= bit_count + 1;

            if (bit_count == WIDTH-1) begin
//                Data_Done <= 1;
                bit_count <= 0; // Reset bit counter for the next sequence
//            end else begin
             //   Data_Done <= 0;
            end
        end
    end

    assign Data_out = shift_reg;
    assign Data_Done = (bit_count == (WIDTH-1 ));

endmodule
