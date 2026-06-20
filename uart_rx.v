`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 12:06:25
// Design Name: 
// Module Name: uart_rx
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


module uart_rx(input clk,rst,rx,baud_tick,
output reg[7:0]data_out,
output reg data_valid,
output reg parity_error,
output reg framing_error);

localparam IDLE   = 3'b000,
           START  = 3'b001,
           DATA   = 3'b010,
           PARITY = 3'b011,
           STOP   = 3'b100;
reg [2:0]state;
reg received_parity;
reg [7:0]shift_reg;
reg [2:0]bit_count;
reg calculated_parity;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
    state<=IDLE;
    bit_count <= 0;
    data_valid <= 0;
    data_out <= 8'b0;
    parity_error <= 0;
    framing_error <= 0;
    end
    else
    begin
    
     case(state)
      IDLE:
       begin
       data_valid <= 0;
       parity_error <= 0;
       framing_error <= 0;
       if(rx == 0)
        state <= START;
       end
       
      START:
       begin
       if(baud_tick)
       begin
        bit_count <= 0;
        state <= DATA;
       end
       end 
       
      DATA:
       begin
       if(baud_tick)
       begin
        shift_reg[bit_count] <= rx;
        if(bit_count == 7)
            state <= PARITY;
        else
            bit_count <= bit_count + 1;
       end
       end
    
     PARITY:
      begin
      if(baud_tick)
      begin
        received_parity <= rx;
        state <= STOP;
      end
      end
    
     STOP:
   begin
    if(baud_tick)
    begin

        if(received_parity != (^shift_reg))
            parity_error <= 1;
        else
            parity_error <= 0;

        if(rx != 0)
            framing_error <= 1;
        else
            framing_error <= 0;

        data_out <= shift_reg;
        data_valid <= 1;
        state <= IDLE;
    end
   end
   endcase
end
end
endmodule
