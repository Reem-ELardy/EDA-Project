module seqMult #(parameter N=5)( input clk,
    input rst, input signed [N-1:0] a, b,
    output reg signed [N-1:0] m, r,
    output reg valid,
    output reg busy);

reg [2*N-1:0]sum;
reg [N-1:0] m_reg ,r_reg;
reg valid_reg =0;
reg busy_reg =0;
reg [N-1:0] count  ;
reg [2*N-1:0]a_reg ,b_reg;
reg flag=0;


assign m= m_reg;
assign r= r_reg;
assign valid= valid_reg;
assign busy= busy_reg;

always @(negedge rst)
begin
      a_reg ={N{1'b0}};
      b_reg ={N{1'b0}};
end 
always @(posedge clk)
begin 
if(!busy && !valid)
begin
if(b<0)
begin
b_reg= -b;
end 
else
begin
b_reg =b;
end
count =0;
while (b_reg != 0)
        begin
            b_reg = b_reg >> 1;
            count = count + 1;
        end
end
if (flag)
begin
if(a < 0)
		begin
			a_reg = -a;
		end
		else
		begin
			a_reg = a;
		end
if(b < 0)
		begin
			b_reg = -b;
		end
		else
		begin
			b_reg = b;
		end

end
end 
always @(posedge clk)
begin 

if (!rst)
begin 
//valid_reg = {N{1'b0}}; 
//busy_reg = {N{1'b1}}; 
//m_reg= {N{1'b0}}; 
//r_reg= {N{1'b0}}; 


case (valid)
      1'b0: begin

valid =1'b1;
sum =1'b0;
flag=1;
end

1'b1 : begin

if (b_reg[0] ==1)
begin
sum = sum +a_reg;
end
count = count -1;
a_reg = a_reg << 1;
b_reg = b_reg >>1;
flag =0;
end
endcase
if (count ==0)
begin 
valid_reg = 1;
busy_reg =0;
{m_reg , r_reg }= sum ;

if (a> 0 && b>0)
begin 
 m_reg = sum [2*N-1:N];
r_reg= sum [N-1:0];
end

if (a> 0 && b<0)
begin 
sum = ~sum +1;
m_reg= sum [2*N-1:N];
r_reg = sum[N-1:0];
end
if (a < 0 && b>0)
begin 
sum = ~sum +1;
m_reg= sum [2*N-1:N];
r_reg = sum[N-1:0];
end
if (a <0 && b<0)
begin 
m_reg = sum [2*N-1:N];
r_reg= sum [N-1:0];
end

end 



end
end 
endmodule
