module Multi_Divid_Comb_tb();
localparam N = 5;
reg signed [N-1 : 0] a, b;
reg [1 : 0]signal;
wire error;
wire signed [N-1 : 0] m, r;


reg [N-1 : 0] totaltest, paateset;
assign totaltest = {N{1'b0}};
assign paateset = {N{1'b0}};

//Instantiate the module
Multi_Divid_Comb #(N) md1 (a, b, signal, m, r, error);


//Test Cases
initial
begin
	// Division running


	signal = 00;

	a = 5'b01101;
	b = 5'b00010;
	totaltest = totaltest + 1'b1;
	#50;
	if(m == 6 && r == 1) paateset = paateset + 1'b1;
	
	#50;

	a = 5'b01010;
	b = 5'b11101;
	totaltest = totaltest + 1'b1;
	#50;
	if(m == -3 && r == 1) paateset = paateset + 1'b1;

	#50;

	a = 5'b11001;
	b = 5'b00010;
	totaltest = totaltest + 1'b1;
	#50;
	if(m == -3 && r == -1) paateset = paateset + 1'b1;

	#50;

	a = 5'b10010;
	b = 5'b11101;
	totaltest = totaltest + 1'b1;
	#50;
	if(m == 4 && r == -2) paateset = paateset + 1'b1;

	#50;

	a = 5'b01101;
	b = 5'b0;
	totaltest = totaltest + 1'b1;
	#50;
	if(m != 0 && r != 0 && m != 1 && r != 1) paateset = paateset + 1'b1;

	#50;

	a = 5'b0;
	b = 5'b00010;
	totaltest = totaltest + 1'b1;
	#50;
	if(m == 0 && r == 0) paateset = paateset + 1'b1;

	#50;
	
	//Multiplication running
	signal = 01;

	a = 5'b11010;
	b = 5'b00111;
	totaltest = totaltest + 1'b1;
	#50;
	if(m == -2 && r == -10) paateset = paateset + 1'b1;

	#50;

	a = 5'b00000;
	b = 5'b00011;
	totaltest = totaltest + 1'b1;
	#50;
	if(m == 0 && r == 0) paateset = paateset + 1'b1;

	#50;

	a = 5'b11010;
	b = 5'b11001;
	totaltest = totaltest + 1'b1;
	#50;
	if(m == 1 && r == 10) paateset = paateset + 1'b1;

	#50;

	a = 5'b00101;
	b = 5'b00011;
	totaltest = totaltest + 1'b1;
	#50;
	if(m == 0 && r == 15) paateset = paateset + 1'b1;

	#50;

	a = 5'b00101;
	b = 5'b11101;
	totaltest = totaltest + 1'b1;
	#50;
	if(m == -1 && r == -15) paateset = paateset + 1'b1;

	#50;
	
	a = 5'b00101;
	b = 5'b00000;
	totaltest = totaltest + 1'b1;
	#50;
	if(m == 0 && r == 0) paateset = paateset + 1'b1;

	#50;
	

	$display("Total static test cases: %d \t, Passes test case: %d \t", totaltest, paateset);

	repeat(30) 
	begin
		#50;
		signal = ($random)%2 - 1'b1;
		a = $signed($random)%15;
		b = $signed($random)%15;
		#50;
	end

	#50;
	$finish;

end 
endmodule
