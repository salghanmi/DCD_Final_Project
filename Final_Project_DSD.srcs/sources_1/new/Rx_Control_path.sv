//`timescale 1ns / 1ps

//module Rx_Control_path(
//    input logic clk,
//    input logic reset,
//    input logic Serial_in,
//    input logic Start_en,  // Enable signal for start bit detection
//    input logic Counter_Start_Done,
//    input logic Counter_Data_Done,  
//    input logic [7:0] Counter_Store_out, 
//    input logic Counter_Store_Done,
//    input logic Data_Shift_Done, 
////    input logic [n-1:0] Data_out, // Parallel data output
//    input logic Parity_check_Correct, // Parity check result
//    input logic Stop_Correct, // Stop bit check result
////input logic Shift_en,
//    output logic Counter_Start_en,
//    output logic Counter_Data_en, 
//    output logic Counter_Store_en,
//    output logic Error_Parity_Flag, 
//    output logic Error_Stop_Flag
////    output logic [2:0] state
//);
//    logic [3:0] parity_counter, Stop_Counter; 
//    logic Parrity_counter_Done, Stop_Counter_Done; 
    
    
//    // State Encoding
//    typedef enum logic [2:0] {
//        IDLE = 3'b000,
//        START = 3'b001,//-==== Check if need to add one state for Error 
//        DATA = 3'b010,
//        STORE = 3'b011,
//        PARITY_CHECK = 3'b100,
//        PARITY_ERROR = 3'b101,
//        STOP = 3'b110,
//        STOP_ERROR = 3'b111
//    } state_t;

//    state_t current_state, next_state;

//    // State Register
//    always @(posedge clk or posedge reset) begin
//        if (reset)
//            current_state <= IDLE;
//        else
//            current_state <= next_state;
//    end

//    // ====================== Next State Logic
//    always @(*) begin
//        case (current_state)
//            IDLE:
//                if (Start_en == 1) 
//                    next_state = START; 
//                else 
//                    next_state = IDLE;

//            START:
//                if ((Count_Start_Done == 1) &&( Serial_in==0) )
//                    next_state = DATA;
//                else 
//                    next_state = START;

//            DATA:
//                if (Count_Data_Done == 1)
//                    next_state = STORE;
//                else 
//                    next_state = DATA;

//            STORE: 
//                if ((Count_Store_Done == 1) && (Data_Shift_Done == 1))
//                    next_state = PARITY_CHECK;
//                else
//                    next_state = DATA;

//            PARITY_CHECK:
//            if(Parrity_counter_Done ==1 ) begin 
//                if (Parrity_check_Correct == 1)
//                    next_state = STOP; 
//                else 
//                    next_state = PARITY_ERROR;
//           end else 
//                nexte_state = PARITY_CHECK; 
//            PARITY_ERROR:
            
//                next_state = STOP;

//            STOP:
//                if (Stop_Counter_Done == 0)
//                    next_state = STOP; 
//                else if (Stop_Counter_Done == 1 & Serial_in ==1)
//                    next_state = IDLE;
//                else 
//                    next_state = STOP_ERROR;

//            STOP_ERROR:
//                next_state = IDLE; // Return to IDLE after error handling

//            default:
//                next_state = IDLE;
//        endcase
//    end

//always_ff @(posedge clk, negedge reset)begin 
//    if (!reset)begin 
//    Counter_Start_en <=0; 
//    Counter_Data_en <=0;
//    Counter_Store_en <=0;
//    Parrity_counter_Done <=0; 
//    parity_counter <=0; 
//    Stop_Counter<=0; 
//    end 
//    case(current_state)
//        IDEL: 
//            Counter_Start_en <=0; 
//            Counter_Data_en <=0;
//            Counter_Store_en <=0;
//            Parrity_counter_Done <=0; 
//            parity_counter <=0; 
//            Error_Parity_Flag<=0;
//            Error_Stop_Flag <0; 
//            Stop_Counter <=0; 
//        START:
//            Counter_Start_en <=1; 
//            Counter_Data_en <=0;
//            Counter_Store_en <=0;
//        DATA: 
//            Counter_Start_en <=0; 
//            Counter_Data_en <=1;
//            Counter_Store_en <=0;
//        STORE:
//            Counter_Store_en <=0; 
//            Counter_Data_en <=0;
//            Counter_Store_en <=1; 
//        PARITY_CHECK: 
//         if(parity_counter == 4'd15) 
//          Parrity_counter_Done <=1; 
//         else 
//            parity_counter =  parity_counter + 1;
            
//        PARITY_ERROR: 
//            Error_Parity_Flag<=1;
//        STOP:
//            if(Stop_Counter == 4'd15)
//                Stop_Counter_Done <=1; 
//                else 
//                    Stop_Counter = Stop_Counter +1; 
//       STOP_ERROR:
//            Error_Stop_Flag <=1; 

