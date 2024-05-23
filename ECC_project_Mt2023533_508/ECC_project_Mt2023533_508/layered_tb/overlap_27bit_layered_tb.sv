// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

interface ACUif;
  logic [16:0]p0,p1,p2,p3,p4,p5;
  logic [52:0]y;

  
  logic clk_cov_sampler;
  
  covergroup cg @(posedge clk_cov_sampler);
    option.per_instance = 1;
    cp_p0: coverpoint p0;
    cp_p1: coverpoint p1;
    cp_p2: coverpoint p2;
      cp_p3: coverpoint p3;
      cp_p4: coverpoint p4;
      cp_p5: coverpoint p5;
      cp_y: coverpoint y;
  endgroup
  
  cg cg_inst = new();
endinterface


class transaction;
  randc bit [16:0]p0,p1,p2,p3,p4,p5;
  bit [52:0]y;
  
  function void display(input string tag);
    $display("[%s]\t p0 = %4b \t p1 = %4b \t p2=%4b \tp4=%4b \tp4=%4b \t p5=%4b \ty=%4b @ %0t", tag,p0,p1,p2,p3,p4,p5,y, $time);    
  endfunction
  
  function transaction copy();
    copy = new();
    copy.p0 = this.p0;
    copy.p1 = this.p1;
    copy.p2 = this.p2;
    copy.p3 = this.p3;
    copy.p4 = this.p4;
    copy.p5 = this.p5;
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
    acif.p0 <= 0;
    acif.p1 <= 0;
	acif.p2 <= 0;
	acif.p3 <= 0;
	acif.p4 <= 0;
	acif.p5 <= 0;
    #10;
  endtask
  
  task run();
    forever begin
      mbx.get(datac);
      datac.display("DRIVER");
      acif.p0 <= datac.p0;
      acif.p1 <= datac.p1;
	  acif.p2 <= datac.p2;
	  acif.p3 <= datac.p3;
	  acif.p4 <= datac.p4;
	  acif.p5 <= datac.p5;
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
      tr.p0 = acif.p0;
      tr.p1 = acif.p1;
      tr.p2 = acif.p2;
      tr.p3 = acif.p3;
      tr.p4 = acif.p4;
      tr.p5 = acif.p5;
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
  bit [52:0]y;
  function [52:0] func(input [16:0] p0,p1,p2,p3,p4,p5);
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


  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    forever begin
      mbx.get(tr);
      tr.display("SCOREBOARD");
      y=func(tr.p0,tr.p1,tr.p2,tr.p3,tr.p4,tr.p5);
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
  
  overlap_27bit dut(acif.p0, acif.p1,acif.p2,acif.p3,acif.p4,acif.p5,acif.y);
  
  initial begin
    acif.clk_cov_sampler = 0;
  end
  
  always #5 acif.clk_cov_sampler <= ~acif.clk_cov_sampler;
  
  initial begin
    env = new(acif);
    env.gen.count = 700;
    env.run();
  end
endmodule

