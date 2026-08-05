`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: buffer_in
// Project Name: Parameterised Systolic Array AI Accelerator
// Description: Stores and give the data to Pe array
//////////////////////////////////////////////////////////////////////////////////


module buffer_in #(parameter DATA_WIDTH = 8,
                   parameter N = 4,
                   parameter ADD_WIDTH = $clog2(N))(
  input clk,reset,
  
  // for writing data
  input write_enable[0:N-1],
  input [ADD_WIDTH-1:0] write_adrs[0:N-1],
  input [DATA_WIDTH-1:0] write_data[0:N-1],
  
  // for requesting data
  input read_enable[0:N-1],
  input [ADD_WIDTH-1:0] read_adrs[0:N-1],
  
  // for reading data
  output reg [DATA_WIDTH-1:0] read_data[0:N-1],
  output reg valid_data[0:N-1]
    );
    
   // memory for storing 
  reg [DATA_WIDTH-1:0] mem[0:N-1][0:N-1];
  
  integer i,j;
  
  // writing into register
  always@(posedge clk or posedge reset)
    begin
      if(reset) begin
                 for(i=0;i<N;i=i+1) begin
                   for(j=0;j<N;j=j+1) begin
                    mem[i][j]<='d0;
                   end
                end
                end
      else begin
         for(i=0;i<N;i=i+1) begin
             if(write_enable[i])mem[i][write_adrs[i]]<=write_data[i];
         end
      end
    end 
    
  // reading data from the memory
   always@(*) begin
       if(reset) begin
                   for(i=0;i<N;i=i+1) begin
                    read_data[i]='d0;
                    valid_data[i]=1'd0;
                  end
                 end 
      else     begin 
                  for(i=0;i<N;i=i+1)    begin
                      if(read_enable[i]) begin
                           read_data[i]=mem[i][read_adrs[i]];
                           valid_data[i]=1'd1;
                        end
                     else   begin 
              valid_data[i]=1'd0;
              read_data[i]='d0;
                      end
                     end   
               end 
   end
    
endmodule
