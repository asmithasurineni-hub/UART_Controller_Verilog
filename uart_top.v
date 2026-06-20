`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 13:39:16
// Design Name: 
// Module Name: uart_top
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


module uart_top(
    input clk,
    input rst,
    input tx_start,
    input [7:0] data_in,

    output [7:0] data_out,
    output data_valid
);
wire baud_tick;
wire tx_line;
wire tx_done;
wire parity_error;
baud_gen BAUD(
    .clk(clk),
    .rst(rst),
    .baud_tick(baud_tick)
);
uart_tx TX(
    .clk(clk),
    .rst(rst),
    .tx_start(tx_start),
    .baud_tick(baud_tick),
    .data_in(data_in),

    .tx(tx_line),
    .tx_done(tx_done)
);
uart_rx RX(
    .clk(clk),
    .rst(rst),
    .baud_tick(baud_tick),
    .rx(tx_line),

    .data_out(data_out),
    .data_valid(data_valid)
);
endmodule