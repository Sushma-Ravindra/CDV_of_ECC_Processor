`timescale 1ns / 1ps

module tb_inversion_op;

    // Inputs
    reg [162:0] inv_inp;

    // Outputs
    wire [162:0] inv_out;

    // Instantiate the Unit Under Test (UUT)
    inversion_op uut (
        .inv_inp(inv_inp), 
        .inv_out(inv_out)
    );


    initial begin
        // Initialize Inputs

        inv_inp = 163'b0;

        // Wait 100 ns for global reset to finish
        #100;

        // Apply test vectors
        inv_inp = 163'd2;
        #10;

        inv_inp = 163'd4;
        #10;

        inv_inp = 163'd1;
        #10;

        inv_inp = 163'hFEDCBA0987654321FEDCBA0987654321FEDCBA0987654321FEDCBA0987654321FED;
        #10;

        inv_inp = 163'h0000000000000000000000000000000000000000000000000000000000000000001;
        #10;

        inv_inp = 163'h7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        #10;

        inv_inp = 163'h8000000000000000000000000000000000000000000000000000000000000000000;
        #10;

        // Add more test vectors as needed
    end
      
    initial begin
        $monitor("Time = %0dns, inv_inp = %h, inv_out = %h", $time, inv_inp, inv_out);
    end

endmodule
