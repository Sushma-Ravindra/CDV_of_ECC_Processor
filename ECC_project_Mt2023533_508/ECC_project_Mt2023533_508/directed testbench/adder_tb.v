`timescale 1ns / 1ps

module tb_cs_adder_163b;

    // Inputs
    reg [162:0] adder_in1;
    reg [162:0] adder_in2;

    // Outputs
    wire [162:0] adder_out;


    cs_adder_163b uut (
        .adder_in1(adder_in1), 
        .adder_in2(adder_in2), 
        .adder_out(adder_out)
    );

    initial begin
        // Initialize Inputs
        adder_in1 = 163'b0;
        adder_in2 = 163'b0;

       
        #100;


        adder_in1 = 163'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        adder_in2 = 163'h0000000000000000000000000000000000000000000000000000000000000000001;
        #10;
        
        adder_in1 = 163'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
        adder_in2 = 163'h5555555555555555555555555555555555555555555555555555555555555555555;
        #10;
        
        adder_in1 = 163'h1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF123;
        adder_in2 = 163'hFEDCBA0987654321FEDCBA0987654321FEDCBA0987654321FEDCBA0987654321FED;
        #10;

        
    end
      
    initial begin
        $monitor("Time = %0dns, adder_in1 = %h, adder_in2 = %h, adder_out = %h", $time, adder_in1, adder_in2, adder_out);
    end

endmodule

