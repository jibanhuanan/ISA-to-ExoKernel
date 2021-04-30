//Decoderu_D1(A4,F16);    //u_D1使用默认参数，Width为1，Polarity为1
//Decode #(4,0) u_D2(A4,F16);   //u_D2的Width为4，Polarity为0
//#（4,0）这个参数改变方法是内容对应于被引用的module的，参数的改变还可以像module的引用一样使用”.”：
//module_name #( .parameter_name(para_value),.parameter_name(para_value)) inst_name (port map);

//可复位触发器

module	flopr	#(parameter WIDTH = 8)
				(
				input					clk		,
				input					reset	,
				input		[WIDTH-1:0]	d		,
				output	reg	[WIDTH-1:0]	q
				);
				
	always @	(posedge clk , posedge reset)
		if(reset)	q <= 0 ;
		else		q <= d	;

endmodule