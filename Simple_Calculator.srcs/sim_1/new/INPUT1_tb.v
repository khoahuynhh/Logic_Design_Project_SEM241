`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2024 09:51:15 AM
// Design Name: 
// Module Name: INPUT1_tb
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

module INPUT1_tb;

    // Inputs
    reg clk;
    reg reset;
    reg enable_m;
    reg [3:0] rows;
    reg [3:0] cols;
    reg [15:0] numberInput;

    // Outputs
    wire [3:0] led_0;
    wire [3:0] led_1;
    wire [3:0] led_2;
    wire [3:0] led_3;
    wire [3:0] thousands;
    wire [3:0] hundreds;
    wire [3:0] tens;
    wire [3:0] ones;
    wire [15:0] output_data;

    // Instantiate the Unit Under Test (UUT)
    INPUT1 uut (
        .clk(clk), 
        .reset(reset), 
        .enable_m(enable_m),
        .rows(rows), 
        .cols(cols), 
        .thous(thousands),
        .hund(hundreds),
        .t(tens),
        .o(ones),
        .numberInput(numberInput),
        .led_0(led_0),
        .led_1(led_1),
        .led_2(led_2),
        .led_3(led_3),
        .thousands(thousands),
        .hundreds(hundreds),
        .tens(tens),
        .ones(ones),
        .output_data(output_data)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        enable_m = 0;
        rows = 4'b0000;
        cols = 4'b0000;
        numberInput = 16'b0;

        // Wait for 10 ns for global reset to finish
        #10;
        reset = 0; // Release reset

        // Enable the module
        enable_m = 1;

        // Test Case 1: Input at row 0
        rows = 4'b0001; cols = 4'b1010; #10;
        $display("Output data after row 0: %b", output_data);

        // Test Case 2: Input at row 1
        rows = 4'b0010; cols = 4'b0101; #10;
        $display("Output data after row 1: %b", output_data);

        // Test Case 3: Input at row 2
        rows = 4'b0100; cols = 4'b1111; #10;
        $display("Output data after row 2: %b", output_data);

        // Test Case 4: Input at row 3
        rows = 4'b1000; cols = 4'b0000; #10;
        $display("Output data after row 3: %b", output_data);

        // Check for continuous entry after all 4 bits are entered
        rows = 4'b0001; cols = 4'b1100; #10;
        $display("Output data after second round row 0: %b", output_data);

        // Reset the module
        reset = 1; #10; reset = 0;
        $display("Output data after reset: %b", output_data);

        // Finish simulation
        $finish;
    end

endmodule








