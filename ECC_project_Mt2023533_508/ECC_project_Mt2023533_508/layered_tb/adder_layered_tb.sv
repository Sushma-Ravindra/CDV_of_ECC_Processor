// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

interface ACUif;
  logic [162:0]adder_in1 , adder_in2;
  logic [162:0]adder_out;

  
  logic clk_cov_sampler;
  
  covergroup cg @(posedge clk_cov_sampler);
    option.per_instance = 1;
    cp_adder_in1: coverpoint adder_in1;
    cp_adder_in2: coverpoint adder_in2;
    cp_adder_out: coverpoint adder_out;
    cp_adder_in1Xcp_adder_in2: cross cp_adder_in1, cp_adder_in2 ;
   
  endgroup
  
  cg cg_inst = new();
endinterface


class transaction;
  randc bit [162:0]adder_in1,adder_in2;
  bit [162:0]adder_out;
  
  function void display(input string tag);
    $display("[%s]\t adder_in1 = %4b \t adder_in2 = %4b,adder_out=%4b @ %0t", tag,adder_in1, adder_in2,adder_out, $time);    
  endfunction
  
  function transaction copy();
    copy = new();
    copy.adder_in1 = this.adder_in1;
    copy.adder_in2 = this.adder_in2;
     copy.adder_out = this.adder_out;
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
    acif.adder_in1 <= 0;
    acif.adder_in2 <= 0;
    #10;
  endtask
  
  task run();
    forever begin
      mbx.get(datac);
      datac.display("DRIVER");
      acif.adder_in1 <= datac.adder_in1;
      acif.adder_in2 <= datac.adder_in2;
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
      tr.adder_in1 = acif.adder_in1;
     tr.adder_in2 = acif.adder_in2;
      tr.adder_out = acif.adder_out;
      mbx.put(tr);
      tr.display("MONITOR");
    end
  endtask
  
endclass


class scoreboard;
  mailbox #(transaction) mbx;
  transaction tr;
  event next;
  bit [162:0]out;
  function [162:0] func(input [162:0] adder_in1, input [162:0] adder_in2);
     logic [162:0]out;
    // Perform the XOR operation and return the result
    out = adder_in1 ^ adder_in2;
    return out;
endfunction


  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    forever begin
      mbx.get(tr);
      tr.display("SCOREBOARD");
      out=func(tr.adder_in1,tr.adder_in2);
      
      if(tr.adder_out != out)
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
  
cs_adder_163b dut(acif.adder_in1,acif.adder_in2,acif.adder_out);
  
  initial begin
    acif.clk_cov_sampler = 0;
  end
  
  always #5 acif.clk_cov_sampler <= ~acif.clk_cov_sampler;
  
  initial begin
    env = new(acif);
    env.gen.count = 600;
    env.run();
  end
endmodule

//DUT

// Code your design here
module cs_adder_163b(

input [162:0]adder_in1 , adder_in2,
output [162:0] adder_out


);



assign adder_out[162:0] = adder_in1[162:0] ^ adder_in2[162:0];



endmodule

//run.do

vsim +access+r -dbg
run -all
acdb report 
exec cat acdb_report.txt