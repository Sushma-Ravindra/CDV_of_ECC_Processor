`timescale 1ns / 1ps

module tb_circ_leftshift_163b;

    // Inputs
    reg [6:0] circ_shft_val;
    reg [162:0] circ_shft_inp;

    // Outputs
    wire [162:0] circ_shft_out;

    // Instantiate the Unit Under Test (UUT)
    circ_leftshift_163b uut (
        .circ_shft_val(circ_shft_val), 
        .circ_shft_inp(circ_shft_inp), 
        .circ_shft_out(circ_shft_out)
    );

    initial begin
        // Initialize Inputs
        circ_shft_val = 7'b0;
        circ_shft_inp = 163'b0;

        // Wait 100 ns for global reset to finish
        #100;

        // Apply test vectors
        circ_shft_val = 7'b0000001;
        circ_shft_inp = 163'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        #10;

        circ_shft_val = 7'b0000010;
        circ_shft_inp = 163'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
        #10;

        circ_shft_val = 7'b0000100;
        circ_shft_inp = 163'h1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF123;
        #10;

        circ_shft_val = 7'b0001000;
        circ_shft_inp = 163'hFEDCBA0987654321FEDCBA0987654321FEDCBA0987654321FEDCBA0987654321FED;
        #10;

        circ_shft_val = 7'b0010000;
        circ_shft_inp = 163'h0000000000000000000000000000000000000000000000000000000000000000001;
        #10;

        circ_shft_val = 7'b0100000;
        circ_shft_inp = 163'h7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        #10;

        circ_shft_val = 7'b1000000;
        circ_shft_inp = 163'h8000000000000000000000000000000000000000000000000000000000000000000;
        #10;

        // Add more test vectors as needed
    end
      
    initial begin
        $monitor("Time = %0dns, circ_shft_val = %b, circ_shft_inp = %h, circ_shft_out = %h", $time, circ_shft_val, circ_shft_inp, circ_shft_out);
    end

endmodule
