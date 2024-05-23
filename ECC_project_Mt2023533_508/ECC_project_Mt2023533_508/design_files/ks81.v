 // KaratSuba for 81Bit
module ks81(
	a,
	b,
	y
	);

input [80:0] a;
input [80:0] b;
output [160:0] y;

wire [80:0] aa;
wire [80:0] bb;

assign aa = {0'b0,a};
assign bb = {0'b0,b};

wire [26:0] a0,a1,a2;
wire [26:0] b0,b1,b2;
wire [52:0] p0,p1,p2,p3,p4,p5;

assign a0 = aa[26:0];
assign b0 = bb[26:0];
assign a1 = aa[53:27];
assign b1 = bb[53:27];
assign a2 = aa[80:54];
assign b2 = bb[80:54];
ks27 KA_27bit_mod_0 (.a(a0),.b(b0),.y(p0));

ks27 KA_27bit_mod_1 (.a(a1),.b(b1),.y(p1));

ks27 KA_27bit_mod_2 (.a((a0 ^ a1 )),.b((b0 ^ b1) ),.y(p2));

ks27 KA_27bit_mod_3 (.a(a2),.b(b2),.y(p3));

ks27 KA_27bit_mod_4 (.a((a0 ^ a2 )),.b((b0 ^ b2)),.y(p4));

ks27 KA_27bit_mod_5 (.a((a2 ^ a1 )),.b((b2 ^ b1)),.y(p5));

overlap_81bit ov_mod ( .p0(p0),.p1(p1),.p2(p2),.p3(p3),.p4(p4),.p5(p5),.y(y));
endmodule

