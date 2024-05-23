`timescale 1ns/1ps

interface ACUif;
  logic [6:0]circ_shft_val;
  logic [162:0]circ_shft_inp;
  logic [162:0]circ_shft_out;

  
  logic clk_cov_sampler;
  
  covergroup cg @(posedge clk_cov_sampler);
    option.per_instance = 1;
    cp_circ_shft_val: coverpoint circ_shft_val;
    cp_circ_shft_inp: coverpoint circ_shft_inp;
    cp_circ_shft_out: coverpoint circ_shft_out;
cp_circ_shft_valXcp_circ_shft_inp: cross cp_circ_shft_val, cp_circ_shft_inp ;
   
  endgroup
  
  cg cg_inst = new();
endinterface


class transaction;
  randc bit [6:0]circ_shft_val;
  randc bit [162:0]circ_shft_inp;
  bit [162:0]circ_shft_out;
  
  function void display(input string tag);
    $display("[%s]\t circ_shft_val = %4b \t circ_shft_inp = %4b,circ_shft_out=%4b @ %0t", tag,circ_shft_val, circ_shft_inp,circ_shft_out, $time);    
  endfunction
  
  function transaction copy();
    copy = new();
    copy.circ_shft_val = this.circ_shft_val;
    copy.circ_shft_inp = this.circ_shft_inp;
     copy.circ_shft_out = this.circ_shft_out;
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
    acif.circ_shft_val <= 0;
    acif.circ_shft_inp <= 0;
    #10;
  endtask
  
  task run();
    forever begin
      mbx.get(datac);
      datac.display("DRIVER");
      acif.circ_shft_val <= datac.circ_shft_val;
      acif.circ_shft_inp <= datac.circ_shft_inp;
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
      tr.circ_shft_val = acif.circ_shft_val;
     tr.circ_shft_inp = acif.circ_shft_inp;
      tr.circ_shft_out = acif.circ_shft_out;
      mbx.put(tr);
      tr.display("MONITOR");
    end
  endtask
  
endclass


class scoreboard;
  mailbox #(transaction) mbx;
  transaction tr;
  event next;
  bit [162:0]circ_shft_out;
  function [162:0] func(input [6:0] circ_shft_val, input [162:0] circ_shft_inp);
    reg [162:0] t1, t2, t3, t4, t5, t6, t7;

    // First level of shift, conditional based on circ_shft_val[0]
    t1 = circ_shft_val[0] ? {circ_shft_inp[161:0], circ_shft_inp[162]} : circ_shft_inp;

    // Second level of shift, conditional based on circ_shft_val[1]
    t2 = circ_shft_val[1] ? {t1[160:0], t1[162:161]} : t1;

    // Third level of shift, conditional based on circ_shft_val[2]
    t3 = circ_shft_val[2] ? {t2[158:0], t2[162:159]} : t2;

    // Fourth level of shift, conditional based on circ_shft_val[3]
    t4 = circ_shft_val[3] ? {t3[154:0], t3[162:155]} : t3;

    // Fifth level of shift, conditional based on circ_shft_val[4]
    t5 = circ_shft_val[4] ? {t4[146:0], t4[162:147]} : t4;

    // Sixth level of shift, conditional based on circ_shft_val[5]
    t6 = circ_shft_val[5] ? {t5[130:0], t5[162:131]} : t5;

    // Seventh level of shift, conditional based on circ_shft_val[6]
    t7 = circ_shft_val[6] ? {t6[98:0], t6[162:99]} : t6;

    // Return the final shifted output
    return t7;
endfunction



  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    forever begin
      mbx.get(tr);
      tr.display("SCOREBOARD");
       circ_shft_out=func(tr.circ_shft_val,tr.circ_shft_inp);
      $display("%4b",circ_shft_out);
      if(tr.circ_shft_out != circ_shft_out)
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
  
circ_leftshift_163b dut(acif.circ_shft_val,acif.circ_shft_inp,acif.circ_shft_out);
  
  initial begin
    acif.clk_cov_sampler = 0;
  end
  
  always #5 acif.clk_cov_sampler <= ~acif.clk_cov_sampler;
  
  initial begin
    env = new(acif);
    env.gen.count = 10000;
    env.run();
  end
endmodule

