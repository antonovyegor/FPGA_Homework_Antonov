`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2026 14:24:38
// Design Name: 
// Module Name: mux
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


module mux (
    input wire [3:0] data,
    input wire [1:0] sel,
    input wire en,
    output reg out
    );
    
    always_comb 
    begin
             case (sel)
                2'b00: out = data[0];
                2'b01: out = data[1];
//                2'b10: out = data[2];
                2'b11: out = data[3];
                default : out = 1'bx;
            endcase
    end
endmodule
