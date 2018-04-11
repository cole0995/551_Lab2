`timescale 1ns / 1ps

module Fibonacci(in,enable,out);
	//in is 8 bits, out can be up to 69 bits
	input enable;
	input [6:0] in;
	output reg [31:0] out;
	
	
	always @ * begin
		if (enable) begin
			case(in)
				0 : assign out = 0;
				1 : assign out = 1;
				2 : assign out = 1;
				3 : assign out = 2;
				4 : assign out = 3;
				5 : assign out = 5;
				6 : assign out = 8;
				7 : assign out = 13;
				8 : assign out = 21;
				9 : assign out = 34;
				10 : assign out = 55;
				11 : assign out = 89;
				12 : assign out = 144;
				13 : assign out = 233;
				14 : assign out = 377;
				15 : assign out = 610;
				16 : assign out = 987;
				17 : assign out = 1597;
				18 : assign out = 2584;
				19 : assign out = 4181;
				20 : assign out = 6765;
				21 : assign out = 10946;
				22 : assign out = 17711;
				23 : assign out = 28657;
				24 : assign out = 46368;
				25 : assign out = 75025;
				26 : assign out = 121393;
				27 : assign out = 196418;
				28 : assign out = 317811;
				29 : assign out = 514229;
				30 : assign out = 832040;
				31 : assign out = 1346269;
				32 : assign out = 2178309;
				33 : assign out = 3524578;
				34 : assign out = 5702887;
				35 : assign out = 9227465;
				36 : assign out = 14930352;
				37 : assign out = 24157817;
				38 : assign out = 39088169;
				39 : assign out = 63245986;
				40 : assign out = 102334155;
				41 : assign out = 165580141;
				42 : assign out = 267914296;
				43 : assign out = 433494437;
				44 : assign out = 701408733;
				45 : assign out = 1134903170;
				46 : assign out = 1836311903;
				47 : assign out = 2971215073;
				/*48 : assign out = 4807526976;
				49 : assign out = 7778742049;
				50 : assign out = 12586269025;
				51 : assign out = 20365011074;
				52 : assign out = 32951280099;
				53 : assign out = 53316291173;
				54 : assign out = 86267571272;
				55 : assign out = 139583862445;
				56 : assign out = 225851433717;
				57 : assign out = 365435296162;
				58 : assign out = 591286729879;
				59 : assign out = 956722026041;
				60 : assign out = 1548008755920;*/
			/*	61 : assign out = 2504730781961;
				62 : assign out = 4052739537881;
				63 : assign out = 6557470319842;
				64 : assign out = 10610209857723;
				65 : assign out = 17167680177565;
				66 : assign out = 27777890035288;
				67 : assign out = 44945570212853;
				68 : assign out = 72723460248141;
				69 : assign out = 117669030460994;
				70 : assign out = 190392490709135;
				71 : assign out = 308061521170129;
				72 : assign out = 498454011879264;
				73 : assign out = 806515533049393;
				74 : assign out = 1304969544928657;
				75 : assign out = 2111485077978050;
				76 : assign out = 3416454622906707;
				77 : assign out = 5527939700884757;
				78 : assign out = 8944394323791464;
				79 : assign out = 14472334024676221;
				80 : assign out = 23416728348467685;
				81 : assign out = 37889062373143906;
				82 : assign out = 61305790721611591;
				83 : assign out = 99194853094755497;
				84 : assign out = 160500643816367088;
				85 : assign out = 259695496911122585;
				86 : assign out = 420196140727489673;
				87 : assign out = 679891637638612258;
				88 : assign out = 1100087778366101931;
				89 : assign out = 1779979416004714189;
				90 : assign out = 2880067194370816120;
				91 : assign out = 4660046610375530309;
				92 : assign out = 7540113804746346429;
				93 : assign out = 12200160415121876738;
				94 : assign out = 19740274219868223167;
				95 : assign out = 31940434634990099905;
				96 : assign out = 51680708854858323072;
				97 : assign out = 83621143489848422977;
				98 : assign out = 135301852344706746049;
				99 : assign out = 218922995834555169026;
				100 : assign out = 354224848179261915075;*/
			endcase
		end
	end

endmodule
