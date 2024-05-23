`timescale 1ns/1ps

interface ACUif;
  logic [162:0]a;
  logic [162:0]b;
  logic [324:0]y;

  
  logic clk_cov_sampler;
  
  covergroup cg @(posedge clk_cov_sampler);
    option.per_instance = 1;
    cp_a: coverpoint a;
    cp_b: coverpoint b;
    cp_y: coverpoint y;
    cp_aXcp_b:cross cp_a,cp_b;
  endgroup
  
  cg cg_inst = new();
endinterface


class transaction;
  randc bit [162:0]a;
  randc bit [162:0]b;
  bit [324:0]y;
  
  function void display(input string tag);
    $display("[%s]\t a = %4b \t b = %4b \t y=%4b @ %0t", tag,a,b,y, $time);    
  endfunction
  
  function transaction copy();
    copy = new();
    copy.a = this.a;
    copy.b = this.b;
    copy.y = this.y;
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
    #10;
  endtask
  
  task run();
    forever begin
      mbx.get(datac);
      datac.display("DRIVER");
      acif.a <= datac.a;
      acif.b <= datac.b;
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
      tr.y = acif.y;
      mbx.put(tr);
      tr.display("MONITOR");
    end
  endtask
  
endclass


class scoreboard;
  mailbox #(transaction) mbx;
  transaction tr;
  event next;
  bit [324:0]y;
  
  
  function [324:0] func(input [162:0] a,b);
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
      y=func(tr.a,tr.b);
      $display("%4b",y);
      if(tr.y != y)
        begin
          $error("Error @ %0t", $time);
        end
      
      else begin
        $display("Data MATCH");
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
  
  ks163 dut(acif.a, acif.b,acif.y);
  
  initial begin
    acif.clk_cov_sampler = 0;
  end
  
  always #5 acif.clk_cov_sampler <= ~acif.clk_cov_sampler;
  
  initial begin
    env = new(acif);
    env.gen.count = 15000;
    env.run();
  end
endmodule

