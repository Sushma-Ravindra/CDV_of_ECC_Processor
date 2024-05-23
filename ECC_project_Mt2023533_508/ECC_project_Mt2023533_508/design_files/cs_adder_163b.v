module cs_adder_163b(

input [162:0]adder_in1 , adder_in2,
output [162:0] adder_out


);



assign adder_out[162:0] = adder_in1[162:0] ^ adder_in2[162:0];



endmodule