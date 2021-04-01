module alu32(sum,a,b,zout,gin);//ALU operation according to the ALU control line values
output [31:0] sum;
input [31:0] a,b; 
input [3:0] gin;//ALU control line
reg [31:0] sum;
reg [31:0] less;
output zout;
reg zout;
always @(a or b or gin)
begin
zout=0;
sum=a;
	case(gin)
	4'b0011:begin sum=a+1+(~b);		//bne
				zout=(|sum);	
			end				
	4'b1000:begin		//bgez
				zout=sum!=0 ? (sum[31]==0 ? 1:0):1;	
			end							
	4'b0100:begin 		//bgtz
				zout=sum!=0 ? (sum[31]==0 ? 1:0):0;	
			end							
	4'b1010:begin		//blez
				zout=sum!=0 ? (sum[31]==1 ? 1:0):1;	
			end							
	4'b1001:begin		//bltz
				zout=sum!=0 ? (sum[31]==1 ? 1:0):0;	
			end							
	4'b0010: sum=a+b; 				//ALU control line=0010, ADD
	4'b0110:begin sum=a+1+(~b);		//ALU control line=0110, SUB, beq
				zout=~(|sum);			
			end
	4'b0111: begin less=a+1+(~b);	//ALU control line=0111, set on less than
			if (less[31]) sum=1;	
			else sum=0;
		  end
	4'b0000: sum=a & b;				//ALU control line=0000, AND
	4'b0001: sum=a|b;				//ALU control line=0001, OR
	4'b1100: sum=~(a|b);			//ALU control line=1100, NOR
	default: sum=31'bx;	
	endcase
end
endmodule
