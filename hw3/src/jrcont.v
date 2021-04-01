module jrcont (out, i0, i1, gout);
output [31:0] out;
input [31:0] i0,i1;
input [3:0] gout;
reg scontrol;
reg [31:0] registerfile[0:31];

always @(gout)
begin
if (gout == 4'b1000)
	scontrol = 1'b1;
else
	scontrol = 1'b0;
end
assign out = scontrol ? i1:i0;
endmodule