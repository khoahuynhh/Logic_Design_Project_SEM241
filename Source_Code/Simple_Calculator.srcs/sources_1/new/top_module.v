`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2024 09:42:50 PM
// Design Name: 
// Module Name: top_module
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

module top_module(
    input clk,
    input reset,
    input enable,
    input [7:0] sw,
    input [3:0] but,
    output [3:0] led_0,
    output [3:0] led_1,
    output [3:0] led_2,
    output [3:0] led_3
    );
    
    reg [15:0] output_data;
    reg [15:0] a;
    reg [15:0] b;
    reg [15:0] sum; 
    reg [15:0] mul;   
    reg [15:0] sub;
    reg [15:0] and_result;
    reg [15:0] modul;
    reg [15:0] div_result;
    reg [15:0] ans;
    reg [15:0] res;
    wire [15:0] input_data_BCD;
    wire [3:0] thousands_temp;
    wire [3:0] hundreds_temp;
    wire [3:0] tens_temp;
    wire [3:0] ones_temp;
    wire [3:0] but_debounce;
    reg [3:0] but_prev;
    integer count;
    reg done;
    
    debounce_but uut(
        .reset(reset),
        .clk(clk),
        .button_in(but),
        .button_out(but_debounce)
    );
    
    always @( posedge clk or posedge reset) begin
        if(reset) begin
            output_data <= 16'b0;
            count <= 4'b0;
            done <= 1'b0;
            but_prev <= 3'b0; 
            a <= 16'b0;
            b <= 16'b0;
            sum <= 16'b0;
            mul <= 16'b0;
            and_result <= 16'b0;
            sub <= 16'b0;
            modul <= 16'b0;
            div_result <= 16'b0;
            ans <= 16'b0;
            res <= 16'b0;
        end else if(but_debounce[0] && !but_prev[0] && count < 16) begin
            output_data <= {output_data[14:0], 1'b0};
            count <= count + 1;
        end else if(but_debounce[1] && !but_prev[1] && count < 16) begin
            output_data[count] <= 1'b1;
            count <= count + 1;
        end else if(but_debounce[2] && !but_prev[2]) begin
            if(sw[6:0] == 7'b1000000) begin
            a <= ans;
            end else begin
            a <= output_data;
            end
            output_data <= 16'b0;
            count <= 4'b0;
            done <= 1'b1;
        end else if (but_debounce[3] && !but_prev[3]) begin
            if(sw[6:0] == 7'b1000000) begin
                b <= ans;
            end else begin
            b <= output_data;
            end
            output_data <= 16'b0;
            count <= 4'b0;
            done <= 1'b1;
        end else if (done) begin
            sum <= a + b;
            mul <= a * b;
            if(a > b) begin
                sub <= a - b;
            end else begin
                sub <= ~(a - b) + 1;
        end
            modul <= a % b;
            and_result <= a & b;
            div_result <= (b != 0) ? a / b : 16'b0;
                  case (sw[6:0])
                                   7'b0000001: begin 
                                              res <= sum;
                                              ans <= res;
                                              end
                                   7'b0000010: begin 
                                              res <= sub;
                                              ans <= res;
                                              end
                                   7'b0000100: begin
                                               res <= mul;
                                               ans <= res;
                                               end
                                   7'b0001000: begin
                                               res <= div_result;
                                               ans <= res;
                                               end
                                   7'b0010000: begin
                                               res <= modul;
                                               ans <= res;
                                               end
                                   7'b0100000: 
                                               begin
                                               res <= and_result;
                                               ans <= res;
                                               end
                                   default:
                                            res <= 16'b0;
                  endcase
        done <= 1'b1;
        end else begin
            done <= 1'b1;
        end
    but_prev <= but_debounce;
    end
    
    assign input_data_BCD = (sw[6:0] == 7'b0000001) ? sum :
                                (sw[6:0] == 7'b0000010) ? sub :
                                (sw[6:0] == 7'b0000100) ? mul :
                                (sw[6:0] == 7'b0001000) ? div_result :
                                (sw[6:0] == 7'b0010000) ? modul :
                                (sw[6:0] == 7'b0100000) ? and_result :
                                (sw[6:0] == 7'b1000000) ? ans :
                                output_data;
    
    BCD uut1(
        .numberInput(input_data_BCD),
        .thousands(thousands_temp),
        .hundreds(hundreds_temp),
        .tens(tens_temp),
        .ones(ones_temp)
    );
    
    hex2led7 uut2(
        .enable(done),
        .thous(thousands_temp),
        .hund(hundreds_temp),
        .t(tens_temp),
        .o(ones_temp),
        .led_0(led_0),
        .led_1(led_1),
        .led_2(led_2),
        .led_3(led_3)
    );
    
endmodule
