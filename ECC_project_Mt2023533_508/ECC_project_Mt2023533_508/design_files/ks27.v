
 // KaratSuba for 27Bit
module ks27(
	a,
	b,
	y
	);

input [26:0] a;
input [26:0] b;
output [52:0] y;

wire [26:0] aa;
wire [26:0] bb;

assign aa = {0'b0,a};
assign bb = {0'b0,b};

wire [8:0] a0,a1,a2;
wire [8:0] b0,b1,b2;
wire [16:0] p0,p1,p2,p3,p4,p5;

assign a0 = aa[8:0];
assign b0 = bb[8:0];
assign a1 = aa[17:9];
assign b1 = bb[17:9];
assign a2 = aa[26:18];
assign b2 = bb[26:18];
ks9 KA_9bit_mod_0 (.a(a0),.b(b0),.y(p0));

ks9 KA_9bit_mod_1 (.a(a1),.b(b1),.y(p1));

ks9 KA_9bit_mod_2 (.a((a0 ^ a1 )),.b((b0 ^ b1) ),.y(p2));

ks9 KA_9bit_mod_3 (.a(a2),.b(b2),.y(p3));

ks9 KA_9bit_mod_4 (.a((a0 ^ a2 )),.b((b0 ^ b2)),.y(p4));

ks9 KA_9bit_mod_5 (.a((a2 ^ a1 )),.b((b2 ^ b1)),.y(p5));

overlap_27bit ov_mod ( .p0(p0),.p1(p1),.p2(p2),.p3(p3),.p4(p4),.p5(p5),.y(y));
endmodule

