 // 3Bit Karatsuba Multiplier Module

module ks3(
	a,
	b,
	y
	);

input [2:0] a;
input [2:0] b;

output [4:0] y;

reg [4:0] y;

always @(a,b)
begin
	y[0] = (a[0] & b[0]);
	y[1] = (a[1] & b[1]) ^ (a[0] & b[0]) ^ ((a[0] ^ a[1]) & (b[0] ^ b[1]));
	y[2] = (a[1] & b[1]) ^ (a[0] & b[0]) ^ (a[2] & b[2]) ^ ((a[0] ^ a[2]) & (b[0] ^ b[2]));
	y[3] = (a[1] & b[1]) ^ (a[2] & b[2]) ^ ((a[1] ^ a[2]) & (b[1] ^ b[2]));
	y[4] = (a[2] & b[2]);
end

endmodule