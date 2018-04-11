`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:41:11 04/09/2018
// Design Name:   alu_interface
// Module Name:   X:/Documents/Spring2018/EC551/Lab2_551/test_alumode2.v
// Project Name:  Lab2_551
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu_interface
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_alumode2;

	// Inputs
	reg [23:0] input_word;
	reg enable;

	// Outputs
	wire [15:0] output_ascii;

	// Instantiate the Unit Under Test (UUT)
	alu_interface uut (
		.input_word(input_word),
		.enable(enable),
		.output_ascii(output_ascii)
	);

	initial begin
		// Initialize Inputs
		input_word = 0;
		enable = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#10 enable = 1;
		input_word = 24'b00111101_01010101_00101110;
		#10 input_word = 24'b00111101_01001110_00101110;
		#10 input_word = 24'b00111101_01000001_00101110;
		#10 input_word = 24'b00111101_00001110_00101110;

	end
	
	
	
	
      
endmodule

