`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.08.2026 14:18:11
// Design Name: 
// Module Name: counter
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


module counter(
    input wire clk,
    input wire rst,
    output reg [3:0] q
    );
    
    always @(posedge clk or posedge rst) begin
        if (rst == 1) 
             q <= 4'b0000;
        else
            q <= q + 1;
        
    end
    
//    always @(posedge rst) begin
//        q <= 4'b0000;
//    end
    
endmodule
