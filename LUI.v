`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:23:00 10/31/2016 
// Design Name: 
// Module Name:    LUI 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LUI(upper_immediate, immediate);

	output [31:0] upper_immediate;
	
	input [31:0] immediate;
	
	assign upper_immediate[31:16] = immediate[15:0];
	assign upper_immediate[15:0] = 16'b0;

endmodule
