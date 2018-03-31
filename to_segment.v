`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:24:06 04/13/2016 
// Design Name: 
// Module Name:    to_segment 
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
module to_segment(seven, input_number);

	input [6:0] input_number;			// the number to be converted to be displayed on the seven segment displayed
	
	output reg [6:0] seven;				// the converted number
	
	always @ (input_number)
	begin
		case (input_number)
			0:
				seven = 7'b1000000;			
			1:
				seven = 7'b1111001;
			2:
				seven = 7'b0100100;
			3:
				seven = 7'b0110000;						// hard code each number to be converted
			4:
				seven = 7'b0011001;
			5:
				seven = 7'b0010010;
			6:
				seven = 7'b0000010;
			7:
				seven = 7'b1111000;
			8:
				seven = 7'b0000000;
			9:
				seven = 7'b0010000;
			10:
				seven = 7'b0100000;
			11:
				seven = 7'b0000011;
			12:
				seven = 7'b1110000;
			13:
				seven = 7'b0100001;
			14:
				seven = 7'b0000110;
			15:
				seven = 7'b0001110;
			
			default: seven = 7'b1000000;				// set the default to be 0
		endcase
	end
endmodule