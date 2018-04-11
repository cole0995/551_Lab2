`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:13:48 04/05/2018 
// Design Name: 
// Module Name:    TOP_ku 
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
module TOP_ku(
		clk,
		keyboard_clk,
	   rst,
		keyboard_data,
		//uart_in,
		uart_out,
		keyboard_done,
		//uart_done,
		TxD_busy, 
		display,
		AN
    );
		
		
		
		// I/O ==========================================================================
		input clk, keyboard_clk, rst, keyboard_data;
		output uart_out;
		output reg keyboard_done, TxD_busy;	
		output wire [7:0] display;
		output wire [3:0] AN;
		// // ===========================================================================
		
		
		
		// Internal variables ===========================================================
		reg [7:0] kb_data = 0;
		wire [7:0] keydata, asciidata;
		reg tx_ready = 1'b0;
		wire kbd, txdb;
		// // ===========================================================================
		
		
		
		keyboardtest keyboard(keyboard_clk, keyboard_data, kbd, keydata); // get key click
		
		key2ascii k2a(asciidata, keydata);	// convert to ascii
		
		// Clock functions
		always @(posedge clk) begin
			keyboard_done = kbd;
			TxD_busy = txdb;
			kb_data = asciidata;
			if (kbd) begin
				tx_ready <= 1'b1;
			end else begin
				tx_ready <= 1'b0;
			end
		end
		
		
		
		// Seven segment and UART =======================================================
		wire [15:0] combined = {asciidata, keydata};
		
		UART_Tx tx(clk, tx_ready, kb_data, uart_out, txdb);
		
		Se7en seven(clk, rst, combined, display, AN);
		// // ===========================================================================

endmodule
