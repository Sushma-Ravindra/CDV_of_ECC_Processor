`timescale 1ns/1ps

interface ACUif;
  logic [8:0]a;
  logic [8:0]b;
  logic [16:0]y;

  
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
  randc bit [8:0]a;
  randc bit [8:0]b;
  bit [16:0]y;
  
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
  bit [16:0]y;
  function [16:0] func(input [8:0]a,b);
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
  
  ks9 dut(acif.a, acif.b,acif.y);
  
  initial begin
    acif.clk_cov_sampler = 0;
  end
  
  always #5 acif.clk_cov_sampler <= ~acif.clk_cov_sampler;
  
  initial begin
    env = new(acif);
    env.gen.count = 30000;
    env.run();
  end
endmodule

