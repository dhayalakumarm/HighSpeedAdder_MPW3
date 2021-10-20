module adder_tb;
reg [17:0] in1, in2;
reg mode;
wire [18:0] out;

adder u1(
in1,in2,mode,out
);

initial
begin
mode=0;
	     in1 = 10; in2 = 16;
	#20; in1 = 50; in2 = 34; 
	#20; in1 = 110; in2 = 45;
	#20; in1 = 2000; in2 = 4535;

end

initial 
begin
	$dumpfile("add.vcd");
	$dumpvars(0, adder_tb);
	$monitor("time = %2d, in1 = %d, in2 = %d, out = %d", $time, in1, in2, out);
end

endmodule