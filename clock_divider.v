`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:42:48 04/09/2018 
// Design Name: 
// Module Name:    clock_divider 
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
module clock_divider(clk, outclk, txready);

	localparam divider = 4'd15;
	
	input clk;
	output reg outclk = 1'b0;
	output reg txready = 1'b1;
	
	reg [3:0] count = 4'b0;
	
	always @(posedge clk) begin
		if (count == divider) begin
			count <= 4'b0;
			outclk <= ~outclk;
			txready <= 1'b1;
		end else begin
			count <= count + 1;
			txready <= 1'b0;
		end
	end

endmodule
