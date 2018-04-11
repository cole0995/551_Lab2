`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:11:33 10/25/2016 
// Design Name: 
// Module Name:    cpu 
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

// 8 bit data
// 4 bit wide address for memories and reg file
// 32 bit wide instruction
// 4 bit immediate

module cpu(
    rst,
	 clk,
	 next_instruction,
	 count,
	 start,
	 mem_write
    );
	 
	 	 
    input rst, clk, start, mem_write;
	 input [31:0] next_instruction;
	 
	 output reg [3:0] count = 4'b0;
	 wire [31:0] instruction;
	 assign instruction = (cpu_started) ? mem_data_out : 32'b0;
	 reg cpu_started = 1'b0;
	
	
	always @(posedge mem_write) begin
		count = count + 1;
	end
	
	reg [3:0] mem_address;
	
	always @(posedge clk) begin
		if (rst) begin
			count = 4'b0;
			cpu_started = 1'b0;
		end
		if (!cpu_started) begin
			mem_address = count;
		end 
		else begin
			if (PC_out !== 32'bX) begin
				mem_address = PC_out;
			end 
			else begin	
				mem_address = 1'b1;
			end
		end
		if (start) begin
			cpu_started = 1'b1;
		end
	end
	
	wire [31:0] mem_data_out;
	
	InstrMem imem(mem_data_out, next_instruction, mem_address, mem_write, clk);
	 
    //InstrMem InstructionMemory (instruction_mem_out , instruction_initialize_data  , (initialize) ? instruction_initialize_address : PC_out , initialize , clk);
	
	
	 wire [1:0] ALUOp;
	 wire MemRead;
	 wire MemtoReg;
	 wire RegDst;
	 wire Branch; 
	 wire Jump;		// added jump
	 wire ALUSrc;
	 wire MemWrite;
	 wire RegWrite;
    control Control(instruction [31:26], ALUOp, MemRead, MemtoReg, RegDst, Branch, Jump, ALUSrc, MemWrite, RegWrite); 	// added jump
	 
	 
	 
	 wire           [31:0]            write_data;
    wire           [4:0]             write_register;
    wire		       [31:0]            read_data_1, read_data_2;
	 wire				 [31:0]            ALUOut, MemOut;
	 mux #(5) Write_Reg_MUX (RegDst, instruction[20:16], instruction[15:11], write_register);
	 nbit_register_file Register_File(write_data, read_data_1, read_data_2, instruction[25:21] , instruction[20:16], write_register, RegWrite, clk);
    
	 
	//=========== Display and I/O Modules ==================
	 
	 wire [31:0] immediate;
    sign_extend Sign_Extend( instruction[15:0], immediate);
	 
	 
	 
	 wire [31:0] ALU_input_2;
    wire zero_flag;
	 wire [2:0] ALU_function;
	 mux #(32) ALU_Input_2_Mux (ALUSrc, read_data_2, immediate, ALU_input_2);
	 ALU_control ALU_Control(instruction[5:0], ALUOp, ALU_function);
    ALU ALU(read_data_1, ALU_input_2, ALU_function, ALUOut, zero_flag);
	 
	 
	 Memory Data_Memory(ALUOut, read_data_2, MemOut, MemRead, MemWrite, clk);


    mux #(32) ALU_Mem_Select_MUX (MemtoReg, ALUOut, MemOut, write_data);	 
	 
	 
	 wire [31:0] PC_out, PC_in;
	 PC Program_Counter(PC_out, PC_in, clk, rst);
	 
	 wire [31:0] PC_plus_4;
	 Adder #(32) PC_Increment_Adder (PC_out, 32'd1, PC_plus_4);  //changed to increment by 1, cause it somehow works this way

	 wire [31:0] Branch_target_address;
	 wire [31:0] immediate_x_4;
	 shift_left_2 #(32) Shift_Left_Two (immediate, immediate_x_4);
	 Adder #(32) Branch_Target_Adder (PC_plus_4, immediate_x_4, Branch_target_address);
	 
	 
	 wire [31:0] Jump_target_address;	//
	 wire [27:0] Jump_target_x_4;			//
	 shift_left_2 #(28) Shift_Left_Too ({2'b00, instruction[25:0]}, Jump_target_x_4);	//
	 
	 
	 assign Jump_target_address[31:28] = PC_plus_4[31:28];			//
	 assign Jump_target_address[27:0] = Jump_target_x_4;	//
	 
	 
	 wire PCSrc, beq, bne;			//
	 and Branch_And (beq, Branch, zero_flag);			//
	 and BNE_And (bne, Branch, ~zero_flag);					// 
	 or branch_or (PCSrc, beq, bne);				//
	 wire [31:0] Branched_PC;			//
	 
	 mux #(32) Branch_MUX (PCSrc, PC_plus_4, Branch_target_address, Branched_PC);	//
	 
	 mux #(32) PC_Input_MUX (Jump, Branched_PC, Jump_target_address, PC_in);		//
	 
	 							 
endmodule
