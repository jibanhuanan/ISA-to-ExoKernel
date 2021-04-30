module ALU(	enable,
			clk,
			opcode,
			in0,
			in1,
			out
			);
			input  					 enable;
			input  					 clk;
			input  		  [1    : 0] opcode;
			input  signed [64-1 : 0] in0;
			input  signed [64-1 : 0] in1;
			output signed [64   : 0] out;
			
			reg signed [64 : 0] out;

parameter ADD = 2'b00, SUB = 2'b01, COMPARE = 2'b10;

always @(posedge clk)
begin
	if(enable)
	begin
		casex(opcode)
			ADD: 	 out <= in0 + in1;										
			SUB: 	 out <= in0 - in1;									
			COMPARE: out <= (in0 > in1) ? 1 :	((in0 == in1) ? 0 : 2);
			default: out <= 0;
		endcase
	end
end

endmodule




