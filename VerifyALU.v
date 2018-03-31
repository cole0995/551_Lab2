`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:00:05 10/20/2016 
// Design Name: 
// Module Name:    VerifyALU 
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
module VerifyALU(dataout,a,b,select);

	parameter size = 32;
	
	output [size-1:0] dataout; 	// ALU operation output
	
	input [2:0] select;			// select lines
	input [size-1:0] a,b;		// operands
	
	wire [size-1:0] data_a,data_not,data_add,data_sub,data_or,data_and,data_slt;		// each operation output
	
	// each operation output
	assign data_a = a;
	assign data_not = ~a;
	assign data_add = a + b;
	assign data_sub = a - b;
	assign data_or = a | b;
	assign data_and = a & b;
	assign data_slt = (a<b) ? 1 : 0;
	
	// select from outputs
	assign 	dataout = (select==0) ? data_a : (select==1) ? data_not : (select==2) ? data_add : (select==3) ? data_sub : (select==4) ? data_or : (select==5) ? data_and : (select==6) ? data_slt : 1'bz;
	
endmodule
