`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 10:58:13 AM
// Design Name: 
// Module Name: Rx_Top
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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 10:58:13 AM
// Design Name: 
// Module Name: Rx_Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Top module for the RX system integrating the control path and data path.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Rx_Top #(
    parameter n = 8 // Number of data bits
)(
    input logic clk,
    input logic reset,
    input logic Serial_in,
    output logic [n-1:0] Data_out,         // Parallel data output
    output logic Parity_check_Correct,     // Parity check result
    output logic Stop_Correct              // Stop bit check result
);

    // Internal Signals
    logic Counter_Start_en, Counter_Data_en, Counter_Store_en;
    logic Start_en, Counter_Start_Done, Counter_Data_Done, Counter_Store_Done;
    logic [n-1:0] Counter_Store_out;
    logic Data_Shift_Done;
    logic Error_Parity_Flag, Error_Stop_Flag, Shift_en;

    // Instantiate Datapath
    Rx_DataPath #(.n(n)) datapath (
        .clk(clk),
        .reset(reset),
        .Serial_in(Serial_in),
        .Counter_Start_en(Counter_Start_en),
        .Counter_Data_en(Counter_Data_en),
        .Counter_Store_en(Counter_Store_en),
        .Start_en(Start_en),
        .Counter_Start_Done(Counter_Start_Done),
        .Counter_Data_Done(Counter_Data_Done),
        .Counter_Store_out(Counter_Store_out),
        .Counter_Store_Done(Counter_Store_Done),
        .Data_Shift_Done(Data_Shift_Done),
        .Data_out(Data_out),
        .Parity_check_Correct(Parity_check_Correct),
        .Stop_Correct(Stop_Correct),
        .Shift_en(Shift_en)
    );

    // Instantiate Control Path
    Rx_Control_path controlpath (
        .clk(clk),
        .reset(reset),
        .Serial_in(Serial_in),
        .Start_en(Start_en),
        .Counter_Start_Done(Counter_Start_Done),
        .Counter_Data_Done(Counter_Data_Done),
        .Counter_Store_out(Counter_Store_out),
        .Counter_Store_Done(Counter_Store_Done),
        .Data_Shift_Done(Data_Shift_Done),
        .Parity_check_Correct(Parity_check_Correct),
        .Stop_Correct(Stop_Correct),
        .Counter_Start_en(Counter_Start_en),
        .Counter_Data_en(Counter_Data_en),
        .Counter_Store_en(Counter_Store_en),
        .Error_Parity_Flag(Error_Parity_Flag),
        .Error_Stop_Flag(Error_Stop_Flag),
        .Shift_en(Shift_en)
    );

endmodule

