`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////
// Module Name: test_bench
// Project Name:Parameterised Systolic Array AI Accelerator
//////////////////////////////////////////////////////////////////////////////////


module test_bench#(parameter N = 5,parameter DATA_WIDTH = 16,parameter ADD_WIDTH = $clog2(N));

reg clk;
reg reset;
reg start;
 
 // for writing into A buffer
 reg write_enable_a[0:N-1];
 reg [ADD_WIDTH-1:0] write_adrs_a[0:N-1];
 reg [DATA_WIDTH-1:0] write_data_a[0:N-1];
 
 // for writing into B buffer
 reg write_enable_b[0:N-1];
 reg [ADD_WIDTH-1:0] write_adrs_b[0:N-1];
 reg [DATA_WIDTH-1:0] write_data_b[0:N-1];
 
 // output from top module
 wire done;
 
 top top_insta(.clk(clk),.reset(reset),.start(start),.write_enable_a(write_enable_a),.write_adrs_a(write_adrs_a),.write_data_a(write_data_a),.write_enable_b(write_enable_b),.write_adrs_b(write_adrs_b),.write_data_b(write_data_b),.done(done));
 
 integer i;
 initial begin
            clk = 1'd1;
            reset = 1'd1;
            start = 1'd0;
            for(i=0;i<N;i=i+1) begin 
            write_enable_a[i] = 1'd0;
            write_adrs_a[i] = 'd0;
            write_data_a[i] = 'd0;
            write_enable_b[i] = 1'd0;
            write_adrs_b[i] = 'd0;
            write_data_b[i] = 'd0;
            end
          end
   always #5 clk = ~clk; // giving clock
   
   // writng into the input buffers
   initial begin
         #15 reset = 1'd0;
            write_enable_a[0] = 1'd1;
            write_enable_a[1] = 1'd1;
            write_enable_a[2] = 1'd1;
            write_enable_a[3] = 1'd1;
            write_enable_a[4] = 1'd1;
            write_adrs_a[0] = 3'd0;
            write_adrs_a[1] = 3'd0;
            write_adrs_a[2] = 3'd0;
            write_adrs_a[3] = 3'd0;
            write_adrs_a[4] = 3'd0;
            write_data_a[0] = 16'd1;
            write_data_a[1] = 16'd1;
            write_data_a[2] = 16'd1;
            write_data_a[3] = 16'd1;
            write_data_a[4] = 16'd1;
            write_enable_b[0] = 1'd1;
            write_enable_b[1] = 1'd1;
            write_enable_b[2] = 1'd1;
            write_enable_b[3] = 1'd1;
            write_enable_b[4] = 1'd1;
            write_adrs_b[0] = 3'd0;
            write_adrs_b[1] = 3'd0;
            write_adrs_b[2] = 3'd0;
            write_adrs_b[3] = 3'd0;
            write_adrs_b[4] = 3'd0;
            write_data_b[0] = 16'd1;
            write_data_b[1] = 16'd1;
            write_data_b[2] = 16'd1;
            write_data_b[3] = 16'd1;
            write_data_b[4] = 16'd1;
            
         #10 write_enable_a[0] = 1'd1;
            write_enable_a[1] = 1'd1;
            write_enable_a[2] = 1'd1;
            write_enable_a[3] = 1'd1;
            write_enable_a[4] = 1'd1;
            write_adrs_a[0] = 3'd1;
            write_adrs_a[1] = 3'd1;
            write_adrs_a[2] = 3'd1;
            write_adrs_a[3] = 3'd1;
            write_adrs_a[4] = 3'd1;
            write_data_a[0] = 16'd2;
            write_data_a[1] = 16'd2;
            write_data_a[2] = 16'd2;
            write_data_a[3] = 16'd2;
            write_data_a[4] = 16'd2;
            write_enable_b[0] = 1'd1;
            write_enable_b[1] = 1'd1;
            write_enable_b[2] = 1'd1;
            write_enable_b[3] = 1'd1;
            write_enable_b[4] = 1'd1;
            write_adrs_b[0] = 3'd1;
            write_adrs_b[1] = 3'd1;
            write_adrs_b[2] = 3'd1;
            write_adrs_b[3] = 3'd1;
            write_adrs_b[4] = 3'd1;
            write_data_b[0] = 16'd2;
            write_data_b[1] = 16'd2;
            write_data_b[2] = 16'd2;
            write_data_b[3] = 16'd2;
            write_data_b[4] = 16'd2;
            
         #10 write_enable_a[0] = 1'd1;
            write_enable_a[1] = 1'd1;
            write_enable_a[2] = 1'd1;
            write_enable_a[3] = 1'd1;
            write_enable_a[4] = 1'd1;
            write_adrs_a[0] = 3'd2;
            write_adrs_a[1] = 3'd2;
            write_adrs_a[2] = 3'd2;
            write_adrs_a[3] = 3'd2;
            write_adrs_a[4] = 3'd2;
            write_data_a[0] = 16'd3;
            write_data_a[1] = 16'd3;
            write_data_a[2] = 16'd3;
            write_data_a[3] = 16'd3;
            write_data_a[4] = 16'd3;
            write_enable_b[0] = 1'd1;
            write_enable_b[1] = 1'd1;
            write_enable_b[2] = 1'd1;
            write_enable_b[3] = 1'd1;
            write_enable_b[4] = 1'd1;
            write_adrs_b[0] = 3'd2;
            write_adrs_b[1] = 3'd2;
            write_adrs_b[2] = 3'd2;
            write_adrs_b[3] = 3'd2;
            write_adrs_b[4] = 3'd2;
            write_data_b[0] = 16'd3;
            write_data_b[1] = 16'd3;
            write_data_b[2] = 16'd3;
            write_data_b[3] = 16'd3;
            write_data_b[4] = 16'd3;
            
          #10 write_enable_a[0] = 1'd1;
            write_enable_a[1] = 1'd1;
            write_enable_a[2] = 1'd1;
            write_enable_a[3] = 1'd1;
            write_enable_a[4] = 1'd1;
            write_adrs_a[0] = 3'd3;
            write_adrs_a[1] = 3'd3;
            write_adrs_a[2] = 3'd3;
            write_adrs_a[3] = 3'd3;
            write_adrs_a[4] = 3'd3;
            write_data_a[0] = 16'd4;
            write_data_a[1] = 16'd4;
            write_data_a[2] = 16'd4;
            write_data_a[3] = 16'd4;
            write_data_a[4] = 16'd4;
            write_enable_b[0] = 1'd1;
            write_enable_b[1] = 1'd1;
            write_enable_b[2] = 1'd1;
            write_enable_b[3] = 1'd1;
            write_enable_b[4] = 1'd1;
            write_adrs_b[0] = 3'd3;
            write_adrs_b[1] = 3'd3;
            write_adrs_b[2] = 3'd3;
            write_adrs_b[3] = 3'd3;
            write_adrs_b[4] = 3'd3;
            write_data_b[0] = 16'd4;
            write_data_b[1] = 16'd4;
            write_data_b[2] = 16'd4;
            write_data_b[3] = 16'd4;
            write_data_b[4] = 16'd4;
            
           #10 write_enable_a[0] = 1'd1;
            write_enable_a[1] = 1'd1;
            write_enable_a[2] = 1'd1;
            write_enable_a[3] = 1'd1;
            write_enable_a[4] = 1'd1;
           write_adrs_a[0] = 3'd4;
            write_adrs_a[1] = 3'd4;
            write_adrs_a[2] = 3'd4;
            write_adrs_a[3] = 3'd4;
            write_adrs_a[4] = 3'd4;
            write_data_a[0] = 16'd5;
            write_data_a[1] = 16'd5;
            write_data_a[2] = 16'd5;
            write_data_a[3] = 16'd5;
            write_data_a[4] = 16'd5;
            write_enable_b[0] = 1'd1;
            write_enable_b[1] = 1'd1;
            write_enable_b[2] = 1'd1;
            write_enable_b[3] = 1'd1;
            write_enable_b[4] = 1'd1;
            write_adrs_b[0] = 3'd4;
            write_adrs_b[1] = 3'd4;
            write_adrs_b[2] = 3'd4;
            write_adrs_b[3] = 3'd4;
            write_adrs_b[4] = 3'd4;
            write_data_b[0] = 16'd5;
            write_data_b[1] = 16'd5;
            write_data_b[2] = 16'd5;
            write_data_b[3] = 16'd5;
            write_data_b[4] = 16'd5;
            
            
          #10 start = 1'd1;
          wait(done); // waiting till complitaion
          
          // displaying matrix A
          $display("Matrix A");
          $display("%3d %3d %3d %3d %3d",top_insta.a_buffer.mem[0][0],top_insta.a_buffer.mem[0][1],top_insta.a_buffer.mem[0][2],top_insta.a_buffer.mem[0][3],top_insta.a_buffer.mem[0][4]);
          $display("%3d %3d %3d %3d %3d",top_insta.a_buffer.mem[1][0],top_insta.a_buffer.mem[1][1],top_insta.a_buffer.mem[1][2],top_insta.a_buffer.mem[1][3],top_insta.a_buffer.mem[1][4]);
          $display("%3d %3d %3d %3d %3d",top_insta.a_buffer.mem[2][0],top_insta.a_buffer.mem[2][1],top_insta.a_buffer.mem[2][2],top_insta.a_buffer.mem[2][3],top_insta.a_buffer.mem[2][4]);
          $display("%3d %3d %3d %3d %3d",top_insta.a_buffer.mem[3][0],top_insta.a_buffer.mem[3][1],top_insta.a_buffer.mem[3][2],top_insta.a_buffer.mem[3][3],top_insta.a_buffer.mem[3][4]);
          $display("%3d %3d %3d %3d %3d",top_insta.a_buffer.mem[4][0],top_insta.a_buffer.mem[4][1],top_insta.a_buffer.mem[4][2],top_insta.a_buffer.mem[4][3],top_insta.a_buffer.mem[4][4]);
          
          // displaying matrix B
          $display("Matrix B");
           $display("%3d %3d %3d %3d %3d",top_insta.b_buffer.mem[0][0],top_insta.b_buffer.mem[1][0],top_insta.b_buffer.mem[2][0],top_insta.b_buffer.mem[3][0],top_insta.b_buffer.mem[4][0]);
          $display("%3d %3d %3d %3d %3d",top_insta.b_buffer.mem[0][1],top_insta.b_buffer.mem[1][1],top_insta.b_buffer.mem[2][1],top_insta.b_buffer.mem[3][1],top_insta.b_buffer.mem[4][1]);
          $display("%3d %3d %3d %3d %3d",top_insta.b_buffer.mem[0][2],top_insta.b_buffer.mem[1][2],top_insta.b_buffer.mem[2][2],top_insta.b_buffer.mem[3][2],top_insta.b_buffer.mem[4][2]);
          $display("%3d %3d %3d %3d %3d",top_insta.b_buffer.mem[0][3],top_insta.b_buffer.mem[1][3],top_insta.b_buffer.mem[2][3],top_insta.b_buffer.mem[3][3],top_insta.b_buffer.mem[4][3]);
          $display("%3d %3d %3d %3d %3d",top_insta.b_buffer.mem[0][4],top_insta.b_buffer.mem[1][4],top_insta.b_buffer.mem[2][4],top_insta.b_buffer.mem[3][4],top_insta.b_buffer.mem[4][4]);
          
          // displaying matrix c
          $display("Matrix C = A*B");
          $display("%3d %3d %3d %3d %3d",top_insta.output_buffer_insta.result_matrix[0][0],top_insta.output_buffer_insta.result_matrix[0][1],top_insta.output_buffer_insta.result_matrix[0][2],top_insta.output_buffer_insta.result_matrix[0][3],top_insta.output_buffer_insta.result_matrix[0][4]);
          $display("%3d %3d %3d %3d %3d",top_insta.output_buffer_insta.result_matrix[1][0],top_insta.output_buffer_insta.result_matrix[1][1],top_insta.output_buffer_insta.result_matrix[1][2],top_insta.output_buffer_insta.result_matrix[1][3],top_insta.output_buffer_insta.result_matrix[1][4]);
          $display("%3d %3d %3d %3d %3d",top_insta.output_buffer_insta.result_matrix[2][0],top_insta.output_buffer_insta.result_matrix[2][1],top_insta.output_buffer_insta.result_matrix[2][2],top_insta.output_buffer_insta.result_matrix[2][3],top_insta.output_buffer_insta.result_matrix[2][4]);
          $display("%3d %3d %3d %3d %3d",top_insta.output_buffer_insta.result_matrix[3][0],top_insta.output_buffer_insta.result_matrix[3][1],top_insta.output_buffer_insta.result_matrix[3][2],top_insta.output_buffer_insta.result_matrix[3][3],top_insta.output_buffer_insta.result_matrix[3][4]);
          $display("%3d %3d %3d %3d %3d",top_insta.output_buffer_insta.result_matrix[4][0],top_insta.output_buffer_insta.result_matrix[4][1],top_insta.output_buffer_insta.result_matrix[4][2],top_insta.output_buffer_insta.result_matrix[4][3],top_insta.output_buffer_insta.result_matrix[4][4]);
          #10 start = 1'd0;
          end
endmodule
