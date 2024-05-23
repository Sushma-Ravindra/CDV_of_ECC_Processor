module overlap_27bit(p0,p1,p2,p3,p4,p5,y);
input [16:0] p0,p1,p2,p3,p4,p5;
output [52:0] y;

assign y[8:0] = p0[8:0];
assign y[16:9] = p0[16:9]^p0[7:0]^p1[7:0]^p2[7:0];
assign y[17] = p0[8]^p1[8]^p2[8];
assign y[25:18] = p0[16:9]^p1[16:9]^p2[16:9]^p0[7:0]^p1[7:0]^p3[7:0]^p4[7:0];
assign y[26] = p0[8]^p1[8]^p3[8]^p4[8];
assign y[34:27] = p0[16:9]^p1[16:9]^p3[16:9]^p4[16:9]^p1[7:0]^p3[7:0]^p5[7:0];
assign y[35] = p1[8]^p5[8]^p3[8];
assign y[43:36] = p1[16:9]^p5[16:9]^p3[16:9]^p3[7:0];
assign y[52:44] = p3[16:8];

endmodule

 