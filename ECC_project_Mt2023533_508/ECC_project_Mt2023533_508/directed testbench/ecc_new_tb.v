`timescale 1ns / 1ps

module tb_ECC_all_Parts;

    // Inputs
    reg clk;
    reg rst;
    reg [162:0] a;
    reg [162:0] b;
    reg [162:0] k;
    reg [162:0] xp;
    reg [162:0] yp;

    // Outputs
    wire [162:0] xq;
    wire [162:0] yq;

    // Instantiate the Unit Under Test (UUT)
    ECC_all_Parts uut (
        .clk(clk), 
        .rst(rst), 
        .a(a), 
        .b(b), 
        .k(k), 
        .xp(xp), 
        .yp(yp), 
        .xq(xq), 
        .yq(yq)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // 100MHz clock
    end

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        a = 163'b0;
        b = 163'b0;
        k = 163'b0;
        xp = 163'b0;
        yp = 163'b0;

        // Wait 100 ns for global reset to finish
        #100;

        // Apply test vectors
        rst = 1;
        #10;
        rst = 0;

        a = 163'h1;
        b = 163'h2;
        k = 163'h3;
        xp = 163'h4;
        yp = 163'h5;
        #1000;

        rst = 1;
        #10;
        rst = 0;

        a = 163'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
        b = 163'hBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB;
        k = 163'hCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC;
        xp = 163'hDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD;
        yp = 163'hEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE;
        #1000;

        rst = 1;
        #10;
        rst = 0;

        // Add more test vectors as needed
    end

    initial begin
        $monitor("Time = %0dns, clk = %b, rst = %b, a = %h, b = %h, k = %h, xp = %h, yp = %h, xq = %h, yq = %h", 
                 $time, clk, rst, a, b, k, xp, yp, xq, yq);
    end

endmodule
