`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2026 11:33:54
// Design Name: 
// Module Name: top_tb
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


module top_tb;

    // Inputs
    reg [7:0] sw;
    reg btn0;
    reg btn1;
    reg clk;
    
    // Outputs
    wire TxD;
    wire TxD_debug;
    wire transmit_debug;
    wire button_debug;
    wire clk_debug;
    
    // Instantiate the top module
    top uut (
        .sw(sw),
        .btn0(btn0),
        .btn1(btn1),
        .clk(clk),
        .TxD(TxD),
        .TxD_debug(TxD_debug),
        .transmit_debug(transmit_debug),
        .button_debug(button_debug),
        .clk_debug(clk_debug)
    );
    
    // Clock generation: 100MHz (10ns period)
    initial clk = 0;
    always #5 clk = ~clk;
    
    // Test stimulus
    initial begin
        // Initialize inputs
        sw = 8'h00;
        btn0 = 0;
        btn1 = 0;
        
        // Display start message
        $display("========================================");
        $display("UART Testbench Started");
        $display("========================================\n");
        
        // Apply reset
        $display("Time %0t ns: Applying Reset", $time);
        btn0 = 1;
        #100;
        btn0 = 0;
        #100;
        
        // Test 1: Transmit 0xAA
        $display("\nTest 1: Transmitting 0xAA");
        sw = 8'hAA;
        #1000;
        btn1 = 1;  // Press button
        #2000000;  // Hold for 2ms (> 100000 clocks * 10ns = 1ms debounce time)
        btn1 = 0;  // Release button
        #15000000; // Wait for transmission to complete (~10 bits * 10416 * 10ns = ~1ms)
        
        // Test 2: Transmit 0x55
        $display("\nTest 2: Transmitting 0x55");
        sw = 8'h55;
        #1000;
        btn1 = 1;
        #2000000;
        btn1 = 0;
        #15000000;
        
        // Test 3: Transmit 0x00
        $display("\nTest 3: Transmitting 0x00");
        sw = 8'h00;
        #1000;
        btn1 = 1;
        #2000000;
        btn1 = 0;
        #15000000;
        
        // Test 4: Transmit 0xFF
        $display("\nTest 4: Transmitting 0xFF");
        sw = 8'hFF;
        #1000;
        btn1 = 1;
        #2000000;
        btn1 = 0;
        #15000000;
        
        // End simulation
        $display("\n========================================");
        $display("All Tests Completed");
        $display("========================================");
        $finish;
    end
    
    // Monitor outputs
    initial begin
        $monitor("Time=%0t ns | sw=%h | btn1=%b | transmit=%b | TxD=%b", 
                 $time, sw, btn1, transmit_debug, TxD);
    end
    
    // Generate waveform dump
    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);
    end

endmodule