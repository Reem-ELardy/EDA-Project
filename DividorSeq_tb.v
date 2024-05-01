module DividorSeq_tb();
localparam N = 5;
reg signed [N-1 : 0] a, b;
wire error, valid, busy;
wire signed [N-1 : 0] m, r;
reg clk, rst;


reg [N-1 : 0] totaltest, paateset;
assign totaltest = {N{1'b0}};
assign paateset = {N{1'b0}};

//Instantiate the module
DividorSeq #(N) d1 (a, b, m, r, clk, rst, error, valid, busy);

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
	a = 5'b01101;
	b = 5'b00010;
	totaltest = totaltest + 1'b1;
	
	// Wait for valid output
    	@(posedge clk);
    	while (!valid) @(posedge clk);

	if(m == 6 && r == 1) paateset = paateset + 1'b1;

	a = 5'b01010;
	b = 5'b11101;
	totaltest = totaltest + 1'b1;

	// Wait for valid output
    	@(posedge clk);
    	while (!valid) @(posedge clk);

	if(m == -3 && r == 1) paateset = paateset + 1'b1;

	a = 5'b11001;
	b = 5'b00010;
	totaltest = totaltest + 1'b1;

	// Wait for valid output
    	@(posedge clk);
    	while (!valid) @(posedge clk);

	if(m == -3 && r == -1) paateset = paateset + 1'b1;

	a = 5'b10010;
	b = 5'b11101;
	totaltest = totaltest + 1'b1;

	// Wait for valid output
    	@(posedge clk);
    	while (!valid) @(posedge clk);

	if(m == 4 && r == -2) paateset = paateset + 1'b1;

	a = 5'b01101;
	b = 5'b0;
	totaltest = totaltest + 1'b1;

	// Wait for valid output
    	@(posedge clk);
    	while (!error) @(posedge clk);

	if(m != 0 && r != 0 && m != 1 && r != 1) paateset = paateset + 1'b1;

	a = 5'b0;
	b = 5'b00010;
	totaltest = totaltest + 1'b1;
	
	@(posedge clk);
    	while (!valid) @(posedge clk);

	if(m == 0 && r == 0) paateset = paateset + 1'b1;

	$display("Total static test cases: %d \t, Passes test case: %d \t", totaltest, paateset);

	repeat(30) begin

	a = $signed($random)%15;
	b = $signed($random)%15;
	@(posedge clk);
    	while (!valid) @(posedge clk);

	end
	
	#300;
	$finish;

end 
endmodule
