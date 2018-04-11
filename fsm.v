`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:39:08 04/07/2018 
// Design Name: 
// Module Name:    fsm 
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
module fsm(
    );
	 
localparam 'INIT = 3'b000;
localparam 'ISA = 3'b001;
localparam 'ALU = 3'b010;
localparam 'BENCH = 3'b011;
localparam 'RUN = 3'b100;

	reg [2:0] state = 'INIT;
	reg [2:0] next_state;

	reg [15:0] init_input;
	reg [31:0] alu_input;
	reg [71:0] isa_input;
	reg [31:0] bench_input;
	
	always @(posedge clk) begin
		if (rst) begin
			state <= 'INIT;
		end else begin
			state <= next_state;
		end
	end
	
	
	
	
	alu_interface alu(alu_input[31:8], alu_go, alu_result);
	
	cpu cp(rst, clk, next_instruction, count, cpu_start, mem_write);
	
	
	
	always @(*) begin
		case(state)
			'INIT: begin 	// print init message
				case (init_input) // check for sequences 'ienter' 'aenter' 'benter'
					16'h435a: next_state = 'ISA;
					16'h155a: next_state = 'ALU;
					16'h325a: next_state = 'BENCH;
					default: next_state = 'INIT;
				endcase
			end
			
			'ISA: begin 	// wait for and store instructions
				case (isa_input[7:0])				// watch for 'r' then go to run state
					8'h5a:  begin	// send instruction
						next_state = 'ISA;
						mem_write = 1'b1;
					end
					8'h2d: begin
						next_state = 'RUN;
						mem_write = 1'b0;
					end
					default: begin
						next_state = 'ISA;
						mem_write = 1'b0;
					end
				endcase
			end
			
			'ALU: begin		// wait for 3 chars (ex. 4-2)
				case (alu_input[7:0]) 				// perform op, print result
					8'h5a: begin // set flags
						next_state = 'ALU;
						alu_go = 1'b1;
					end
					default: begin
						next_state = 'ALU;
						alu_go = 1'b0;
					end
				endcase
			end
			
			'BENCH: begin	// print fib message and wait for input
				case (bench_input[7:0])
					8'h5a: begin // set flags
						next_state = 'BENCH;
						fib_go = 1'b1;
					end
					default: begin
						next_state = 'BENCH;
						fib_go = 1'b0;
					end
				endcase
			end
			
			'RUN: begin		// run stored program
				cpu_start = 1'b1;
			end
		endcase
	end

endmodule
