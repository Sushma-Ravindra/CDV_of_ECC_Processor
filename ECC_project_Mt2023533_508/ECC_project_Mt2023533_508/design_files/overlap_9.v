
module overlap_9bit(p0,p1,p2,p3,p4,p5,y);
input [4:0] p0,p1,p2,p3,p4,p5;
output [16:0] y;

assign y[2:0] = p0[2:0];
assign y[4:3] = p0[4:3]^p0[1:0]^p1[1:0]^p2[1:0];
assign y[5] = p0[2]^p1[2]^p2[2];
assign y[7:6] = p0[4:3]^p1[4:3]^p2[4:3]^p0[1:0]^p1[1:0]^p3[1:0]^p4[1:0];
assign y[8] = p0[2]^p1[2]^p3[2]^p4[2];
assign y[10:9] = p0[4:3]^p1[4:3]^p3[4:3]^p4[4:3]^p1[1:0]^p3[1:0]^p5[1:0];
assign y[11] = p1[2]^p5[2]^p3[2];
assign y[13:12] = p1[4:3]^p5[4:3]^p3[4:3]^p3[1:0];
assign y[16:14] = p3[4:2];

endmodule

