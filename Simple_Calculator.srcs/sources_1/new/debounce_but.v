`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2024 10:35:54 PM
// Design Name: 
// Module Name: debounce_but
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


module debounce_but(
    input wire reset,
    input wire clk,
    input wire [3:0] button_in,
    output reg [3:0] button_out
    );
    
    reg [19:0] counter [2:0];
    reg [3:0] button_sync;
    integer i;
    
    always @(posedge clk) begin
        if(reset) begin
            button_sync <= 4'b0000;
            counter[0] <= 20'b0;
            counter[1] <= 20'b0;
            counter[2] <= 20'b0;
        end else
            for (i = 0; i < 4; i = i + 1) begin
                if(button_in[i] != button_sync[i]) begin
                    button_sync[i] <= button_in[i];
                    counter[i] <= 20'd1_000_000;
                end else if (counter[i] > 0) begin
                    counter[i] <= counter[i] - 1;
                end else begin
                    button_out[i] <= button_sync[i];
                end
            end
        end 
endmodule
