`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.08.2026 14:18:11
// Design Name: 
// Module Name: decoder
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

module decoder #(parameter [7:0]w = 4 )
(
    input wire [$clog2(w)-1:0] in,
    output wire [w-1:0] out
);

    // Зсуваємо одиницю на кількість бітів, що дорівнює вхідному значенню
    assign out = 1'b1 << in;
    
    
    
endmodule