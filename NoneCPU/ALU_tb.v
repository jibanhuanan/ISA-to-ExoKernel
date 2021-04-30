`timescale 1ns/1ns //测试时间和精度

module ALU_tb(output signed [64:0]out);

		reg    	enable;
		reg		clk;
		reg  [1    :0]opcode;
		reg  signed [64-1 : 0] in0;
		reg  signed [64-1 : 0] in1;   //input

	initial
	begin
		//init status //#10ns delay
		#10 clk = 0; enable = 0; opcode = 2'b00;
			in0 = 64'b0;	in1 = 64'b0;
		#10	enable = 1;

		//1test
		#10	in0 = 64'd32 ; 	in1 = 64'd16;
		#20	opcode = 2'b01;
		#20 opcode = 2'b10;

		//2test
		#10	in0 = 64'd32 ; 	in1 = 64'd16;
		#20	opcode = 2'b01;
		#20 opcode = 2'b10;

		//3test
		#10	in0 = 64'd32 ; 	in1 = 64'd16;
		#20	opcode = 2'b01;
		#20 opcode = 2'b10;

		//4test
		#10	in0 = 64'd32 ; 	in1 = 64'd16;
		#20	opcode = 2'b01;
		#20 opcode = 2'b10;

		#100 $stop;
	end

	always #10 clk = ~clk;

	ALU test0(	.enable(enable),
				.clk   (clk),
				.opcode(opcode),
				.in0   (in0),
				.in1   (in1),
				.out   (out)
				);
endmodule
