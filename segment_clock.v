`timescale 1ns / 1ps

module segment_clock(seg_clock, clk);

	input clk;			// 100MHz clock
	
	output reg seg_clock = 0;		// clock signal to the seven segment display
	
	reg [9:0] count = 0;			// internal clock
	
	always @ (posedge clk)
	begin
		if (count >= 10'b1111100111) begin				//10'b1111101000
			seg_clock = ~seg_clock;						// change the clock if the count is reached
			count = 0;									// reset the count
		end
		else begin
			count = count + 1'b1;					// otherwise continue counting
		end
	end
endmodule
