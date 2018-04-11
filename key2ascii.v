`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:43:07 04/07/2018 
// Design Name: 
// Module Name:    key2ascii 
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
module key2ascii(ascii, key);
		
	input [7:0] key;
	output reg [7:0] ascii;
	
	always @(*) begin
		case (key) 
			// Numbers
			8'h45: ascii <= 8'd48;
			8'h16: ascii <= 8'd49;
			8'h1e: ascii <= 8'd50;
			8'h26: ascii <= 8'd51;
			8'h25: ascii <= 8'd52;
			8'h2e: ascii <= 8'd53;
			8'h36: ascii <= 8'd54;
			8'h3d: ascii <= 8'd55;
			8'h3e: ascii <= 8'd56;
			8'h46: ascii <= 8'd57;

			// Letters
			8'h15: ascii <= 8'd113;	// QWERT
			8'h1d: ascii <= 8'd119;
			8'h24: ascii <= 8'd101;
			8'h2d: ascii <= 8'd114;
			8'h2c: ascii <= 8'd116;
			
			8'h35: ascii <= 8'd121; // YUIOP
			8'h3c: ascii <= 8'd117;
			8'h43: ascii <= 8'd105;
			8'h44: ascii <= 8'd111;
			8'h4d: ascii <= 8'd112;
			
			8'h1c: ascii <= 8'd97; // ASDFG
			8'h1b: ascii <= 8'd115;
			8'h23: ascii <= 8'd100;
			8'h2b: ascii <= 8'd102;
			8'h34: ascii <= 8'd103;
			
			8'h33: ascii <= 8'd104; // HJKLZ
			8'h3b: ascii <= 8'd106;
			8'h42: ascii <= 8'd107;
			8'h4b: ascii <= 8'd108;
			8'h1a: ascii <= 8'd122;
			
			8'h22: ascii <= 8'd120; // XCVBNM
			8'h21: ascii <= 8'd99;
			8'h2a: ascii <= 8'd118;
			8'h32: ascii <= 8'd98;
			8'h31: ascii <= 8'd110;
			8'h3a: ascii <= 8'd109; 
			
			// Other
			8'h29: ascii <= 8'd32; // spacebar
			8'h5a: ascii <= 8'd13; // enter
			8'h66: ascii <= 8'd8;  // backspace
			
			8'h55: ascii <= 8'd43; // +
			8'h4e: ascii <= 8'd45; // -
			8'h41: ascii <= 8'd94; // ^
			8'h0e: ascii <= 8'd42; // *
			
			default: ascii <= 8'd0;
		endcase
	end
endmodule
