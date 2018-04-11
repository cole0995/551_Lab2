
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:46:09 04/10/2018
// Design Name:   cpu
// Module Name:   X:/Documents/Spring2018/EC551/Lab2_551/tb_cpu.v
// Project Name:  Lab2_551
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_cpu;

	// Inputs
	reg rst;
	reg clk;
	reg [31:0] next_instruction;
	reg start;
	reg mem_write;

	// Outputs
	wire [3:0] count;

	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.rst(rst), 
		.clk(clk), 
		.next_instruction(next_instruction), 
		.count(count), 
		.start(start),
		.mem_write(mem_write)
	);

	initial begin
		// Initialize Inputs
		rst = 0;
		clk = 0;
		next_instruction = 0;
		start = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		rst = 0;
		next_instruction = 32'b000000_00000_00010_00001_00000_10_0000;      // ADD R1, R0, R2
		mem_write = 1;
		#10
		mem_write = 0;
		#30;
		next_instruction = 32'b000000_00100_00100_01000_00000_10_0010;      // SUB R8, R4, R4
		mem_write = 1;
		#10
		mem_write = 0;
		#30;
		next_instruction = 32'b000000_00101_00110_00111_00000_10_0101;      // OR R5, R6, 7
		mem_write = 1;
		#10
		mem_write = 0;
		#30;
		next_instruction = 32'b101011_00000_01001_00000_00000_00_1100;      // SW R9, 12(R0)
		mem_write = 1;
		#10
		mem_write = 0;
		#30;
		next_instruction = 32'b100011_00000_01100_00000_00000_00_1100;      // LW R12, 12(R0)
		mem_write = 1;
		#10
		mem_write = 0;
		#30;	
		next_instruction = 32'b000000_01001_01010_01001_00000_10_0000;		 // ADD R9, R9, R10
		mem_write = 1;
		#10
		mem_write = 0;
		#30;
		start = 1;
		rst=1;
		#10 rst=0;
		start = 0;
		
	end
	
	always begin
		#5 clk = ~clk;
	end
      
endmodule

