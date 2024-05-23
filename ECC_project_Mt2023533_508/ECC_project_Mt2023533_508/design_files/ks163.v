module ks163(
	a,
	b,
	y
	);

input [162:0] a;
input [162:0] b;
output [324:0] y;

wire [242:0] aa;
wire [242:0] bb;

assign aa = {80'b0,a};
assign bb = {80'b0,b};

wire [80:0] a0,a1,a2;
wire [80:0] b0,b1,b2;
wire [160:0] p0,p1,p2,p3,p4,p5;

assign a0 = aa[80:0];
assign b0 = bb[80:0];
assign a1 = aa[161:81];
assign b1 = bb[161:81];
assign a2 = aa[242:162];
assign b2 = bb[242:162];
ks81 KA_81bit_mod_0 (.a(a0),.b(b0),.y(p0));

ks81 KA_81bit_mod_1 (.a(a1),.b(b1),.y(p1));

ks81 KA_81bit_mod_2 (.a((a0 ^ a1 )),.b((b0 ^ b1) ),.y(p2));

ks81 KA_81bit_mod_3 (.a(a2),.b(b2),.y(p3));

ks81 KA_81bit_mod_4 (.a((a0 ^ a2 )),.b((b0 ^ b2)),.y(p4));

ks81 KA_81bit_mod_5 (.a((a2 ^ a1 )),.b((b2 ^ b1)),.y(p5));

overlap_243bit ov_mod ( .p0(p0),.p1(p1),.p2(p2),.p3(p3),.p4(p4),.p5(p5),.y(y));
endmodule


