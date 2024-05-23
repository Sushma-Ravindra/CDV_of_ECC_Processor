module multiplier_163b(
input [162:0]mult_in1,mult_in2,

output [162:0] mult_out
    );
  wire [324:0] d;  
    
    ks163 k1(.a(mult_in1),.b(mult_in2),.y(d));
    red r1(.D(d),.r(mult_out));
    
    
    
    
endmodule
