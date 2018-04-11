`timescale 1ns / 1ns


module shiftRegister(
     data_in,
	  ready,
	  data_out
    );
	 
	parameter data_size = 8;

	parameter memory_depth = 2;  // do not specify this when using module

	input [data_size-1:0] data_in;

	output [(data_size*memory_depth)-1:0] data_out;
	input ready;
	//reg [data_size-1:0] mem [0:memory_depth-1];
	reg [data_size-1:0] mem [0:memory_depth - 1];
	
	genvar i;
	
	
	//assign data_out = (read) ?  mem [address[address_size+1:2]] : 32'bz;
	generate
		for (i=1;i<=memory_depth;i=i+1) begin
			always @(posedge ready) begin
				mem[i] <= mem[i-1];
				mem[0] <= data_in;
			end
		end
	endgenerate

	for (i=0;i<memory_depth;i=i+1) begin
		assign data_out[((i+1)*(data_size))-1:(i*data_size)] = mem[i];
	end

endmodule
