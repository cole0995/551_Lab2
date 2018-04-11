`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:34:32 04/10/2018 
// Design Name: 
// Module Name:    key2dec 
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
module key2dec(
    input [7:0] key,
    output reg [7:0] dec
    );

	always @(*) begin
		case (key) 
			8'h45: dec <= 8'd0;
			8'h16: dec <= 8'd1;
			8'h1e: dec <= 8'd2;
			8'h26: dec <= 8'd3;
			8'h25: dec <= 8'd4;
			8'h2e: dec <= 8'd5;
			8'h36: dec <= 8'd6;
			8'h3d: dec <= 8'd7;
			8'h3e: dec <= 8'd8;
			8'h46: dec <= 8'd9;
			default: dec <= 8'd0;
		endcase
	end
endmodule
