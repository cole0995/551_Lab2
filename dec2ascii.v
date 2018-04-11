`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:09:14 04/09/2018 
// Design Name: 
// Module Name:    dec2ascii 
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
module hex2ascii(
    input [3:0] hex,
    output reg [7:0] ascii
    );
	
	always @(*) begin
		case (hex)
			4'h0: assign ascii = 8'd48;
			4'h1: assign ascii = 8'd49;
			4'h2: assign ascii = 8'd50;
			4'h3: assign ascii = 8'd51;
			4'h4: assign ascii = 8'd52;
			4'h5: assign ascii = 8'd53;
			4'h6: assign ascii = 8'd54;
			4'h7: assign ascii = 8'd55;
			4'h8: assign ascii = 8'd56;
			4'h9: assign ascii = 8'd57;
			4'ha: assign ascii = 8'd65;
			4'hb: assign ascii = 8'd66;
			4'hc: assign ascii = 8'd67;
			4'hd: assign ascii = 8'd68;
			4'he: assign ascii = 8'd69;
			4'hf: assign ascii = 8'd70;
			default: assign ascii = 8'd0;
		endcase
	end
endmodule
