`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name : pe
// Project Name : Parameterised Systolic Array AI Accelerator
// Description : Performs multiply-accumulate (MAC) operation
//               and forwards operands to neighboring PEs.
////////////////////////////////////////////////////////////////////////////////

module pe #(parameter DATA_WIDTH = 8,
            parameter ACC_WIDTH = 32)(
          input clk,
          input reset,
          
          // data and valid inputs
          input [DATA_WIDTH-1:0] a_in,b_in,
          input valid_ina,valid_inb,
          
          // data and valid passing
          output reg [DATA_WIDTH-1:0] a_out,b_out,
          output reg valid_outa,valid_outb,
          

          output reg [ACC_WIDTH-1:0] sum
    );
    
   
    always@(posedge clk or posedge reset)
      begin
        if(reset) begin
                    sum<='d0;
                    a_out<='d0;
                    b_out<='d0;
                    valid_outa<=1'd0;
                    valid_outb<=1'd0;
                   end
        else if(valid_ina && valid_inb) begin
                      a_out<=a_in;
                      sum<=sum+a_in*b_in;
                      b_out<=b_in;
                      valid_outa<=valid_ina;
                      valid_outb<=valid_inb;
                 end
        else begin
           valid_outa<=1'd0;
           valid_outb<=1'd0;
             end
      end
endmodule
