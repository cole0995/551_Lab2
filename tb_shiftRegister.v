`timescale 1ns / 1ps
module tb_shiftRegister;

	// Inputs
	reg [7:0] data_in;
	reg ready;

	// Outputs
	wire [15:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	shiftRegister uut (
		.data_in(data_in), 
		.ready(ready), 
		.data_out(data_out)
	);

	initial begin
		// Initialize Inputs
		data_in = 0;
		ready = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		ready = 1;
		#20 data_in = 8'haf;
		#20 data_in = 8'h00;
		#20 data_in = 8'ha0;
		#20 data_in = 8'h1e;
		#20 data_in = 8'hff;
	end
      
	always
		#10 ready = !ready;
		
endmodule

