`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2024 09:51:13 AM
// Design Name: 
// Module Name: Simple_Calculator
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


module hex2led7(
    input wire enable, //assign for SW1
    input wire [3:0] thous,
    input wire [3:0] hund,
    input wire [3:0] t,
    input wire [3:0] o,
    output reg [3:0] led_0,
    output reg [3:0] led_1,
    output reg [3:0] led_2,
    output reg [3:0] led_3
);

always @* begin
    if (enable) begin
	led_0 = o;
	led_1 = t;
	led_2 = hund;
	led_3 = thous;
	end else begin
	led_0 = 4'b0000;
	led_1 = 4'b0000;
	led_2 = 4'b0000;
	led_3 = 4'b0000;
	end
end
endmodule
