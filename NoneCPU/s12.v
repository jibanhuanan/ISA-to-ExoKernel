module		s12	(
				input	[31:0]	a,
				output	[31:0]	y			
				);
				
	assign	y = {a[29:0]	,	2'b00}	;

endmodule