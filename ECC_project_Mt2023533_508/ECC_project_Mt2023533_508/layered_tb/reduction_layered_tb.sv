
`timescale 1ns/1ps

interface ACUif;
  logic [325:0]D;
  logic [162:0]r;

  
  logic clk_cov_sampler;
  
  covergroup cg @(posedge clk_cov_sampler);
    option.per_instance = 1;
    cp_D: coverpoint D;
    cp_r: coverpoint r;
  endgroup
  
  cg cg_inst = new();
endinterface


class transaction;
  randc bit [325:0]D;
  bit [162:0]r;
  
  function void display(input string tag);
    $display("[%s]\t D = %4b \t r = %4b @ %0t", tag,D, r, $time);    
  endfunction
  
  function transaction copy();
    copy = new();
    copy.D = this.D;
    copy.r = this.r;
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
    acif.D <= 0;
    #10;
  endtask
  
  task run();
    forever begin
      mbx.get(datac);
      datac.display("DRIVER");
      acif.D <= datac.D;
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
      tr.D = acif.D;
      tr.r = acif.r;
      mbx.put(tr);
      tr.display("MONITOR");
    end
  endtask
  
endclass


class scoreboard;
  mailbox #(transaction) mbx;
  transaction tr;
  event next;
  bit [162:0]r;
function [162:0] func(input bit [324:0] D);
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

  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    forever begin
      mbx.get(tr);
      tr.display("SCOREBOARD");
      r=func(tr.D);
      
      if(tr.r != r)
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
  
  red dut(acif.D, acif.r);
  
  initial begin
    acif.clk_cov_sampler = 0;
  end
  
  always #5 acif.clk_cov_sampler <= ~acif.clk_cov_sampler;
  
  initial begin
    env = new(acif);
    env.gen.count = 500;
    env.run();
  end
endmodule

