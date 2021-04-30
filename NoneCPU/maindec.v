module maindec	(
				input  opcode	,	
				                ,
				output jump     ,
				output regmem   ,
				output branch   ,
				output alusrc   ,
				output regdst   ,
				output regwrite ,
				output memwrite ,
				output aluopcode
				);
//译码器				
reg 	[8:0]	controls;

assign 			(
				opcode	 ,
				         ,
				jump     ,
				regmem   ,
                branch   ,
                alusrc   ,
                regdst   ,
                regwrite ,
                memwrite ,
                aluopcode
				)			= controls;
always @(*)
	case(opcode)
		6'b000000: controls <= 9'b110000010;	//rtyp
		6'b100011: controls <= 9'b101001000;  	//lw
		6'b101011: controls <= 9'b001010000;  	//sw
		6'b000100: controls <= 9'b000100001;  	//beq
		6'b001000: controls <= 9'b101000000;  	//addi
		6'b000010: controls <= 9'b000000100; 	 //j
		
		default  : controls <= 9'bxxxxxxxxx;
	endcase

endmodule