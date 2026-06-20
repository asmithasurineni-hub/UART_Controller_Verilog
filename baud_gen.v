`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2026 15:45:45
// Design Name: 
// Module Name: baud_gen
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


module baud_gen(
    input clk,
    input rst,
    output reg baud_tick
);
reg [12:0] count;
always @(posedge clk or posedge rst)
begin
 if(rst)
 begin
    count <= 0;
    baud_tick <= 0;
 end
 else
 begin
  if(count==5207)
   begin
   count<=0;
   baud_tick<=1;
   end
  else
  begin
   count<=count+1;
   baud_tick<=0;
  end  
 end  
 
end
endmodule
