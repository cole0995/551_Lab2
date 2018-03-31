`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:46:00 04/13/2016 
// Design Name: 
// Module Name:    seven_alternate 
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
module seven_alternate(AN, display, tens_minutes, tens_seconds, ones_minutes, ones_seconds, clk, reset);

	input clk,  							// 1 KHz clock
	reset;									// global reset
	input [6:0] tens_minutes, 			// the tens digit of the minutes
	tens_seconds, 							// the tens digit of the seconds
	ones_minutes, 							// the ones digit of the minutes
	ones_seconds;							// the ones digit of the seconds
	
	output reg [3:0] AN;					// the anodes of the seven segment display, in a 0 hot fashion
	output reg [6:0] display;			// the display that will rotate in a round robin fashion
	
	reg [1:0] count;						// internal counter to rotate through the anodes
	
	always @ (posedge clk)
	begin
		if (reset) begin
			AN = 0;
			display = 0;					// reset everything
			count = 0;
		end
		else begin
			count = count + 1'b1;		// continually rotate through the anodes
			case (count)
				0: begin
					AN = 4'b1110;					// the rightmost anode
					display = ones_seconds;		// will display the ones digit of the seconds
				end
				1: begin
					AN = 4'b1101;					// the second anode from the right
					display = tens_seconds;		// will display the tens digit of the seconds
				end
				2: begin
					AN = 4'b1011;					// the second anode from the left
					display = ones_minutes;		// will display the ones digit of the minutes
				end
				3: begin
					AN = 4'b0111;					// the leftmost anode
					display = tens_minutes;		// will display the tens digit of the minutes
				end
				default: begin
					display = 0; count = 0; AN = 0;
				end
			endcase
		end
	end
endmodule
