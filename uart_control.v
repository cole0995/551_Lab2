`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:00:24 04/14/2018 
// Design Name: 
// Module Name:    uart_control 
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

// Choose which output controls UART, give control for specified number of baud cycles

module uart_control(
			input cpu_en,                    // CPU instructions input, processor running, output PC
			input alu_en,                    // ALU operation input, ALU running, output result
			input fib_en,                    // Fibonacci input, run, output result
			input initmessage_en,            // Initial terminal message enable
            input cpumessage_en,             // Mode I message enable
            input alumessage_en,             // Mode A message enable
            input fibmessage_en,             // Mode B message enable
			input newline_en,                // Newline character (8'd10) enable
			input kb_done,                   // Keyboard data received
            input txdb,                      // UART transmit busy
			input [63:0] pc,                 // CPU Program Counter
			input [24:0] alu,                // ALU result
			input [63:0] fib,                // Fibonacci result
            input [7:0] keydata,             // Keyboard click translated to ASCII
			output reg txr,                  // UART transmit ready
			output reg [7:0] uart_data       // UART byte to transmit
		);
		
		parameter ClkFrequency = 100_000_000;	// 100MHz
		parameter Baud = 9600;
        
        wire bit_tick;
        reg data_clk = 1'b0;
	
		BaudTickGen #(ClkFrequency, Baud) tickgen(.clk(clk), .enable(txdb), .tick(bit_tick));
        
        reg [3:0] count = 4'd0;
        
        
        // Create data clock and set UART ready
		always @(posedge clk) begin
			if (bit_tick) begin
				if (count == 4'd9) begin
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
        
        reg [(8*60)-1:0] initmessage = "Hello EC551. My name is Minterminal. Please choose a mode: \r\n";
        reg [(8*30)-1:0] cpumessage = "Mode I: Instruction Entry   \r\n";
        reg [(8*30)-1:0] alumessage = "Mode A: ALU Function        \r\n";
        reg [(8*30)-1:0] fibmessage = "Mode B: Fibonacci Benchmark \r\n";
		
		reg [3:0] cpu_cycles = 4'b0;
		reg [1:0] alu_cycles = 2'b0;
		reg [3:0] fib_cycles = 4'b0;
		reg [5:0] initmes_cycles = 6'b0;
        
        reg [4:0] cpumes_cycles = 5'b0;
		reg [4:0] alumes_cycles = 5'b0;
		reg [4:0] fibmes_cycles = 5'b0;
		
		always @(posedge data_clk) begin
		
		    // CPU PC output
			if (cpu_en or cpu_cycles != 3'b0) begin
				case (cpu_cycles)
					4'd0: begin
						uart_data = pc[63:56];
						cpu_cycles = cpu_cycles + 1;
					end
					4'd1: begin
						uart_data = pc[55:48];
						cpu_cycles = cpu_cycles + 1;
					end
					4'd2: begin
						uart_data = pc[47:40];
						cpu_cycles = cpu_cycles + 1;
					end
					4'd3: begin
						uart_data = pc[39:32];
						cpu_cycles = cpu_cycles + 1;
					end
					4'd4: begin
						uart_data = pc[31:24];
						cpu_cycles = cpu_cycles + 1;
					end
					4'd5: begin
						uart_data = pc[23:16];
						cpu_cycles = cpu_cycles + 1;
					end
					4'd6: begin
						uart_data = pc[15:8];
						cpu_cycles = cpu_cycles + 1;
					end
					4'd7: begin
						uart_data = pc[7:0];
						cpu_cycles = cpu_cycles + 1;
					end
                    4'd8: begin
						uart_data = 8'd13;
						cpu_cycles = cpu_cycles + 1;
					end
                    4'd9: begin
						uart_data = 8'd10;
						cpu_cycles = 4'b0;
					end
                    default: begin
						uart_data = 8'd0;
						cpu_cycles = 4'b0;
					end
				endcase
				
			
            // ALU output
			end else if (alu_en or alu_cycles != 2'b0) begin
				case(alu_cycles)
					3'd0: begin
						uart_data = alu[23:16];
						alu_cycles = alu_cycles + 1;
					end
					3'd1: begin
						uart_data = alu[15:8];
						alu_cycles = alu_cycles + 1;
					end
					3'd2: begin
						uart_data = alu[7:0];
						alu_cycles = alu_cycles + 1;
                    end
                    3'd3: begin
						uart_data = 8'd13;
						alu_cycles = alu_cycles + 1;
                    end
                    3'd4: begin
						uart_data = 8'd10;
						alu_cycles = 2'b0;
                    end
					default: begin
						uart_data = 8'd0;
						alu_cycles = 2'b0;
					end
				endcase
				
			
            // Fibonacci output
			end else if (fib_en or fib_cycles != 3'b0) begin
				case (fib_cycles)
					4'd0: begin
						uart_data = fib[63:56];
						fib_cycles = fib_cycles + 1;
					end
					4'd1: begin
						uart_data = fib[55:48];
						fib_cycles = fib_cycles + 1;
					end
					4'd2: begin
						uart_data = fib[47:40];
						fib_cycles = fib_cycles + 1;
					end
					4'd3: begin
						uart_data = fib[39:32];
						fib_cycles = fib_cycles + 1;
					end
					4'd4: begin
						uart_data = fib[31:24];
						fib_cycles = fib_cycles + 1;
					end
					4'd5: begin
						uart_data = fib[23:16];
						fib_cycles = fib_cycles + 1;
					end
					4'd6: begin
						uart_data = fib[15:8];
						fib_cycles = fib_cycles + 1;
					end
					4'd7: begin
						uart_data = fib[7:0];
						fib_cycles = fib_cycles + 1;
					end
                    4'd8: begin
						uart_data = 8'd13;
						fib_cycles = fib_cycles + 1;
					end
					4'd9: begin
						uart_data = 8'd10;
						fib_cycles = 3'b0;
					end
                    4'd9: begin
						uart_data = 8'd0;
						fib_cycles = 3'b0;
					end
				endcase
				
			
            // Initialize terminal message
			end else if (initmessage_en or initmes_cycles != 6'b0) begin
                case (initmes_cycles) 
                    6'd0: begin
                        uart_data = initmessage[(8*60)-1:(8*59)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd1: begin
                        uart_data = initmessage[(8*59)-1:(8*58)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd2: begin
                        uart_data = initmessage[(8*58)-1:(8*57)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd3: begin
                        uart_data = initmessage[(8*57)-1:(8*56)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd4: begin
                        uart_data = initmessage[(8*56)-1:(8*55)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd5: begin
                        uart_data = initmessage[(8*55)-1:(8*54)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd6: begin
                        uart_data = initmessage[(8*54)-1:(8*53)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd7: begin
                        uart_data = initmessage[(8*53)-1:(8*52)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd8: begin
                        uart_data = initmessage[(8*52)-1:(8*51)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd9: begin
                        uart_data = initmessage[(8*51)-1:(8*50)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    
                    6'd10: begin
                        uart_data = initmessage[(8*50)-1:(8*49)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd11: begin
                        uart_data = initmessage[(8*49)-1:(8*48)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd12: begin
                        uart_data = initmessage[(8*48)-1:(8*47)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd13: begin
                        uart_data = initmessage[(8*47)-1:(8*46)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd14: begin
                        uart_data = initmessage[(8*46)-1:(8*45)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd15: begin
                        uart_data = initmessage[(8*45)-1:(8*44)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd16: begin
                        uart_data = initmessage[(8*44)-1:(8*43)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd17: begin
                        uart_data = initmessage[(8*43)-1:(8*42)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd18: begin
                        uart_data = initmessage[(8*42)-1:(8*41)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd19: begin
                        uart_data = initmessage[(8*41)-1:(8*40)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    
                    6'd20: begin
                        uart_data = initmessage[(8*40)-1:(8*39)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd21: begin
                        uart_data = initmessage[(8*39)-1:(8*38)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd22: begin
                        uart_data = initmessage[(8*38)-1:(8*37)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd23: begin
                        uart_data = initmessage[(8*37)-1:(8*36)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd24: begin
                        uart_data = initmessage[(8*36)-1:(8*35)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd25: begin
                        uart_data = initmessage[(8*35)-1:(8*34)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd26: begin
                        uart_data = initmessage[(8*34)-1:(8*33)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd27: begin
                        uart_data = initmessage[(8*33)-1:(8*32)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd28: begin
                        uart_data = initmessage[(8*32)-1:(8*31)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd29: begin
                        uart_data = initmessage[(8*31)-1:(8*30)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    
                    
                    6'd30: begin
                        uart_data = initmessage[(8*30)-1:(8*29)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd31: begin
                        uart_data = initmessage[(8*29)-1:(8*28)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd32: begin
                        uart_data = initmessage[(8*28)-1:(8*27)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd33: begin
                        uart_data = initmessage[(8*27)-1:(8*26)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd34: begin
                        uart_data = initmessage[(8*26)-1:(8*25)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd35: begin
                        uart_data = initmessage[(8*25)-1:(8*24)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd36: begin
                        uart_data = initmessage[(8*24)-1:(8*23)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd37: begin
                        uart_data = initmessage[(8*23)-1:(8*22)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd38: begin
                        uart_data = initmessage[(8*22)-1:(8*21)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd39: begin
                        uart_data = initmessage[(8*21)-1:(8*20)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    
                    6'd40: begin
                        uart_data = initmessage[(8*20)-1:(8*19)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd41: begin
                        uart_data = initmessage[(8*19)-1:(8*18)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd42: begin
                        uart_data = initmessage[(8*18)-1:(8*17)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd43: begin
                        uart_data = initmessage[(8*17)-1:(8*16)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd44: begin
                        uart_data = initmessage[(8*16)-1:(8*15)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd45: begin
                        uart_data = initmessage[(8*15)-1:(8*14)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd46: begin
                        uart_data = initmessage[(8*14)-1:(8*13)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd47: begin
                        uart_data = initmessage[(8*13)-1:(8*12)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd48: begin
                        uart_data = initmessage[(8*12)-1:(8*11)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd49: begin
                        uart_data = initmessage[(8*11)-1:(8*10)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    
                    6'd50: begin
                        uart_data = initmessage[(8*10)-1:(8*9)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd51: begin
                        uart_data = initmessage[(859)-1:(8*8)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd52: begin
                        uart_data = initmessage[(8*8)-1:(8*7)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd53: begin
                        uart_data = initmessage[(8*7)-1:(8*6)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd54: begin
                        uart_data = initmessage[(8*6)-1:(8*5)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd55: begin
                        uart_data = initmessage[(8*5)-1:(8*4)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd56: begin
                        uart_data = initmessage[(8*4)-1:(8*3)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd57: begin
                        uart_data = initmessage[(8*3)-1:(8*2)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd58: begin
                        uart_data = initmessage[(8*2)-1:(8*1)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    6'd59: begin
                        uart_data = initmessage[(8*1)-1:(8*0)];
                        initmes_cycles = initmes_cycles + 1;
                    end
                    default: begin
                        uart_data = 8'd0;
                        initmes_cycles = 6'b0;
                    end
                endcase
                
            
            // Instruction Entry mode message
            end else if (cpumessage_en or cpumes_cycles != 5'b0) begin
                case (cpumes_cycles) 
                     6'd0: begin
                        uart_data = cpumessage[(8*30)-1:(8*29)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd1: begin
                        uart_data = cpumessage[(8*29)-1:(8*28)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd2: begin
                        uart_data = cpumessage[(8*28)-1:(8*27)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd3: begin
                        uart_data = cpumessage[(8*27)-1:(8*26)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd4: begin
                        uart_data = cpumessage[(8*26)-1:(8*25)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd5: begin
                        uart_data = cpumessage[(8*25)-1:(8*24)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd6: begin
                        uart_data = cpumessage[(8*24)-1:(8*23)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd7: begin
                        uart_data = cpumessage[(8*23)-1:(8*22)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd8: begin
                        uart_data = cpumessage[(8*22)-1:(8*21)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd9: begin
                        uart_data = cpumessage[(8*21)-1:(8*20)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd10: begin
                        uart_data = cpumessage[(8*20)-1:(8*19)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd11: begin
                        uart_data = cpumessage[(8*19)-1:(8*18)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd12: begin
                        uart_data = cpumessage[(8*18)-1:(8*17)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd13: begin
                        uart_data = cpumessage[(8*17)-1:(8*16)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd14: begin
                        uart_data = cpumessage[(8*16)-1:(8*15)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd15: begin
                        uart_data = cpumessage[(8*15)-1:(8*14)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd16: begin
                        uart_data = cpumessage[(8*14)-1:(8*13)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd17: begin
                        uart_data = cpumessage[(8*13)-1:(8*12)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd18: begin
                        uart_data = cpumessage[(8*12)-1:(8*11)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd19: begin
                        uart_data = cpumessage[(8*11)-1:(8*10)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd20: begin
                        uart_data = cpumessage[(8*10)-1:(8*9)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd21: begin
                        uart_data = cpumessage[(8*9)-1:(8*8)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd22: begin
                        uart_data = cpumessage[(8*8)-1:(8*7)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd23: begin
                        uart_data = cpumessage[(8*7)-1:(8*6)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd24: begin
                        uart_data = cpumessage[(8*6)-1:(8*5)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd25: begin
                        uart_data = cpumessage[(8*5)-1:(8*4)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd26: begin
                        uart_data = cpumessage[(8*4)-1:(8*3)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd27: begin
                        uart_data = cpumessage[(8*3)-1:(8*2)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd28: begin
                        uart_data = cpumessage[(8*2)-1:(8*1)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    6'd29: begin
                        uart_data = cpumessage[(8*1)-1:(8*0)];
                        cpumes_cycles = cpumes_cycles + 1;
                    end
                    default: begin  
                        uart_data = 8'd0;
                        cpumes_cycles = 5'b0;
                    end
                endcase
                
            
            // ALU Input mode message
            end else if (alumessage_en or alumes_cycles != 5'b0) begin
                case (alumes_cycles) 
                     6'd0: begin
                        uart_data = alumessage[(8*30)-1:(8*29)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd1: begin
                        uart_data = alumessage[(8*29)-1:(8*28)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd2: begin
                        uart_data = alumessage[(8*28)-1:(8*27)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd3: begin
                        uart_data = alumessage[(8*27)-1:(8*26)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd4: begin
                        uart_data = alumessage[(8*26)-1:(8*25)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd5: begin
                        uart_data = alumessage[(8*25)-1:(8*24)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd6: begin
                        uart_data = alumessage[(8*24)-1:(8*23)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd7: begin
                        uart_data = alumessage[(8*23)-1:(8*22)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd8: begin
                        uart_data = alumessage[(8*22)-1:(8*21)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd9: begin
                        uart_data = alumessage[(8*21)-1:(8*20)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd10: begin
                        uart_data = alumessage[(8*20)-1:(8*19)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd11: begin
                        uart_data = alumessage[(8*19)-1:(8*18)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd12: begin
                        uart_data = alumessage[(8*18)-1:(8*17)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd13: begin
                        uart_data = alumessage[(8*17)-1:(8*16)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd14: begin
                        uart_data = alumessage[(8*16)-1:(8*15)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd15: begin
                        uart_data = alumessage[(8*15)-1:(8*14)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd16: begin
                        uart_data = alumessage[(8*14)-1:(8*13)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd17: begin
                        uart_data = alumessage[(8*13)-1:(8*12)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd18: begin
                        uart_data = alumessage[(8*12)-1:(8*11)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd19: begin
                        uart_data = alumessage[(8*11)-1:(8*10)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd20: begin
                        uart_data = alumessage[(8*10)-1:(8*9)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd21: begin
                        uart_data = alumessage[(8*9)-1:(8*8)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd22: begin
                        uart_data = alumessage[(8*8)-1:(8*7)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd23: begin
                        uart_data = alumessage[(8*7)-1:(8*6)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd24: begin
                        uart_data = alumessage[(8*6)-1:(8*5)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd25: begin
                        uart_data = alumessage[(8*5)-1:(8*4)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd26: begin
                        uart_data = alumessage[(8*4)-1:(8*3)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd27: begin
                        uart_data = alumessage[(8*3)-1:(8*2)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd28: begin
                        uart_data = alumessage[(8*2)-1:(8*1)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    6'd29: begin
                        uart_data = alumessage[(8*1)-1:(8*0)];
                        alumes_cycles = alumes_cycles + 1;
                    end
                    default: begin
                        uart_data = 8'd0;
                        alumes_cycles = 5'b0;
                    end
                endcase
                    
            
            // Fibonacci Benchmark mode message
            end else if (fibmessage_en or fibmes_cycles != 5'b0) begin
                case (fibmes_cycles) 
                     6'd0: begin
                        uart_data = fibmessage[(8*30)-1:(8*29)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd1: begin
                        uart_data = fibmessage[(8*29)-1:(8*28)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd2: begin
                        uart_data = fibmessage[(8*28)-1:(8*27)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd3: begin
                        uart_data = fibmessage[(8*27)-1:(8*26)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd4: begin
                        uart_data = fibmessage[(8*26)-1:(8*25)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd5: begin
                        uart_data = fibmessage[(8*25)-1:(8*24)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd6: begin
                        uart_data = fibmessage[(8*24)-1:(8*23)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd7: begin
                        uart_data = fibmessage[(8*23)-1:(8*22)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd8: begin
                        uart_data = fibmessage[(8*22)-1:(8*21)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd9: begin
                        uart_data = fibmessage[(8*21)-1:(8*20)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd10: begin
                        uart_data = fibmessage[(8*20)-1:(8*19)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd11: begin
                        uart_data = fibmessage[(8*19)-1:(8*18)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd12: begin
                        uart_data = fibmessage[(8*18)-1:(8*17)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd13: begin
                        uart_data = fibmessage[(8*17)-1:(8*16)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd14: begin
                        uart_data = fibmessage[(8*16)-1:(8*15)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd15: begin
                        uart_data = fibmessage[(8*15)-1:(8*14)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd16: begin
                        uart_data = fibmessage[(8*14)-1:(8*13)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd17: begin
                        uart_data = fibmessage[(8*13)-1:(8*12)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd18: begin
                        uart_data = fibmessage[(8*12)-1:(8*11)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd19: begin
                        uart_data = fibmessage[(8*11)-1:(8*10)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd20: begin
                        uart_data = fibmessage[(8*10)-1:(8*9)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd21: begin
                        uart_data = fibmessage[(8*9)-1:(8*8)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd22: begin
                        uart_data = fibmessage[(8*8)-1:(8*7)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd23: begin
                        uart_data = fibmessage[(8*7)-1:(8*6)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd24: begin
                        uart_data = fibmessage[(8*6)-1:(8*5)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd25: begin
                        uart_data = fibmessage[(8*5)-1:(8*4)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd26: begin
                        uart_data = fibmessage[(8*4)-1:(8*3)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd27: begin
                        uart_data = fibmessage[(8*3)-1:(8*2)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd28: begin
                        uart_data = fibmessage[(8*2)-1:(8*1)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    6'd29: begin
                        uart_data = fibmessage[(8*1)-1:(8*0)];
                        fibmes_cycles = fibmes_cycles + 1;
                    end
                    default: begin
                        uart_data = 8'd0;
                        fibmes_cycles = 5'b0;
                    end
                endcase
                
                
            // Newline character    
            end else if (newline_en) begin
                uart_data = 8'd10;
                
                
            // Keyboard click    
            end else if (kb_done) begin
                uart_data = keydata;
            
            
            // Default
            end else begin
                uart_data = 8'd0;
                cpu_cycles = 4'b0;
                alu_cycles = 2'b0;
                fib_cycles = 4'b0;
                initmes_cycles = 6'b0;
                cpumes_cycles = 5'b0;
                alumes_cycles = 5'b0;
                fibmes_cycles = 5'b0;
            end
        end
endmodule
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    

endmodule
