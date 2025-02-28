module MultiSeq_tb();
localparam N = 5;
reg signed [N-1 : 0] a, b;
wire error, valid, busy;
wire signed [N-1 : 0] m, r;
reg clk, rst;


reg [N-1 : 0] totaltest, paateset;
assign totaltest = {N{1'b0}};
assign paateset = {N{1'b0}};

//Instantiate the module
seqMult #(N) m1(clk, rst, a, b, m, r, valid, busy);


//clk generator
always begin
    clk = 1;
    #(50);
    clk = 0;
    #(50);
end

//reset generator
initial
begin
	rst = 1;
	#(90);
	rst = 0;
end

initial
begin
	a = 5'b11010;
	b = 5'b00111;
	totaltest = totaltest + 1'b1;
	
	// Wait for valid output
    	#400;

	a = 5'b11010;
	b = 5'b00111;

	if(m == -2 && r == -10) paateset = paateset + 1'b1;
	// Wait for valid output
    	#400;

	/*if(m == 0 && r == 0) paateset = paateset + 1'b1;

	a = 5'b11010;
	b = 5'b11001;
	totaltest = totaltest + 1'b1;

	// Wait for valid output
    	#200;

	if(m == 1 && r == 10) paateset = paateset + 1'b1;

	a = 5'b00101;
	b = 5'b00011;
	totaltest = totaltest + 1'b1;

	// Wait for valid output
    	#200;

	if(m == 0 && r == 15) paateset = paateset + 1'b1;

	a = 5'b00101;
	b = 5'b11101;
	totaltest = totaltest + 1'b1;

	// Wait for valid output
    	#200;

	if(m == -1 && r == -15) paateset = paateset + 1'b1;

	a = 5'b00101;
	b = 5'b00000;
	totaltest = totaltest + 1'b1;
	
	#200;

	if(m == 0 && r == 0) paateset = paateset + 1'b1;*/

	$display("Total static test cases: %d \t, Passes test case: %d \t", totaltest, paateset);

	
	#300;
	$finish;

end 
endmodule
