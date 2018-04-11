`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:38 04/09/2018 
// Design Name: 
// Module Name:    mode2ALU 
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
module mode2ALU(input_word, enable, output_data);

	input [23:0] input_word;
	input enable;
	output reg [7:0] output_data;
	
	wire [7:0] operation, a, b;
	
	assign a = input_word[23:16];
	assign operation = input_word[15:8];
	assign b = input_word[7:0];
	
	always @(*) begin
		if (enable) begin
			case (operation) 
				8'h55: assign output_data = a + b;
				8'h4e: assign output_data = a - b;
				8'h41: assign output_data = a ^ b;
				8'h0e: assign output_data = a * b;
				default: assign output_data = 8'h0;
			endcase
		end else begin
			assign output_data = 8'h0;
		end
	end
endmodule
