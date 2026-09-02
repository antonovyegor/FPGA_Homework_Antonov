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
    
    reg clk;
    reg rst;
    reg [3:0] data_load;
    reg load;
    reg en;
    reg up_mode;
    wire [3:0] q; 
    // 3. Підключення вашого модуля
    counter my_counter_inst (
        .clk(clk),
        .rst(rst),
        .data_in(data_load),
        .load(load),
        .en(en),
        .up_mode(up_mode),
        .q(q)
    );
    
       
    task automatic check_value(
        input  [3:0] actual, 
        input  [3:0] expected
    );
        if (actual === expected) begin
            $display("PASS: count is %0d (value = %0d) AUTO", expected, actual);
        end else begin
            $display("FAIL: expected count to be %0d, got %0d AUTO", expected, actual);
        end
    endtask
    
    // Генерація годинника
    always #10 clk = ~clk;

    // Сценарій симуляції
    initial begin
    
        clk = 0;
        rst = 0;
        data_load = 4'd0;
        en = 0;
        load = 0 ;
        up_mode = 0 ; 
        
        
        #1 rst = 1;  // Вмикаємо скидання
        @(posedge clk) #1 rst = 0;  // Вимикаємо скидання, починається лічба
        
        #67 
        
        data_load = 4'd10;
        load = 1 ;
        @(posedge clk) #1;
        load = 0 ;
        
        check_value(q,10);
        
//        if (q === 10) 
//            $display("PASS: count is 10 (value = %0d)", q);
//        else 
//            $display("FAIL: expected count to be 10, got %0d", q);

        #100 en=1; up_mode=1;
        
        
        @(posedge clk); #1;
        @(posedge clk); #1;
        @(posedge clk); #1;
        
         check_value(q,13);
//        if (q === 13) 
//            $display("PASS: count is 13 (value = %0d)", q);
//        else 
//            $display("FAIL: expected count to be 13 , got %0d", q);
        
    
        @(posedge clk); #1;
        @(posedge clk); #1;
        @(posedge clk); #1;

        
        check_value(q,0);

//        if (q === 0) 
//        $display("PASS: count is 0 (value = %0d)", q);
//        else 
//        $display("FAIL: expected count to be 0, got %0d", q);
        
            
         en=0;
         
         @(posedge clk); #1;
         @(posedge clk); #1;
         @(posedge clk); #1;
         
        if (q === 0) 
        $display("PASS: count is 0 (value = %0d)", q);
        else 
        $display("FAIL: expected count to be 0, got %0d", q);
         
         
         
         en=1; up_mode = 0 ;
         
         @(posedge clk); #1;
     
            
        if (q === 15) 
        $display("PASS: count is 15 (value = %0d)", q);
        else 
        $display("FAIL: expected count to be 15, got %0d", q);
        
        en=1;
        up_mode=1;
        load=1;
        data_load=5;
       
        @(posedge clk); #1;
 
        if (q === 5)                                         
        $display("PASS: count is 5 (value = %0d)", q);       
        else                                                  
        $display("FAIL: expected count to be 5, got %0d", q);
        
        
        #2000 $finish;
    end
    

endmodule