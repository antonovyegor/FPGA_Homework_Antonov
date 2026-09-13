`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2026 12:50:56
// Design Name: 
// Module Name: 
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




module testbench;
    
    reg clk_tb;
    reg rst_tb;
    reg [3:0] digit_in_tb;
    wire led;
    lock_controller my_lock (
    .clk(clk_tb),
    .rst(rst_tb),
    .digit_in(digit_in_tb),
    .unlocked_led (led)
    );
    
    always #10 clk_tb = ~clk_tb;
    
    initial begin
         clk_tb = 0 ; rst_tb = 0 ;
         digit_in_tb = 0 ;
         
         
         #1 rst_tb = 1;  // Вмикаємо скидання
        @(posedge clk_tb) #1 rst_tb = 0;  // Вимикаємо скидання, починається лічба
        
        #10 digit_in_tb = 5;
        #12 digit_in_tb = 8;
        #25 digit_in_tb = 1;
        #60 digit_in_tb = 9;
        #25 digit_in_tb = 2;
        #500 digit_in_tb = 5;

        #500 digit_in_tb = 4; 
        #500 digit_in_tb = 7; 
        
        
        #500 $finish;
    end
    

endmodule    