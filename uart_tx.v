`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2026 15:22:41
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(
    input clk,
    input rst,
    input tx_start,
    input baud_tick,
    input [7:0] data_in,

    output reg tx,
    output reg tx_done
);

localparam IDLE   = 3'b000,
           START  = 3'b001,
           DATA   = 3'b010,
           PARITY = 3'b011,
           STOP   = 3'b100;
           
reg [2:0] state;
reg [7:0] shift_reg;
reg [2:0] bit_count;
reg parity_bit;

always @(posedge clk or posedge rst)
begin
  if(rst)
   begin
    state <= IDLE;
    tx <= 1'b1;
    tx_done <= 1'b0;
    bit_count <= 3'd0;
   end
  else
   begin
    case(state)
      IDLE:
        begin
         tx <= 1'b1;
         tx_done <= 1'b0;
         if(tx_start)
         begin
         shift_reg <= data_in;
         parity_bit <= ^data_in;
         bit_count <= 0;
         state <= START;
         end
        end
        
      START:
        begin
        tx <= 1'b0;
        if(baud_tick)
        state <= DATA;
        end 
         
      DATA:
       begin
        tx <= shift_reg[bit_count];

        if(baud_tick)
         begin
         if(bit_count == 7)
            state <= PARITY;
         else
            bit_count <= bit_count + 1;
         end
        end
        
       PARITY:
        begin
         tx <= parity_bit;
         if(baud_tick)
         state <= STOP;
        end 
        
       STOP:
        begin
         tx <= 1'b1;
         if(baud_tick)
         begin
         tx_done <= 1'b1;
         state <= IDLE;
         end
        end 
    endcase

  end
end
endmodule           