//end 



//endmodule

`timescale 1ns / 1ps

module Rx_Control_path(
    input logic clk,
    input logic reset,
    input logic Serial_in,
    input logic Start_en,  // Enable signal for start bit detection
    input logic Counter_Start_Done,
    input logic Counter_Data_Done,
    input logic [7:0] Counter_Store_out,
    input logic Counter_Store_Done,
    input logic Data_Shift_Done,
    // input logic [n-1:0] Data_out, // Parallel data output
    input logic Parity_check_Correct, // Parity check result
    input logic Stop_Correct, // Stop bit check result
     output logic Shift_en,
    output logic Counter_Start_en,
    output logic Counter_Data_en,
    output logic Counter_Store_en,
    output logic Error_Parity_Flag,
    output logic Error_Stop_Flag
    // output logic [2:0] state
);
    logic [3:0] parity_counter, Stop_Counter; 
    logic Parrity_counter_Done; 
    
    // State Encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001, // -==== Check if need to add one state for Error
        DATA = 3'b010,
        STORE = 3'b011,
        PARITY_CHECK = 3'b100,
        PARITY_ERROR = 3'b101,
        STOP = 3'b110,
        STOP_ERROR = 3'b111
    } state_t;

    state_t current_state, next_state;

    // State Register
    always @(posedge clk or posedge reset) begin
        if (!reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // ====================== Next State Logic
    always @(*) begin
        case (current_state)
            IDLE:
                if (Start_en == 1) 
                    next_state = START; 
                else 
                    next_state = IDLE;

            START:
                if ((Counter_Start_Done == 1) && (Serial_in == 0))
                    next_state = DATA;
                else 
                    next_state = START;

            DATA:
                if (Counter_Data_Done == 1)
                    next_state = STORE;
                else 
                    next_state = DATA;

            STORE: 
                if ((Counter_Store_Done == 1) )
                    next_state = PARITY_CHECK;
                else
                    next_state = DATA;

            PARITY_CHECK:
            
                if (Counter_Data_Done == 1)
                    if(Parity_check_Correct == 1) 
                        next_state= STOP; 
                    else 
                        next_state = PARITY_ERROR;
                else 
                    next_state = PARITY_CHECK; 

            PARITY_ERROR:
                next_state = STOP;

            STOP:
            
                if (Counter_Data_Done == 1 )
                    if(Serial_in ==1)
                        next_state= IDLE; 
                    else 
                        next_state = STOP_ERROR;
                else 
                    next_state = STOP; 
            
            STOP_ERROR:
                next_state = IDLE; // Return to IDLE after error handling

            default:
                next_state = IDLE;
        endcase
    end

    // Output Logic
    always @(*) begin 
        if (!reset) begin 
            Counter_Start_en = 0; 
            Counter_Data_en = 0;
            Counter_Store_en = 0;
            Parrity_counter_Done = 0; 
            parity_counter = 0; 
            Stop_Counter = 0; 
            Error_Parity_Flag = 0;
            Error_Stop_Flag = 0; 
            Shift_en=0;
        end else begin
            case (current_state)
                IDLE: begin
                    Counter_Start_en = 0; 
                    Counter_Data_en = 0;
                    Counter_Store_en = 0;
                    Parrity_counter_Done = 0; 
                    parity_counter = 0; 
                    Error_Parity_Flag = 0;
                    Error_Stop_Flag = 0; 
                    Stop_Counter = 0; 
                    Shift_en=0;

                end
                START: begin
                    Counter_Start_en = 1; 
                    Counter_Data_en = 0;
                    Counter_Store_en = 0;
                    Shift_en=0;

                end
                DATA: begin
                    Counter_Start_en = 0; 
                    Counter_Data_en = 1;
                    Counter_Store_en = 0;
                    Shift_en=0;

                end
                STORE: begin
                    Counter_Start_en = 0; 
                    Counter_Data_en = 0;
                    Counter_Store_en = 1; 
                    Shift_en=1;

                end
                PARITY_CHECK: begin
                    Counter_Start_en = 0; 
                    Counter_Data_en = 1;
                    Counter_Store_en = 0;
                    Shift_en=0;

              end
                PARITY_ERROR: begin
                    Counter_Start_en = 0; 
                    Counter_Data_en = 0;
                    Counter_Store_en = 0;
                    Shift_en=0;
                    Error_Parity_Flag = 1;
                    end 
                STOP: begin
                    Counter_Start_en = 0; 
                    Counter_Data_en = 1;
                    Counter_Store_en = 0;
                    Shift_en=0;

                end
                STOP_ERROR:
                    Error_Stop_Flag <= 1; 
            endcase
        end
    end

endmodule
