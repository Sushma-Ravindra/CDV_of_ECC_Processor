`timescale 1ns/1ps

interface ACUif;
  logic [162:0]a,b,xp,yp,k;
  logic [162:0]xq,yq;
  logic clk;
  logic rst;
  
  covergroup cg @(posedge clk);
    option.per_instance = 1;
    cp_a: coverpoint a;
    cp_b: coverpoint b;
    cp_k: coverpoint k;
    cp_xp: coverpoint xp;
    cp_yp: coverpoint yp;
    cp_xq: coverpoint xq;
    ycp_yq: coverpoint yq;
    cp_axcp_b:cross a,b;
 	cp_xpxcp_yp:cross xp,yp;
  endgroup
  
  cg cg_inst = new();
endinterface


class transaction;
  randc bit [162:0]a,b,xp,yp,k;
	bit clk;
    bit rst;
    bit [162:0]xq,yq;
  function void display(input string tag);
    $display("[%s]\t a = %4b  \t b=%4b \t k=%4b \t xp=%4b \t yp =%4b @\t xq=%4b \t yq =%4b  %0t", tag,a,b,k,xp,yp,xq,yq, $time);    
  endfunction
  
  function transaction copy();
    copy = new();
    copy.clk = this.clk;
    copy.rst = this.rst;
     copy.a = this.a;
     copy.b = this.b;
     copy.k = this.k;
     copy.xp = this.xp;
     copy.yp = this.yp;
     copy.xq = this.xq;
	copy.yq = this.yq;
  endfunction
endclass




class generator;
  transaction tr;
  mailbox #(transaction) mbx;
  
  int count = 200;
  event next, done;
  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
    tr = new();
  endfunction
  
  task run();
    repeat(count) begin
      assert(tr.randomize());
      mbx.put(tr.copy);
      tr.display("GENERATOR");
      @next;
    end
    ->done;
  endtask
endclass





class driver;
  mailbox #(transaction) mbx;
  transaction datac;
  virtual ACUif acif;
  
  function new(mailbox #(transaction) mbx);
  	this.mbx = mbx;
  endfunction
  
  task reset();
    acif.a <= 0;
      acif.b <= 0;
     acif.k <= 0;
      acif.xp <= 0;
      acif.yp <= 0;
      acif.xq <= 0;
      acif.yq <= 0;
    #10;
  endtask
  
  task run();
    forever begin
      mbx.get(datac);
      datac.display("DRIVER");
      acif.a <= datac.a;
	  acif.b <= datac.b;
      acif.k <= datac.k;
      acif.xp <= datac.xp;
      acif.yp <= datac.yp;
      acif.xq <= datac.xq;
      acif.yq <= datac.yq;
      #10;
    end
  endtask
endclass


class monitor;
  mailbox #(transaction) mbx;
  transaction tr;
  virtual ACUif acif;

  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    tr = new();
    forever begin
      #10;
      tr.a = acif.a;
      tr.b = acif.b;
      tr.k = acif.k;
      tr.xp = acif.xp;
      tr.yp = acif.yp;
      tr.xq = acif.xq;
      tr.yq = acif.yq;
      mbx.put(tr);
      tr.display("MONITOR");
    end
  endtask
  
endclass


class scoreboard;
  mailbox #(transaction) mbx;
  transaction tr;
  event next;
  bit [162:0]xq,yq;
  
  task  func(input clk,rst, input [162:0]a,b,k,xp,yp ,output [162:0] xq,yq);

reg [162:0] X1,X2,Z1,Z2;
reg [162:0] V3b,V2b,V1b,V3a,V2a,V1a,V1,V2,V3,R1,R2,R3,R3a,R3b,R3c,temp_X1,temp_X2,temp_Z1,temp_Z2,t_Z2;
reg [162:0] init_X2,init_Z2,init_X2a;
reg [7:0]count;
     reg [162:0]rem1_V1;
    reg [162:0] v_v1,v_v2,v_v3;
	reg [162:0] r_V2,r_R3,r_V1,r_V3,rem_V2,re_V2;
	reg [162:0] s_R3; 
        reg [162:0] rem1_V2,rem2_V2;
    init_Z2=func11(xp,xp);
	init_X2=func11(init_Z2,init_Z2);
    init_X2a=func14(init_X2,b);
    
 
    V1=func11(X1,Z2);
    V2=func11(X2,Z1);
    V3=func11(X1,Z1);
    R3=func11(Z1,Z1);
    R3a=func11(R3,R3);
    t_Z2=func14(V1,V2);
    temp_Z2=func11(t_Z2,t_Z2);
    temp_Z1=func11(V3,V3);
    V1a=func11(V1,V2);
    V2a=func11(xp,temp_Z2);
    V3a=func11(b,R3);
    R3b=func11(X1,X1);
    R3c=func11(R3,R3);
    temp_X2=func14(V1a,V2a);
    temp_X1=func14(V3a,R3c);
    
    
    if (rst ) begin
        count = 8'b0;
        X1 = xp;
        Z1 = 163'b1;
        X2 = init_X2a;
        Z2 = init_Z2;
    end else if (clk) begin
        if (count <= 8'b10100001) begin
            if (k[count] == 1'b1) begin
                X1 = temp_X2;
                X2 = temp_X1;
                Z1 = temp_Z2;
                Z2 = temp_Z1;
            end else if (k[count] == 1'b0) begin
                X1 = temp_X1;
                X2 = temp_X2;
                Z1 = temp_Z1;
                Z2 = temp_Z2;
            end
            count = count + 1;
        end
    end

    v_v1=func13(Z1);
    v_v2=func13(Z2);
    v_v3=func13(xp);
    R1=func11(X1,V1);
    r_V2=func11(X2,v_v2);
    s_R3=func11(xp,xp);
    r_R3=func14(s_R3,yp);
    r_V1=func14(xp,R1);
    re_V2=func14(xp,r_V2);
   
    rem1_V1=func11(r_V1,v_v3);
    rem_V2=func11(rem1_V1,re_V2);


    rem1_V2=func14(rem_V2,r_R3);
    rem2_V2=func11(rem1_V1,rem1_V2);
    R2=func14(rem2_V2,yp);
    
    xq=R1;
    yq=R2;
    

  endtask
  
  
  
  
  
  function [162:0] func14(input [162:0] adder_in1, input [162:0] adder_in2);
     logic [162:0]out;
  
    out = adder_in1 ^ adder_in2;
    return out;
endfunction
  
  
  
  
  
  
  function [162:0] func13(input [162:0]inv_inp);
    reg [162:0] y, z;
    integer k;
    begin
        // Step 1: Initialize
        y = inv_inp;



        // Step 3: Iterative computation
      for (k = 0; k < 7; k = k + 1) begin
            // Simulated cyclic shift; replace with an actual shift operation suitable for your design
        z = func12(k,y); // Cyclic right shift for simulation
            
          y = func11(y,z); // Note: This is a simplification and should be replaced with actual GF(2^m) multiplication logic
        end

        // Step 4: Final multiplication
      y = func11(y,inv_inp); // Another simplification, replace with correct multiplication

      end   // Return result
      return y;
      
   
endfunction
  function [162:0] func12(input [6:0] circ_shft_val, input [162:0] circ_shft_inp);
    reg [162:0] t1, t2, t3, t4, t5, t6, t7;

    t1 = circ_shft_val[0] ? {circ_shft_inp[161:0], circ_shft_inp[162]} : circ_shft_inp;

    t2 = circ_shft_val[1] ? {t1[160:0], t1[162:161]} : t1;

    t3 = circ_shft_val[2] ? {t2[158:0], t2[162:159]} : t2;

    t4 = circ_shft_val[3] ? {t3[154:0], t3[162:155]} : t3;

    t5 = circ_shft_val[4] ? {t4[146:0], t4[162:147]} : t4;

    t6 = circ_shft_val[5] ? {t5[130:0], t5[162:131]} : t5;

    t7 = circ_shft_val[6] ? {t6[98:0], t6[162:99]} : t6;

    return t7;
endfunction
  
  function [162:0] func11(input [162:0]mult_in1,mult_in2);
    reg [162:0]mult_out;
    reg [324:0]d;
    d=func9(mult_in1,mult_in2);
    mult_out=func10(d);
    
  return mult_out;
  endfunction
  function [162:0] func10(input bit [324:0] D);
    logic [162:0] M, W, r;

    // Compute M and W arrays using procedural assignments
    M[0] = D[0] ^ D[163] ^ D[319];
    M[1] = D[1] ^ D[164] ^ D[320];
    M[2] = D[2] ^ D[165] ^ D[321];
    M[3] = D[3] ^ D[166] ^ D[322];
    M[4] = D[4] ^ D[167] ^ D[323];
    M[5] = D[5] ^ D[168] ^ D[324];

    for (int i = 6; i <= 162; i++) begin
        W[i] = D[i] ^ D[157 + i] ^ D[160 + i];
    end

    // Compute r array using procedural assignments
    r[0] = M[0] ^ D[320] ^ D[323];
    r[1] = M[1] ^ D[321] ^ D[324];
    r[2] = M[2] ^ D[322];
    r[3] = M[3] ^ D[163] ^ D[319] ^ D[320];
    r[4] = M[4] ^ D[164] ^ D[320] ^ D[321];
    r[5] = M[5] ^ D[165] ^ D[321] ^ D[322];

    // Continue computing r for other indices
    for (int i = 6; i <= 10; i++) begin
        r[i] = W[i] ^ D[i+156] ^ D[i+163] ^ D[i+312] ^ D[i+314];
    end

    for (int i = 11; i <= 12; i++) begin
        r[i] = W[i] ^ D[i+156] ^ D[i+163] ^ D[i+312];
    end

    for (int i = 13; i <= 162; i++) begin
        r[i] = W[i] ^ D[i+156] ^ D[i+163];  // Simplified, adjust as needed
    end

    return r;
endfunction

  
  
  
  function [324:0] func9(input [162:0] a,b);
    reg [324:0]y;
    
    reg [242:0] aa;
	reg [242:0] bb;

	 

reg [80:0] a0,a1,a2;
reg [80:0] b0,b1,b2;
reg [160:0] p0,p1,p2,p3,p4,p5;
	 aa = {80'b0,a};
	 bb = {80'b0,b};
	 a0 = aa[80:0];
	 b0 = bb[80:0];
	 a1 = aa[161:81];
	 b1 = bb[161:81];
	 a2 = aa[242:162];
	 b2 = bb[242:162];
    	
    p0=func7(a0,b0);
    p1=func7(a1,b1);
    p2=func7((a0^a1),(b0^b1));
    p3=func7(a2,b2);
    p4=func7((a0^a2),(b0^b2));
    p5=func7((a2^a1),(b2^b1));
    y=func8(p0,p1,p2,p3,p4,p5);
    return y;
    endfunction
  
  function [484:0] func8(input [160:0] p0,p1,p2,p3,p4,p5);
    reg [484:0] y;
   
 y[80:0] = p0[80:0];
 y[160:81] = p0[160:81]^p0[79:0]^p1[79:0]^p2[79:0];
 y[161] = p0[80]^p1[80]^p2[80];
 y[241:162] = p0[160:81]^p1[160:81]^p2[160:81]^p0[79:0]^p1[79:0]^p3[79:0]^p4[79:0];
 y[242] = p0[80]^p1[80]^p3[80]^p4[80];
 y[322:243] = p0[160:81]^p1[160:81]^p3[160:81]^p4[160:81]^p1[79:0]^p3[79:0]^p5[79:0];
 y[323] = p1[80]^p5[80]^p3[80];
 y[403:324] = p1[160:81]^p5[160:81]^p3[160:81]^p3[79:0];
 y[484:404] = p3[160:80];
        return y;
   
    endfunction

  
  function [160:0]func7(input[80:0]a,b);
  reg[160:0]y;
	reg [80:0] aa;
	reg [80:0] bb;
	reg [26:0] a0,a1,a2;
	reg [26:0] b0,b1,b2;
	reg [52:0] p0,p1,p2,p3,p4,p5;
	 aa = {0'b0,a};
	 bb = {0'b0,b};

 a0 = aa[26:0];
 b0 = bb[26:0];
 a1 = aa[53:27];
 b1 = bb[53:27];
 a2 = aa[80:54];
 b2 = bb[80:54];
    
    p0=func5(a0,b0);
    p1=func5(a1,b1);
    p2=func5((a0^a1),(b0^b1));
    p3=func5(a2,b2);
    p4=func5((a0^a2),(b0^b2));
    p5=func5((a2^a1),(b2^b1));
    y=func6(p0,p1,p2,p3,p4,p5);
    
    return y;
  endfunction
  
  function [160:0] func6(input [52:0] p0,p1,p2,p3,p4,p5);
    reg [160:0] y;
   
 y[26:0] = p0[26:0];
 y[52:27] = p0[52:27]^p0[25:0]^p1[25:0]^p2[25:0];
 y[53] = p0[26]^p1[26]^p2[26];
 y[79:54] = p0[52:27]^p1[52:27]^p2[52:27]^p0[25:0]^p1[25:0]^p3[25:0]^p4[25:0];
 y[80] = p0[26]^p1[26]^p3[26]^p4[26];
 y[106:81] = p0[52:27]^p1[52:27]^p3[52:27]^p4[52:27]^p1[25:0]^p3[25:0]^p5[25:0];
 y[107] = p1[26]^p5[26]^p3[26];
 y[133:108] = p1[52:27]^p5[52:27]^p3[52:27]^p3[25:0];
 y[160:134] = p3[52:26];
        return y;
   
    endfunction
  
  function [52:0] func5(input[26:0]a,b);
    reg[52:0] y; 
    
    reg [26:0] aa;
	reg [26:0] bb;

reg [8:0] a0,a1,a2;
reg [8:0] b0,b1,b2;
reg [16:0] p0,p1,p2,p3,p4,p5;
 aa = {0'b0,a};
 bb = {0'b0,b};


 a0 = aa[8:0];
 b0 = bb[8:0];
 a1 = aa[17:9];
 b1 = bb[17:9];
 a2 = aa[26:18];
 b2 = bb[26:18];
	
    p0=func3(a0,b0);
    p1=func3(a1,b1);
    p2=func3((a0^a1),(b0^b1));
    p3=func3(a2,b2);
    p4=func3((a0^a2),(b0^b2));
    p5=func3((a2^a1),(b2^b1));
    y=func4(p0,p1,p2,p3,p4,p5);
    return y;
  endfunction
  
  
  function [52:0] func4(input [16:0] p0,p1,p2,p3,p4,p5);
    reg [52:0] y;
   
       y[8:0] = p0[8:0];
 y[16:9] = p0[16:9]^p0[7:0]^p1[7:0]^p2[7:0];
 y[17] = p0[8]^p1[8]^p2[8];
 y[25:18]=p0[16:9]^p1[16:9]^p2[16:9]^p0[7:0]^p1[7:0]^p3[7:0]^p4[7:0];
 y[26] = p0[8]^p1[8]^p3[8]^p4[8];
 y[34:27]=p0[16:9]^p1[16:9]^p3[16:9]^p4[16:9]^p1[7:0]^p3[7:0]^p5[7:0];
 y[35] = p1[8]^p5[8]^p3[8];
 y[43:36] = p1[16:9]^p5[16:9]^p3[16:9]^p3[7:0];
 y[52:44] = p3[16:8];

        return y;
   
    endfunction
  
  function [16:0] func3(input [8:0]a,b);
    reg[16:0]y;
    reg [8:0] aa;
	reg [8:0] bb;
	
reg [2:0] a0,a1,a2;
reg [2:0] b0,b1,b2;
reg [4:0] p0,p1,p2,p3,p4,p5;
 aa = {0'b0,a};
 bb = {0'b0,b};


 a0 = aa[2:0];
 b0 = bb[2:0];
 a1 = aa[5:3];
 b1 = bb[5:3];
 a2 = aa[8:6];
 b2 = bb[8:6];
    p0=func1(a0,b0);
    p1=func1(a1,b1);
    p2=func1((a0^a1),(b0^b1));
    p3=func1(a2,b2);
    p4=func1((a0^a2),(b0^b2));
    p5=func1((a2^a1),(b2^b1));
    y=func2(p0,p1,p2,p3,p4,p5);
    return y;
  endfunction
  
  function [16:0] func2(input [4:0] p0,p1,p2,p3,p4,p5);
    reg [16:0] y;
    begin
        y[2:0] = p0[2:0];
 y[4:3] = p0[4:3]^p0[1:0]^p1[1:0]^p2[1:0];
 y[5] = p0[2]^p1[2]^p2[2];
 y[7:6] = p0[4:3]^p1[4:3]^p2[4:3]^p0[1:0]^p1[1:0]^p3[1:0]^p4[1:0];
 y[8] = p0[2]^p1[2]^p3[2]^p4[2];
 y[10:9] = p0[4:3]^p1[4:3]^p3[4:3]^p4[4:3]^p1[1:0]^p3[1:0]^p5[1:0];
 y[11] = p1[2]^p5[2]^p3[2];
 y[13:12] = p1[4:3]^p5[4:3]^p3[4:3]^p3[1:0];
 y[16:14] = p3[4:2];

        return y;
    end
  endfunction
  function [4:0] func1(input [2:0] a, input [2:0] b);
  reg [4:0] y;
    begin
        y[0] = (a[0] & b[0]);
        y[1] = (a[1] & b[1]) ^ (a[0] & b[0]) ^ ((a[0] ^ a[1]) & (b[0] ^ b[1]));
        y[2] = (a[1] & b[1]) ^ (a[0] & b[0]) ^ (a[2] & b[2]) ^ ((a[0] ^ a[2]) & (b[0] ^ b[2]));
        y[3] = (a[1] & b[1]) ^ (a[2] & b[2]) ^ ((a[1] ^ a[2]) & (b[1] ^ b[2]));
        y[4] = (a[2] & b[2]);
        return y;
    end
    endfunction


  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    forever begin
      mbx.get(tr);
      tr.display("SCOREBOARD");
 
      func(1'b1, 1'b0,tr.a, tr.b, tr.k, tr.xp, tr.yp, xq, yq);
      $display("%4b \t %4b",xq,yq);
            if (tr.xq !== xq || tr.yq !== yq) begin
                $display("Mismatch detected");
            end else begin
                $display("Output matches");
            end
       
      ->next;
    end
  endtask
endclass



class environment;
  generator gen;
  driver drv;
  mailbox #(transaction) gendrimbx;
  
  monitor mon;
  scoreboard sco;
  mailbox #(transaction) monscombx;
  
  virtual ACUif acif;
  
  event nextgs;
  
  function new(virtual ACUif acif);
    gendrimbx = new();
    gen = new(gendrimbx);
    drv = new(gendrimbx);
    
    monscombx = new();
    mon = new(monscombx);
    sco = new(monscombx);
    
    this.acif = acif;
    
    drv.acif = acif;
    mon.acif = acif;
    
    gen.next = nextgs;
    sco.next = nextgs;
  endfunction
  
  task pre_test();
    drv.reset();
  endtask
  
  task test();
    fork
      gen.run();
      drv.run();
      mon.run();
      sco.run();
    join_any
  endtask
  
  task post_test();
    wait(gen.done.triggered);
    $display("Coverage = %0.2f ", acif.cg_inst.get_inst_coverage());
    #10;
    $finish();
  endtask
  
  
  task run();
    pre_test();
    test();
    post_test();
  endtask
endclass


module tb();
  environment env;
  ACUif acif();
  
  ECC_all_Parts dut(acif.clk,acif.rst, acif.a,acif.b,acif.k,acif.xp,acif.yp,acif.xq,acif.yq);
  
  initial begin
    acif.clk = 0;
	acif.rst=1;
  end
  
  always #5 acif.clk <= ~acif.clk;
 always #1000 acif.rst <= ~acif.rst;
  initial begin
    env = new(acif);
    env.gen.count = 25000;
    env.run();
  end
endmodule

