
module adder(p, q, mode, sum);

parameter num = 18;

output [num:0] sum;
input [num-1:0] p,q;
input mode;

wire [num:0] temp, temp1;

`ifdef DSPoperator
wire [num:0] temp2, temp3;
    assign temp2[num:0] = p[num-1] ? -{2'b0, p[num-2:0]}:{1'b0,p};
    assign temp3[num:0] = q[num-1] ? -{2'b0, q[num-2:0]}:{1'b0,q};
    assign temp[num:0] = mode ? temp2-temp3 : temp2+temp3;
`else
    wire [2*num+1:0] x [0:$clog2(num+1)];
    wire [num:0] a1, b1, a, b;

    assign a1 = {(num+1){p[num-1]}}^{2'b0, p[num-2:0]};
    assign b1 = {(num+1){mode^q[num-1]}}^{2'b0, q[num-2:0]};
    assign a[0] = a1[0];
    assign b[0] = b1[0];
    assign b[1] = p[num-1]&(q[num-1]^mode);
    assign a[num] = a1[num]^b1[num];

    assign x[0][1:0]={2{p[num-1]^q[num-1]^mode}};  					// Input carry

    genvar i, j;
    generate
    begin:ha_fa			//halfadder
        for(i=1; i<num; i=i+1) begin
        halfadd t0({a1[i],b1[i]}, a[i], b[i+1]);
        end
    end

    begin: kgp_gen		// kgp generation
        for (i=0; i<num; i=i+1) begin
        kgp t(a[i], b[i], x[0][2*i+3:2*i+2]);
        end
    end
    begin:recursiveStg	//recursive
        for (i=0; i<$clog2(num+1); i=i+1)
        begin
        assign x[i+1][(2**(i+1))-1:0]=x[i][(2**(i+1))-1:0];
            for(j=(2**(i+1)); j<2*num+1; j=j+2)
            begin
            recursive_stage1 s(x[i][j+1-(2**(i+1)):j-(2**(i+1))],x[i][j+1:j],x[i+1][j+1:j]);		
            end
        end
    end
    begin:addition		// SUM Calculation
        for(i=0; i<num+1; i=i+1) begin
        assign temp[i] = a[i]^b[i]^x[$clog2(num)][2*i];
        end
    end
    endgenerate
`endif
    assign temp1 = -temp;
    assign sum = temp[num] ? ({temp[num], temp1[num-1:0]}) : (temp);

endmodule

`ifdef DSPoperator

`else

    module kgp(a,b,y);

    input a,b;						output [1:0] y;

    assign y[0]=a | b;
    assign y[1]=a & b;

    endmodule



    module recursive_stage1(a,b,y);

    input [1:0] a,b;				output [1:0] y;

    wire [1:0] y;
    wire b0;
    not n1(b0,b[1]);
    wire f,g0,g1;
    and a1(f,b[0],b[1]);
    and a2(g0,b0,b[0],a[0]);
    and a3(g1,b0,b[0],a[1]);

    or o1(y[0],f,g0);
    or o2(y[1],f,g1);

    endmodule

    module halfadd(x, sum, carry);

output sum,carry;
input [1:0] x;

	assign	 sum = x[1] ^ x[0];
	assign 	 carry = x[1] & x[0];
	
endmodule



module fulladd(x, sum, carry);

output sum,carry;
input [2:0] x;

wire w;	
	assign 	 w = x[2] ^ x[1];
        assign	 sum = w ^ x[0];
	assign 	 carry = (x[2] & x[1])|(w & x[0]);
endmodule
`endif

