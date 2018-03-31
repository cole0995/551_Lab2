`timescale 1ns / 1ps

module Se7en(clk,reset,number,display,AN);

	input clk,reset;
	input [15:0] number;
	
	output [6:0] display;
	output [3:0] AN;
	
	wire seg_clock;
	
	wire [3:0] tens_minutes,ones_minutes,tens_seconds,ones_seconds;
	
	assign tens_minutes = number[15:12];
	assign tens_seconds = number[15:12];
	assign ones_minutes = number[11:8];
	assign ones_seconds = number[11:8];
	
	segment_clock segclk(seg_clock, clk);
	
	wire [6:0] tens_minutes_seven, ones_minutes_seven, tens_seconds_seven, ones_seconds_seven;
	
	to_segment tm(tens_minutes_seven, tens_minutes);
	to_segment om(ones_minutes_seven, ones_minutes);		// then convert the digits to be displayed on the seven segment display
	to_segment ts(tens_seconds_seven, tens_seconds);
	to_segment os(ones_seconds_seven, ones_seconds);
	
	wire [3:0] AN;
	wire [6:0] display;
	
	seven_alternate sev1(AN, display, tens_minutes_seven, tens_seconds_seven, ones_minutes_seven, ones_seconds_seven, seg_clock, reset);

endmodule
