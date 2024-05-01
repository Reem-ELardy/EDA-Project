module Multi_Divid_Comb #(parameter n = 5)(a, b, signal, m, r, error);
input signed [n-1 : 0] a, b;
input [1 : 0] signal;
output reg signed [n-1 : 0] m, r;
output reg error;


reg [n-1 :0] A , B; // internal reg to store 2's comp
//For Multiplication
reg signed [2*n-1:0] sum = 0; // internal reg to store output then divide it
integer i;

//For Division
reg signed [n-1 : 0] sub;
reg [n-1 : 0]Q, R;

always@(*)
begin 

m = {n{1'b0}};
r = {n{1'b0}};
error = 1'b0;
A = {n{1'b0}};
B = {n{1'b0}}; 

if(signal)
begin

	sum=0;
	m=0;
	r=0;
	if (a > 0 && b > 0)
	begin
	
		for (i=0 ; i<b ; i=i+1)
		begin 
			sum = sum +a;
		end
		m= sum [2*n-1:n];
		r= sum [n-1 :0];
	end
	
	if(a> 0 && b<0)
	begin
		B = ~b +1;
          	for (i=0 ; i<B ; i=i+1)
		begin 
		  	sum = sum +a;
		end
		sum = ~sum +1;
         	m= sum [2*n-1:n];
	   	r= sum [n-1 :0];
	end
	
	if(a<0 && b > 0)
	begin
		A = ~a +1;
          	for (i=0 ; i<b ; i=i+1)
		begin 
			sum = sum +A;
		end
		sum = ~sum +1;
		m= sum [2*n-1:n];
		r= sum [n-1 :0];
	end
	
	if (a < 0 && b < 0)
	begin
		B = ~b +1;
		A = ~a +1;
          	for (i=0 ; i<B ; i=i+1)
		begin 
		  	sum = sum + A;
		end
		   	m= sum [2*n-1:n];
		  	r= sum [n-1 :0];
	end	
end

else
begin

	error = 1'b0;
	Q = {n{1'b0}};

	if(a < 0)
		A = ~a + 1'b1;

	else
		A = a;

	sub = A;

	if(b < 0)
		B =~b + 1'b1;

	else
		B = b;



	if(b == 0)
		error = 1'b1;
	else 
	begin
		while(sub > 0)
		begin
			sub = sub - B;
			Q = Q + 1'b1;
		end

		if(sub == 0)
		begin
			sub = sub;
			R ={n{1'b0}};
			Q = Q;
		end

		else
		begin
			sub = sub + B;
			R = sub;
			Q = Q - 1'b1;
		end
	end

	if(!error)
	begin
		if(a>0 && b > 0)
		begin
			m = Q;
			r = R;
		end

		else if(a>0 && b<0)
		begin 
			m = ~Q +1'b1;
			r = R;
		end

		else if(a<0 && b>0)
		begin
			m = ~Q + 1'b1;
			r = ~R + 1;
		end

		else
		begin
			m = Q;
			r = ~R + 1'b1;
		end
	end

	else
	begin
		m = {n{1'bx}};
		r = {n{1'bx}};
	end
end

end
endmodule
