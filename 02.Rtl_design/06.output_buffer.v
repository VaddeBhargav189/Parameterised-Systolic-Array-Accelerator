`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name   : buffer_out
// Project Name  : Parameterised Systolic Array AI Accelerator
// Description   : Receives the final matrix multiplication results from the
//                 PE array and stores them in the output buffer. Generates a
//                 store_complete signal after all results have been
//                 successfully stored.
//////////////////////////////////////////////////////////////////////////////////


module buffer_out
        #(parameter ACC_WIDTH = 32,
          parameter N = 4)(
      input clk,reset,
      
      input store_start,
      
      // input from pe_array
      input [ACC_WIDTH-1:0]C[0:N-1][0:N-1],
      
      output reg store_complete   
    );
    
    // results storing memory
    reg [ACC_WIDTH-1:0] result_matrix[0:N-1][0:N-1];
    integer i,j;
    
    // storing into the memory
    always@(posedge clk or posedge reset)   begin
        if(reset) begin
           for(i=0;i<N;i=i+1)  begin
             for(j=0;j<N;j=j+1)  begin
              result_matrix[i][j]<='d0;
               end
           end
           store_complete<=1'd0;
        end
      else if(store_start) begin
           for(i=0;i<N;i=i+1) begin
              for(j=0;j<N;j=j+1) begin
               result_matrix[i][j] <= C[i][j];
               end
            end
          store_complete <= 1'd1;
      end
      else store_complete <= 1'd0;
    end
endmodule
