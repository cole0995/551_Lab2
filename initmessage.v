`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:58:04 04/09/2018 
// Design Name: 
// Module Name:    initmessage 
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
module initmessage(clk, uart_out, TxD_busy);

	input clk;
	output uart_out;
	output reg TxD_busy;
	
	wire txready;
	reg txr = 1'b0;
	
	reg [7:0] data = 8'd0;
	reg [6:0] i = 6'd1;
	reg [7:0] u_data;
	reg [3:0] count = 4'd0;
	
	reg data_clk;
	wire bit_tick;
	
	parameter ClkFrequency = 100_000_000;	// 100MHz
	parameter Baud = 9600;
	
	BaudTickGen #(ClkFrequency, Baud) tickgen(.clk(clk), .enable(1'b1), .tick(bit_tick));
	
	always @(posedge data_clk) begin
		if (i == 6'd58) begin
			i <= 6'b1;
		end
		else begin
			i <= i + 1;
		end
		case (i)
			1: data = 8'd72;
			2: data = 8'd101;
			3: data = 8'd108;
			4: data = 8'd108;
			5: data = 8'd111;
			6: data = 8'd32;
			7: data = 8'd69;
			8: data = 8'd67;
			9: data = 8'd53;
			10: data = 8'd53;
			11: data = 8'd49;
			12: data = 8'd46;
			13: data = 8'd32;
			14: data = 8'd77;
			15: data = 8'd121;
			16: data = 8'd32;
			17: data = 8'd110;
			18: data = 8'd97;
			19: data = 8'd109;
			20: data = 8'd101;
			21: data = 8'd32;
			22: data = 8'd105;
			23: data = 8'd115;
			24: data = 8'd32;
			25: data = 8'd77;
			26: data = 8'd105;
			27: data = 8'd110;
			28: data = 8'd116;
			29: data = 8'd101;
			30: data = 8'd114;
			31: data = 8'd109;
			32: data = 8'd105;
			33: data = 8'd110;
			34: data = 8'd97;
			35: data = 8'd108;
			36: data = 8'd46;
			37: data = 8'd32;
			38: data = 8'd80;
			39: data = 8'd108;
			40: data = 8'd101;
			41: data = 8'd97;
			42: data = 8'd115;
			43: data = 8'd101;
			44: data = 8'd32;
			45: data = 8'd99;
			46: data = 8'd104;
			47: data = 8'd111;
			48: data = 8'd111;
			49: data = 8'd115;
			50: data = 8'd101;
			51: data = 8'd32;
			52: data = 8'd97;
			53: data = 8'd32;
			54: data = 8'd109;
			55: data = 8'd111;
			56: data = 8'd100;
			57: data = 8'd101;
			58: data = 8'd58;
			default: data = 8'd00;
		endcase
	end
	
	/*
	genvar i;
	reg [9:0] loop = 9'd456;
	
	for (i = 0; i < 57; i = i + 1) begin
		always @(posedge clk) begin
			//loop <= loop - 4'd8;
			data = message[(456 - i*8): (449 - i*8)];
			txready <= 1'b1;
		end
	end
	*/
	
	wire txdb;
	
	always @(posedge clk) begin
		u_data = data;
		TxD_busy = txdb;
		/*
		if (txready) begin
			txr <= 1'b1;
		end else begin 
			txr <= 1'b0;
		end
		*/
		if (bit_tick) begin
			if (count == 4'd11) begin
				txr = 1'b1;
				count = 4'd0;
				data_clk = 1'b1;
			end else begin
				txr = 1'b0;
				count = count + 1;
				data_clk = 1'b0;
			end
		end
	end
	
	UART_Tx uart(clk, txr, u_data, uart_out, txdb);

endmodule
