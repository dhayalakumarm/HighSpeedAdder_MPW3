module gls;
reg [17:0] p, q;
reg mode;
wire [18:0] sum;

adder u1(
p,q,mode,sum
);

initial
begin
mode=0;
	     p = 10; q = 16;
	#20; p = 50; q = 34; 
	#20; p = 110; q = 45;
	#20; p = 2000; q = 4535;

end

initial 
begin
	$dumpfile("add_syn.vcd");
	$dumpvars(0, gls);
	$monitor("time = %2d, p = %d, q = %d, sum = %d", $time, p, q, sum);
end

endmodule