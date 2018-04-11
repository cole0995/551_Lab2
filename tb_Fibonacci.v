`timescale 1ns / 1ps

module tb_Fibonacci;

	// Inputs
	reg [6:0] in;
	reg enable;

	// Outputs
	wire [31:0] out;

	// Instantiate the Unit Under Test (UUT)
	Fibonacci uut (
		.in(in), 
		.enable(enable), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 0;
		enable = 0;
		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here
		enable = 1;
		in = 0;
		#10 in = 1;
		#10 in = in + 1;
		#10 in = in + 1;
		#10 in = in + 1;
		#10 in = in + 1;
		#10 in = in + 1;
		#10 in = in + 1;
		#10 in = in + 1;
		#10 in = in + 1;
		#10 in = in + 1;
		#10 in = in + 1;
		#10 in = in + 1;
		#10 in = in + 1;	
		#10 in = in + 1;
		#10 in = in + 1;
		#10 in = in + 1;
		#10 in = in + 1;
		#10 in = in + 1;
		#10 in = in + 1;
		
	end
endmodule

