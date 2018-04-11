`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:39:18 04/09/2018
// Design Name:   initmessage
// Module Name:   X:/Documents/Spring2018/EC551/Lab2_551/testmessage.v
// Project Name:  Lab2_551
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: initmessage
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testmessage;

	// Inputs
	reg clk;

	// Outputs
	wire uart_out;
	wire TxD_busy;

	// Instantiate the Unit Under Test (UUT)
	initmessage uut (
		.clk(clk), 
		.uart_out(uart_out), 
		.TxD_busy(TxD_busy)
	);

	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
		#25 clk = ~clk;
	end
      
endmodule

