`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name : controller
// Project Name : Parameterised Systolic Array AI Accelerator
// Description : Controls the accelerator operation using an
//               FSM (IDLE -> COMPUTE -> STORE -> DONE).
//////////////////////////////////////////////////////////////////////////////////


module controller#(parameter N = 4)(
  input clk,reset,
  
  // inputs to start and end the program
  input start,store_complete,
  
  output reg scheduler_start,done,store_start
    );
    
    localparam IDLE = 2'b00;
    localparam COMPUTE = 2'b01;
    localparam STORE = 2'b10;
    localparam DONE = 2'b11;
    
    reg [1:0] state;
    reg [31:0] counter;
    
    // tracking the no of cycles
    always@(posedge clk or posedge reset)  begin
          if(reset || ~start) counter<=32'd0;
           else counter<=counter+32'd1;
    end
    
    // changing states and control signal's based on track of cycles
    always@(posedge clk or posedge reset)  begin
        if(reset) begin
                  state<=2'd0;
                  scheduler_start<=1'd0;
                  done<=1'd0;
                  store_start<=1'd0;
                  end
        else  begin
         
            case(state) 
              IDLE : begin
                        if(start) begin
                                   state<=COMPUTE;
                                   scheduler_start<=1'd1;
                                 end
                     end
            COMPUTE : begin 
                    if(counter>=4*N) begin
                                     state<=STORE;
                                     store_start<=1'd1;
                                     scheduler_start<=1'd0;
                                     end
                    end
           STORE : begin
                     if(store_complete) begin 
                        state<=DONE;
                        done<=1'd1;
                        store_start<=1'd0;
                     end
                  end
           DONE : begin
                      if(~start) begin
                      done<=1'd0;
                      state<=IDLE;
                      end
                   end
          default : state<=IDLE;
            endcase
        end
     end
endmodule
