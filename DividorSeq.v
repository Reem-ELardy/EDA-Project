module DividorSeq #(parameter N=5) (
	input signed [N-1 : 0] a,b,
	output reg signed [N-1 : 0] m,r,
	input clk, rst,
	output reg error, valid, busy);

reg signed [N-1 : 0] Q, R;
reg signed [N-1 : 0] A, B, in1, in2;
reg [N-1 : 0] count;
reg play;
reg signed [2*N-1 : 0] Division;

assign play = 1'b0;

assign count = N + 1;

assign R = {N{1'b0}};

assign Division = {2*N{1'b0}};


always @(posedge clk)
begin
	if(rst && !busy)
	begin
		A = {N{1'b0}};
		B = {N{1'b0}};
		error = 1'b1;
	end

	else if(busy || valid)
	begin
		A = A;
		B = B;
		count = count;
	end

	else
	begin
		play = 1'b1;
		if(a < 0)
		begin
			A = ~a + 1'b1;
		end
		else
		begin
			A = a;
		end
		Division[2*N-1 : N] = {N{1'b0}};
		Division[N-1 : 0] = A;
		count = N +1;

		if(b < 0)
		begin
			B = ~b + 1'b1;
		end
		else
		begin
			B = b;
		end
		in1 = a;
		in2 = b;
	end
end

always @(posedge clk)
begin
	if(play)
	begin
		error = 1'b0;
		Division = Division;

		if(count == 1)
		begin
			valid = 1'b1;
			play = 1'b1;
			count = count - 1;
		end

		else if(count == 0)
		begin 
			valid = 1'b0;
			play = 1'b0;
			busy = 1'b0;
		end

		else if(b == 0)
		begin
			error = 1'b1;
			play = 1'b0;
			valid = 1'b0;
		end

		else
		begin
			valid = 1'b0;
			busy = 1'b1;
			Division = Division << 1;
			Division[2*N-1 : N] = Division[2*N-1 : N] - B;
		
			if(Division[2*N-1] == 1'b1)
			begin 
				Division[0] = 1'b0;
				Division[2*N-1 : N] = Division[2*N-1 : N] + B;
			end
			else
			begin
				Division[0] = 1'b1;
			end
		
		count = count - 1'b1;	
		end
	end

	else
	begin
		R = {N{1'b0}};
		Q = {N{1'b0}};
	end

	if(valid && ~ error)
	begin
		m = {N{1'b0}};
		r = {N{1'b0}};

		Q = Division[N-1 : 0];
		R = Division[2*N-1 : N];

		if(in1>0 && in2> 0)
		begin
			m = Q;
			r = R;
		end

		else if(in1>0 && in2<0)
		begin 
			m = ~Q + 1'b1;
			r = R;
		end

		else if(in1<0 && in2>0)
		begin
			m = ~Q + 1'b1;
			r = ~R + 1'b1;
		end

		else
		begin
			m = Q;
			r = ~R + 1'b1;
		end
	end

	else
	begin
		m = m;
		r = r;
	end

	if(error)
	begin
		m = {N{1'bx}};
		r = {N{1'bx}};
	end
end

endmodule
