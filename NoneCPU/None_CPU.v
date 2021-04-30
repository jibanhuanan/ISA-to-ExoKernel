module None	(
			input  clk      , 
			input  reset,
			input  instr    ,
			input  readdata ,
			
			output pc       ,
			output memwrite ,
			output aluout   ,
			output writedata
			);
wire    		alusrc  ,
				branch  ,
				regdst  ,
				regwrite,
				regmem  ,
				jump    ;
		
wire	[2:0]	alucontrol;

controller cu	(
				instr[]	  ,
			
				zero	  ,
			
				jump	  ,
				pcsrc	  ,
				regmem	  ,			
				alusrc	  ,
				regdst	  ,
				regwrite  ,
				memwrite  ,
				alucontrol
				);

datapath dp	(
			clk			,
			reset       ,
			
			jump        ,
			instr       ,
			pcsrc       ,
			alusrc      ,
			regdst      ,
			regmem      ,
			readdata    ,
			regwrite    ,
			alucontrol	,
			
			pc          ,
			zero        ,			
			aluout      ,
			writedata   ,
			  
			);

endmodule