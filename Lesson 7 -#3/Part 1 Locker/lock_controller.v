`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.09.2026 20:16:46
// Design Name: 
// Module Name: lock_controller
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


module lock_controller(
    input wire [3:0] digit_in,
    input wire clk,
    input wire rst,
    output reg unlocked_led
    );
    
    reg [1:0] state;
    reg [1:0] next_state;
    
    reg [3:0] last_digit_pressed_sync_0;
    reg [3:0] last_digit_pressed_sync_1;

    reg [15:0] counter;
    reg [3:0] digit_out;
    
       always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter = 0 ;
            digit_out = 0 ;
            last_digit_pressed_sync_0 = 0 ;
            last_digit_pressed_sync_1 = 0 ; 
            
        end
        
    end
  
  
  
    always @(posedge clk) begin 
        last_digit_pressed_sync_0 = digit_in;
        last_digit_pressed_sync_1 = last_digit_pressed_sync_0;
    end 
    
    always @(posedge clk) begin 
        if (last_digit_pressed_sync_1 == digit_out) begin
            // начебто нічого робити не потрібно стан регістра лишається 
            counter = 0;
        end else begin 
            counter = counter + 1;
            if (counter == 16'd20) begin 
                digit_out = last_digit_pressed_sync_1;
                counter = 0;
            end 
        end 
        
        
    end 
    
    
    localparam [11:0] DIGIT_CODE = (4'd5 << 8) | (4'd3 << 4) | (4'd7);
    
    localparam [1:0] LOCKED     = 2'b00;
    localparam [1:0] D1_SUCCESS = 2'b01;
    localparam [1:0] D2_SUCCESS = 2'b10;
    localparam [1:0] D3_SUCCESS = 2'b11;

    wire [3:0] digit1, digit2, digit3;

    assign digit1 = (DIGIT_CODE >> 8) & 4'b1111;  // Тепер це працюватиме
    assign digit2 = (DIGIT_CODE >> 4) & 4'b1111;
    assign digit3 = DIGIT_CODE & 4'b1111;
       
    always @(posedge clk or posedge rst) begin
        if (rst) state <= LOCKED;
        else state <= next_state;
    end
   
   
   always @(digit_out) begin 
        next_state = state;
        case (state) 
            LOCKED: begin 
                if (digit_out == digit1) begin
                    next_state = D1_SUCCESS;
                end else next_state = LOCKED;
            end 
            D1_SUCCESS : begin
                if (digit_out == digit2) begin
                    next_state = D2_SUCCESS;
                end else next_state = LOCKED;
            end 
            D2_SUCCESS : begin
                if (digit_out == digit3) begin
                    next_state = D3_SUCCESS;
                end else next_state = LOCKED;  
            end
            D3_SUCCESS : begin
                next_state = D3_SUCCESS;
            end
            default : begin
                next_state = LOCKED; 
            end
         endcase       
   end
  
  
    always @(*) begin
        unlocked_led = (state == D3_SUCCESS);
    end
    
        
endmodule
