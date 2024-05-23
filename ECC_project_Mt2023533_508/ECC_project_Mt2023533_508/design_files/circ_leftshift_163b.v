module circ_leftshift_163b(
input [6:0] circ_shft_val,
input [162:0] circ_shft_inp,
output [162:0] circ_shft_out
);

wire [162:0]t1,t2,t3,t4,t5,t6,t7;

assign    t1=circ_shft_val[0]?{circ_shft_inp[161:0],circ_shft_inp[162]}:circ_shft_inp,  
		  
		  t2=circ_shft_val[1]?{t1[160:0],t1[162:161]}:t1,
		  
          t3=circ_shft_val[2]?{t2[158:0],t2[162:159]}:t2,

		  t4=circ_shft_val[3]?{t3[154:0],t3[162:155]}:t3,
		  
          t5=circ_shft_val[4]?{t4[146:0],t4[162:147]}:t4,
		  
		  t6=circ_shft_val[5]?{t5[130:0],t5[162:131]}:t5,
		  
		  t7=circ_shft_val[6]?{t6[98:0],t6[162:99]}:t6,
		  
          circ_shft_out=t7;  
endmodule