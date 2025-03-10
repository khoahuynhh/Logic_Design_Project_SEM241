`timescale 1ns / 1ps

module hex2led7_tb;

reg enable;
reg [15:0] hex_in;
wire [6:0] led_out;

hex2led7 dut(
    .enable(enable),
    .hex_in(hex_in),
    .led_out(led_out)
);

initial begin
    $monitor("Time=%0t, enable=%b, hex_in=%b, led_out=%b", $time, enable, hex_in, led_out);
    
    enable = 1;
    hex_in = 16'b0000000000000000;
    #10;
    // (5)
    hex_in = 16'b0000000000000101;
    #10;  
    //(9)
    hex_in = 16'b0000000000001001;
    #10;
    
    enable = 0;
    #10;
    //off
    enable = 1;
    hex_in = 16'b0000000000001111;
    #10;
    $finish;
end

endmodule
