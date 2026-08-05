`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: top
// Project Name: Parameterised Systolic Array AI Accelerator
// Description: Top-level module integrating
                // 1. Input_scheduler
                // 2. Dual input buffers
                // 3. 2x2 Pe array
                // 4. Output buffer
                // 5. Controller
//////////////////////////////////////////////////////////////////////////////////


module top#(parameter N = 5,
            parameter DATA_WIDTH = 16,
            parameter ADD_WIDTH = $clog2(N),
            parameter ACC_WIDTH = 3*DATA_WIDTH)(
     input clk,reset,start,
     
     // inputs for writing into a_buffer
    input write_enable_a[0:N-1],
    input [ADD_WIDTH-1:0] write_adrs_a[0:N-1],
    input [DATA_WIDTH-1:0] write_data_a[0:N-1],
    
    // inputs for writing into b_buffer
    input write_enable_b[0:N-1],
    input [ADD_WIDTH-1:0] write_adrs_b[0:N-1],
    input [DATA_WIDTH-1:0] write_data_b[0:N-1],
    
    output done
    
    );
    
    //  controller Interface
       wire scheduler_start;
       wire store_start;
    
    //  scheduler Interface
    
          // (for requesting A buffer)
             wire read_enable_A[0:N-1];
             wire [ADD_WIDTH-1:0]read_adrs_A[0:N-1];
             
         // (for requesting B buffer)
             wire read_enable_B[0:N-1];
             wire [ADD_WIDTH-1:0]read_adrs_B[0:N-1];
             
   // a_buffer Interface
     wire [DATA_WIDTH-1:0] read_data_A[0:N-1];
     wire valid_data_A[0:N-1];
     
   //  b_buffer Interface
     wire [DATA_WIDTH-1:0] read_data_B[0:N-1];
     wire valid_data_B[0:N-1];
     
     //  Pe_array Interface
     wire [ACC_WIDTH-1:0] C[0:N-1][0:N-1];
     
     //  output_buffer Interface
     wire store_complete;
    
//---------------------------------------------------
// input_scheduler
//---------------------------------------------------
    input_scheduler #(.N(N),.ADD_WIDTH(ADD_WIDTH)) input_scheduler_insta(.clk(clk),.reset(reset),.Schedular_start(scheduler_start),.read_enable_A(read_enable_A),.read_enable_B(read_enable_B),.read_adrs_A(read_adrs_A),.read_adrs_B(read_adrs_B));
    
 //---------------------------------------------------
// a_buffer 
//---------------------------------------------------
    buffer_in #(.N(N),.DATA_WIDTH(DATA_WIDTH),.ADD_WIDTH(ADD_WIDTH)) a_buffer(.clk(clk),.reset(reset),.write_enable(write_enable_a),.write_adrs(write_adrs_a),.write_data(write_data_a),.read_enable(read_enable_A),.read_adrs(read_adrs_A),.read_data(read_data_A),.valid_data(valid_data_A));

//---------------------------------------------------
// b_buffer
//---------------------------------------------------    
    buffer_in #(.N(N),.DATA_WIDTH(DATA_WIDTH),.ADD_WIDTH(ADD_WIDTH)) b_buffer(.clk(clk),.reset(reset),.write_enable(write_enable_b),.write_adrs(write_adrs_b),.write_data(write_data_b),.read_enable(read_enable_B),.read_adrs(read_adrs_B),.read_data(read_data_B),.valid_data(valid_data_B));
 
 //---------------------------------------------------
// pe_array
//--------------------------------------------------   
    array #(.N(N),.DATA_WIDTH(DATA_WIDTH),.ACC_WIDTH(ACC_WIDTH)) pe_array(.clk(clk),.reset(reset),.store_start(store_start),.A(read_data_A),.B(read_data_B),.valid_a(valid_data_A),.valid_b(valid_data_B),.C(C));
 
 //---------------------------------------------------
// Controller
//---------------------------------------------------   
    controller #(.N(N)) controller_insta(.clk(clk),.reset(reset),.start(start),.store_complete(store_complete),.scheduler_start(scheduler_start),.done(done),.store_start(store_start));
 
 //---------------------------------------------------
// output buffer
//---------------------------------------------------   
    buffer_out #(.N(N),.ACC_WIDTH(ACC_WIDTH)) output_buffer_insta(.clk(clk),.reset(reset),.store_start(store_start),.C(C),.store_complete(store_complete));
    
endmodule
