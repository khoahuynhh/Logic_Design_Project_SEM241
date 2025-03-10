`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2024 09:59:29
// Design Name: 
// Module Name: bin_to_hex_4bit_tb
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


module BCH_tb_1;

  reg [15:0] numberInput;
  wire [3:0] hex0;
  wire [3:0] hex1;
  wire [3:0] hex2;
  wire [3:0] hex3;

  // Instantiate the module under test
  BCH bch_converter (
    .numberInput(numberInput),
    .hex0(hex0),
    .hex1(hex1),
    .hex2(hex2),
    .hex3(hex3)
  );

  initial begin
    // Display header
    $display("BCH Input          | BCH Output");
    $display("-------------------|-------------");

    numberInput = 16'b0000000000000000; //0
    #10
    $display("%b | %h%h%h%h", numberInput, hex3, hex2, hex1, hex0);

    numberInput = 16'b0011000000111001; //12345
    #10
    $display("%b | %h%h%h%h", numberInput, hex3, hex2, hex1, hex0);

    numberInput = 16'b1111111111111111; //65535
    #10
    $display("%b | %h%h%h%h", numberInput, hex3, hex2, hex1, hex0);
  
    numberInput = 16'b1010101010101010; //43690
    #10
    $display("%b | %h%h%h%h", numberInput, hex3, hex2, hex1, hex0);

    // Finish the simulation
    $finish;
  end

endmodule

