module controller	(
					input	[]	opcode		,
					input		zero		,
					output		jump		,
					output		pcsrc		,
					output		regmem      ,
					output		alusrc      ,
					output		regdst      ,
					output		regwrite    ,
					output		memwrite    ,
					output		alucontrol  
					);
					
wire	[1:0]	aluopcode	;
wire			branch		;

maindec		md	(
				opcode
				
				jump				
				regmem
				branch
				alusrc				
				regdst
				regwrite
				memwrite
				aluopcode
				);
				
aludec		ad	(
				func		,
				aluopcode	,
				alucontrol
				);
				
assign	pcsrc = branch & zero ;

endmodule