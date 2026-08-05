`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name   : array
// Project Name  : Parameterised Systolic Array AI Accelerator
// Description   : Instantiates and interconnects NxN Processing Elements (PEs)
//                 in a NxN systolic array. Routes input operands and valid signals
//                 between PEs. Provides the final matrix multiplication results to the
//                 output buffer.
//////////////////////////////////////////////////////////////////////////////////


module array #(parameter DATA_WIDTH = 8,
               parameter ACC_WIDTH = 32,
               parameter N = 4)(
           input clk,
           input reset,
           input store_start,
           
          //new 
           input [DATA_WIDTH-1:0] A[0:N-1],
           input [DATA_WIDTH-1:0] B[0:N-1],
           input valid_a[0:N-1],
           input valid_b[0:N-1],
           
           //new
           output reg [ACC_WIDTH-1:0] C[0:N-1][0:N-1]
          
    );
    
         // new
           genvar i,j;
              generate 
                 for(i=0;i<N;i=i+1) begin:Row
                   for(j=0;j<N;j=j+1) begin:Col
                       wire [DATA_WIDTH-1:0] a_out,b_out;
                       wire valid_outa,valid_outb;
                       wire [ACC_WIDTH-1:0] sum;
                        if((i==0) && (j==0))begin
                               pe #(.DATA_WIDTH(DATA_WIDTH),.ACC_WIDTH(ACC_WIDTH)) pe_insta(.clk(clk),.reset(reset),.a_in(A[i]),.b_in(B[j]),.valid_ina(valid_a[i]),.valid_inb(valid_b[j]),.a_out(Row[i].Col[j].a_out),.b_out(Row[i].Col[j].b_out),.valid_outa(Row[i].Col[j].valid_outa),.valid_outb(Row[i].Col[j].valid_outb),.sum(C[i][j]));
                        end
                       else if(i==0) begin
                            pe #(.DATA_WIDTH(DATA_WIDTH),.ACC_WIDTH(ACC_WIDTH)) pe_insta(.clk(clk),.reset(reset),.a_in(Row[i].Col[j-1].a_out),.b_in(B[j]),.valid_ina(Row[i].Col[j-1].valid_outa),.valid_inb(valid_b[j]),.a_out(Row[i].Col[j].a_out),.b_out(Row[i].Col[j].b_out),.valid_outa(Row[i].Col[j].valid_outa),.valid_outb(Row[i].Col[j].valid_outb),.sum(C[i][j]));   
                       end
                       else if(j==0) begin
                            pe #(.DATA_WIDTH(DATA_WIDTH),.ACC_WIDTH(ACC_WIDTH)) pe_insta(.clk(clk),.reset(reset),.a_in(A[i]),.b_in(Row[i-1].Col[j].b_out),.valid_ina(valid_a[i]),.valid_inb(Row[i-1].Col[j].valid_outb),.a_out(Row[i].Col[j].a_out),.b_out(Row[i].Col[j].b_out),.valid_outa(Row[i].Col[j].valid_outa),.valid_outb(Row[i].Col[j].valid_outb),.sum(C[i][j]));   
                       end
                       else begin
                           pe #(.DATA_WIDTH(DATA_WIDTH),.ACC_WIDTH(ACC_WIDTH)) pe_insta(.clk(clk),.reset(reset),.a_in(Row[i].Col[j-1].a_out),.b_in(Row[i-1].Col[j].b_out),.valid_ina(Row[i].Col[j-1].valid_outa),.valid_inb(Row[i-1].Col[j].valid_outb),.a_out(Row[i].Col[j].a_out),.b_out(Row[i].Col[j].b_out),.valid_outa(Row[i].Col[j].valid_outa),.valid_outb(Row[i].Col[j].valid_outb),.sum(C[i][j])); 
                       end
                   end
                   end
              endgenerate
           
endmodule
