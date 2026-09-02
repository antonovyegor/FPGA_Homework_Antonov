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
    input wire [3:0] data_in,
    input wire load,
    input wire en,
    input wire up_mode,
    output wire [3:0] q
    );
    reg load_reg;
    reg en_reg;

    reg [3:0] counter_reg;
    
//    assign q = q_reg;
    assign q = counter_reg;

  
    always @( load or  en) begin 
        en_reg <= en;
        load_reg <= load;
    end
    
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            load_reg    <= 1'b0;
            en_reg      <= 1'b0;
            counter_reg <= 4'b0000;
        end
    end 
    
    
    always @(posedge clk) begin 
        if (load_reg) counter_reg = data_in;
    end 
    
    
    always @(posedge clk) begin
        if (en_reg & up_mode & ~load_reg)
            counter_reg = counter_reg + 1;
        if (en_reg & ~up_mode & ~load_reg)
            counter_reg = counter_reg - 1;
    end


    
endmodule
