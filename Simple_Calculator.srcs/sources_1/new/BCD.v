`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2024 05:01:10 PM
// Design Name: 
// Module Name: BCD
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

module BCD(
    input wire [15:0] numberInput,
    output reg [3:0] thousands, hundreds, tens, ones
);

    integer i;

always @ (numberInput) begin
	thousands = 4'b0000;
	hundreds = 4'b0000;
	tens = 4'b0000;
	ones = 4'b0000;
	
	for (i = 15; i >= 0; i = i-1) begin
		if(thousands >= 5) begin
			thousands = thousands + 4'd3;
		end
		if(hundreds >= 5) begin
			hundreds = hundreds + 4'd3;
		end
		if(tens >= 5) begin
			tens = tens + 4'd3;
		end
		if(ones >= 5) begin
			ones = ones + 4'd3;
		end
		
		thousands = thousands << 1;
		thousands[0] = hundreds[3];
		hundreds = hundreds << 1;
		hundreds[0] = tens[3];
		tens = tens << 1;
		tens[0] = ones[3];
		ones = ones << 1;
		ones[0] = numberInput[i];
		end	
end
endmodule