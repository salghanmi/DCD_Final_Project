//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 12/11/2024 11:01:34 AM
//// Design Name: 
//// Module Name: Rx_DataPath
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////

//module Rx_DataPath#(parameter n = 8)(

//    input logic clk,
//    input logic reset,
//    input logic Serial_in, 
//    input logic Counter_Start_en,
//    input logic Counter_Data_en, 
//    input logic Counter_Store_en, 
////    input logic Shift_En
    
//    output logic Start_en,  // Enable signal for start bit detection
//    output logic Counter_Start_Done,
//    output logic Counter_Data_Done,  
//    output logic [n-1:0] Counter_Store_out, 
//    output logic Counter_Store_Done,
//    output logic Data_Shift_Done, 
//    output logic [n-1:0] Data_out, // Parallel data output
//    output logic Parity_check_Correct, // Parity check result
//    output logic Stop_Correct // Stop bit check result
 
    
    
//);

//    // Internal Signals
////    logic Data_Done;
////    logic Counter_Start_Done, Counter_Data_Done;
////    logic [n-1:0] Shifted_Data;

//    // Shift Register: Serial to Parallel Conversion
//    Shift_Register #(.n(n)) Shift_Reg_inst (
//        .clk(clk),
//        .reset(reset),
//        .En_shift(Counter_Data_Done), // Controlled by FSM
//        .Serial_in(Serial_in),
//        .Data_out(Data_out), // Parallel data
//        .Data_Done(Data_Shift_Done)    // Indicates when shifting is complete
//    );

//    // Start Bit Detection: D Flip-Flop and Counter
//    D_FF Dff_inst (
//        .clk(clk),
//        .reset(reset),
//        .D(Serial_in),        // Sample the start bit
//        .Q(),                 // Not connected;
//        .Start_en(Start_en)   // FSM-controlled start enable
//    );

//    Counter_N_Mod #(.n(4)) Counter_Start_bit (
//        .clk(clk),
//        .reset(reset),
//        .Enable(Counter_Start_en),         // Enabled by FSM when detecting start bit
//        .Count_number(4'd7),       // 7 counts for start bit duration
//        .Counter_out(),            // Optional output for debugging
//        .Counter_Done(Counter_Start_Done) // Indicates when start bit counting is done
//    );

//    // Data Bit Counter for Reading Data 
//    Counter_N_Mod #(.n(4)) Counter_Data (
//        .clk(clk),
//        .reset(reset),
//        .Enable(Counter_Data_en),         // Enabled when shifting data
//        .Count_number(4'd15),      // 15 counts for 8 data bits + parity + stop bit
//        .Counter_out(),            // Optional output for debugging
//        .Counter_Done(Counter_Data_Done) // Indicates when data bit counting is done
//    );
    
//    // Data Bit Counter for Storing Data 
//    Counter_N_Mod #(.n(4)) Counter_Store (
//        .clk(clk),
//        .reset(reset),
//        .Enable(Counter_Store_en),         // Enabled when shifting data
//        .Count_number(4'd8),      // 15 counts for 8 data bits + parity + stop bit
//        .Counter_out(Counter_Store_out),            // Optional output for debugging
//        .Counter_Done(Counter_Store_Done) // Indicates when data bit counting is done
//    );
//    // Parity Checker
//    Parity_Checker Parity_Check_inst (
//        .data(Shifted_Data),
//        .parity_bit(Serial_in), // Assumes parity bit is sampled directly from Serial_in
//        .parity_correct(Parity_check_Correct)
//    );

//    // Stop Bit Checker
//    Stop_bit_Check Stop_Check_inst (
//        .serial_in(Serial_in), // Check the stop bit directly from Serial_in
//        .stop_correct(Stop_Correct)
//    );

//    // Data Output
////    assign Data_out = Shifted_Data;

//endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 11:01:34 AM
// Design Name: 
// Module Name: Rx_DataPath
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

module Rx_DataPath#(parameter n = 8)(
    input logic clk,
    input logic reset,
    input logic Serial_in,
    input logic Counter_Start_en,
    input logic Counter_Data_en,
    input logic Counter_Store_en,
    input logic Shift_en,
    output logic Start_en,             // Enable signal for start bit detection
    output logic Counter_Start_Done,
    output logic Counter_Data_Done,
    output logic [n-1:0] Counter_Store_out,
    output logic Counter_Store_Done,
    output logic Data_Shift_Done,
    output logic [n-1:0] Data_out,     // Parallel data output
    output logic Parity_check_Correct, // Parity check result
    output logic Stop_Correct          // Stop bit check result
);

    // Internal Signals
    logic [n-1:0] Shifted_Data; // Intermediate signal for shifted data

    // Shift Register: Serial to Parallel Conversion
    Shift_Register #(.n(n)) Shift_Reg_inst (
        .clk(clk),
        .reset(reset),
        .En_shift(Shift_en),     // Controlled by FSM
        .Serial_in(Serial_in),
        .Data_out(Shifted_Data),        // Parallel data
        .Data_Done(Data_Shift_Done)     // Indicates when shifting is complete
    );

    // Start Bit Detection: Simple Flip-Flop
    logic Q;
    D_FF Dff_inst (
        .clk(clk),
        .reset(reset),
        .D(Serial_in),        // Sample the start bit
        .Q(Q)          // FSM-controlled start enable
    );
    assign Start_en = Q & ~Serial_in;
    // Start Bit Counter
    Counter_N_Mod #(.n(4)) Counter_Start_bit (
        .clk(clk),
        .reset(reset),
        .Enable(Counter_Start_en),         // Enabled by FSM when detecting start bit
        .Count_number(4'd6),               // 7 counts for start bit duration
        .Counter_out(),                    // Optional output for debugging
        .Counter_Done(Counter_Start_Done)  // Indicates when start bit counting is done
    );

    // Data Bit Counter for Reading Data
    Counter_N_Mod #(.n(4)) Counter_Data (
        .clk(clk),
        .reset(reset),
        .Enable(Counter_Data_en),          // Enabled when shifting data
        .Count_number(4'd14),              // 15 counts for 8 data bits + parity + stop bit
        .Counter_out(),                    // Optional output for debugging
        .Counter_Done(Counter_Data_Done)   // Indicates when data bit counting is done
    );

    // Data Bit Counter for Storing Data
    Counter_N_Mod #(.n(4)) Counter_Store (
        .clk(clk),
        .reset(reset),
        .Enable(Counter_Store_en),         // Enabled for storing data
        .Count_number(4'd7),               // 8 counts for data storage
        .Counter_out(Counter_Store_out),   // Output count
        .Counter_Done(Counter_Store_Done)  // Indicates when data storage is complete
    );

    // Parity Checker
    Parity_Checker Parity_Check_inst (
        .data(Shifted_Data),               // Data from shift register
        .parity_bit(Serial_in),            // Parity bit directly from Serial_in
        .parity_correct(Parity_check_Correct) // Parity check result
    );

    // Stop Bit Checker
    Stop_bit_Check Stop_Check_inst (
        .serial_in(Serial_in),             // Check the stop bit directly from Serial_in
        .stop_correct(Stop_Correct)        // Stop bit check result
    );

assign Data_out = Shifted_Data; 
endmodule
