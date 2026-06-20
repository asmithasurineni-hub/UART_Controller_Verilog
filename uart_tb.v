`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 14:12:19
// Design Name: 
// Module Name: uart_tb
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


module uart_tb();

reg clk;
reg rst;
reg tx_start;
reg [7:0] data_in;

wire [7:0] data_out;
wire data_valid;

uart_top DUT(
.clk(clk),
.rst(rst),
.tx_start(tx_start),
.data_in(data_in),
.data_out(data_out),
.data_valid(data_valid)
);

always #10 clk = ~clk;

initial
begin
clk = 0;
rst = 1;
tx_start = 0;
data_in = 0;


#100;

rst = 0;

data_in = 8'b10110010;

tx_start = 1;
#20;
tx_start = 0;

#2000000;

if(data_out == data_in)
    $display("TEST PASSED");
else
    $display("TEST FAILED");

#100;
$finish;


end

endmodule


