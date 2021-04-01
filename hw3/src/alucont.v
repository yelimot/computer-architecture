module alucont(branch2,branch1,branch0,aluop2,aluop1,aluop0,f3,f2,f1,f0,gout); //Figure 4.12 
input branch2,branch1,branch0,aluop2, aluop1, aluop0, f3, f2, f1, f0;
output [3:0] gout;
reg [3:0] gout;
always @(branch2 or branch1 or branch0 or aluop2 or aluop1 or aluop0 or f3 or f2 or f1 or f0)
begin
if((~branch2)&(~(branch1))&(branch0)) gout = 4'b0110; // beq
if((~branch2)&(branch1)&(~(branch0))) gout = 4'b0011; // bne
if((~branch2)&(branch1)&(branch0)) gout = 4'b1000; // bgez
if((branch2)&(~(branch1))&(~(branch0))) gout = 4'b0100; // bgzt
if((branch2)&(~(branch1))&(branch0)) gout = 4'b1010; // blez
if((branch2)&(branch1)&(~(branch0))) gout = 4'b1001; // bltz
if(~(aluop2|aluop1|aluop0)) gout = 4'b0010;		// lw&sw
if((~(aluop2)&aluop1&aluop0)) gout = 4'b0010;   // addi 
if(aluop2&~(aluop1)&aluop0) gout = 4'b0001;		// ori
if(aluop2&~(aluop1)&~(aluop0)) gout = 4'b0000;  // andi
if(~(aluop2)&aluop1&~(aluop0))	//R-type
begin
	if (~(f3|f2|f1|f0))gout=4'b0010; 		//function code=0000, ALU control=0010 (add)
	if (f1&f3)gout=4'b0111;					//function code=1x1x, ALU control=0111 (set on less than)
	if (f1&~(f3))gout=4'b0110;				//function code=0x10, ALU control=0110 (sub)
	if (f2&f0)gout=4'b0001;					//function code=x1x1, ALU control=0001 (or)
	if (f2&~(f0))gout=4'b0000;				//function code=x1x0, ALU control=0000 (and)
	if ((~f3)&f2&f1&f0)gout=4'b1100;		//function code=0111, ALU control=1100 (nor)
	if (f3&(~f2)&(~f1)&(~f0))gout=4'b1000;	//function code=1000, ALU control=1000 (jr)
end
end
endmodule