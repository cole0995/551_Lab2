`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:37:45 04/09/2018 
// Design Name: 
// Module Name:    alu_interface 
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
module alu_interface(
    input [23:0] input_word,
	 input enable,
    output [15:0] output_ascii
    );
	
	wire [7:0] alu_result;
	wire [23:0] trans_word;
	
	assign trans_word[15:8] = input_word[15:8];
	
	key2dec kd1(input_word[23:16], trans_word[23:16]);
	key2dec kd2(input_word[7:0], trans_word[7:0]);
	
	mode2ALU alu(trans_word, enable, alu_result);
	
	hex2ascii h1(alu_result[7:4], output_ascii[15:8]);
	hex2ascii h2(alu_result[3:0], output_ascii[7:0]);

endmodule
