`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name : input_scheduler
// Project Name : Parameterised Systolic Array AI Accelerator
// Description : Generates read addresses and valid signals
//               for streaming data into the systolic array.
//////////////////////////////////////////////////////////////////////////////////


module input_scheduler
              #(parameter N = 4,
                parameter ADD_WIDTH = $clog2(N)
                )(
  input clk,reset,
  
  //new
  input Schedular_start,
  
  output reg read_enable_A[0:N-1],
  output reg read_enable_B[0:N-1],
  output reg [ADD_WIDTH-1:0]read_adrs_A[0:N-1],
  output reg [ADD_WIDTH-1:0]read_adrs_B[0:N-1]
    );
    
    //new
    reg [ADD_WIDTH-1:0]read_adrs_A_store[0:N-1];
   reg [ADD_WIDTH-1:0]read_adrs_B_store[0:N-1];
   reg start[0:N-1];
   
    integer i;
    reg [$clog2(2*N)+1:0]cycle_counter;
    
    always@(posedge clk or posedge reset) begin
           if(reset || (~Schedular_start)) begin
               for(i=0;i<N;i=i+1)start[i] <= 1'd0;
               cycle_counter <= 'd0;
           end
           else begin
                    if(cycle_counter<N) start[cycle_counter]<=1'd1;
                    else if(cycle_counter<2*N) start[cycle_counter-N]<=1'd0;
                    cycle_counter<=cycle_counter+'d1;
           end
    end
    
    always@(posedge clk or posedge reset) begin
      if(reset) begin
            for(i=0;i<N;i=i+1)begin
                 read_enable_A[i] <= 1'd0;
                 read_enable_B[i] <= 1'd0;
                 read_adrs_A[i] <= 'd0;
                 read_adrs_B[i] <= 'd0;
                 read_adrs_A_store[i] <= 'd0;
                 read_adrs_B_store[i] <= 'd0;
            end
      end
      else begin
           for(i=0;i<N;i=i+1)begin
                if(start[i])begin
                  read_enable_A[i] <= 1'd1;
                  read_adrs_A[i] <= read_adrs_A_store[i];
                  read_enable_B[i] <= 1'd1;
                  read_adrs_B[i] <= read_adrs_B_store[i];
                  read_adrs_A_store[i] <= read_adrs_A_store[i]+'d1;
                  read_adrs_B_store[i] <= read_adrs_B_store[i]+'d1;
                end
                else begin
                 read_enable_A[i] <= 1'd0;
                 read_enable_B[i] <= 1'd0;
                 read_adrs_A[i] <= 'd0;
                 read_adrs_B[i] <= 'd0;
                 /*read_adrs_A_store[i] <= 'd0;
                 read_adrs_B_store[i] <= 'd0;*/
                end
           end
      end
    end
    
endmodule
