module	datapath	(
					input			clk				,
					input			reset       	,
					input			            	
					input			jump        	,
					input	[31:0]	instr       	,
					input			pcsrc       	,
					input			alusrc      	,
					input			regdst      	,
					input			regmem      	,
					input	[31:0]	readdata    	,
					input			regwrite    	,
					input	[ 2:0]	alucontrol		,
													
					output	[31:0]	pc          	,
					output			zero        	,			
					output	[31:0]	aluout      	,
					output	[31:0]	writedata
					);
					
wire	[ 4:0]		writereg;
wire	[31:0]		pcnext 	, pcnextbr 	, pcplus4 	, pcbranch	;
wire	[31:0]		signimm , signimmsh ;
wire	[31:0]		srca	, srcb		;
wire	[31:0]		result	;

//next pc logic
flopr 	#(32)		pcreg	(
							clk		,
							reset	,
							pcnext	,
							pc
							);	

adder				pcadd1	(
							pc		,
							32'b100	,
							pcplus4
							);

s12					immsh	(
							signimm	,
							signimmsh
							);

adder				pcadd2	(
							pcplus4		,
							signimmsh	,
							pcbranch
							);

mux2	#(32)		pcbrmux	(
							pcplus4		,
							signimmsh	,
							pcbranch
							);	

mux2	#(32)		pcmux	(
							pcnextbr	,
							(
							pcplus4[31:28]	,
							instr[25:0]		,
							2'b00
							)				,
							jump			,
							pcnext
							);	

regfile				rf		(
							clk			,
							regwrite	,
							instr[25:21],
							instr[20:16],
							writereg	,
							result		,
							srca		,
							writedata
							);
							
mux2	#(5)		wrmux	(
							instr[25:16],
							input[15:11],
							regdst		,
							writereg
							);

mux2	#(32)		resmux	(
							aluout		,
							readdata	,
							regmem		,
							result
							);
							
signext				se		(
							instr[15:0]	,
							signimm
							);

mux2	#(32)		srcbmux	(
							writedata	,
							signimm		,
							alusrc		,
							srcb
							);
							
alu					alu		(
							srca		,
							srcb		,
							alucontrol	,
							aluout		,
							zero
							);

endmodule







