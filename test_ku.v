`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:28:10 04/05/2018
// Design Name:   TOP_ku
// Module Name:   X:/Documents/Spring2018/EC551/Lab2_551/test_ku.v
// Project Name:  Lab2_551
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TOP_ku
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_ku;

	// Inputs
	reg clk;
	reg keyboard_clk;
	reg rst;
	reg keyboard_data;

	// Outputs
	wire uart_out;
	wire keyboard_done;
	wire TxD_busy;

	// Instantiate the Unit Under Test (UUT)
	TOP_ku uut (
		.clk(clk), 
		.keyboard_clk(keyboard_clk), 
		.rst(rst), 
		.keyboard_data(keyboard_data), 
		.uart_out(uart_out), 
		.keyboard_done(keyboard_done), 
		.TxD_busy(TxD_busy)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		keyboard_clk = 0;
		rst = 0;
		keyboard_data = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here	

	end
	
	always begin
		#10 clk = ~clk;
	end
	
	always begin 
		#5 keyboard_clk = ~keyboard_clk;
	end
	
	always begin
		#15 keyboard_data = ~keyboard_data;
	end
      
endmodule

