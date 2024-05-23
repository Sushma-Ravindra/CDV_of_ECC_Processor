`timescale 1ns / 1ps

module tb_red;

    // Inputs
    reg [325:0] D;

    // Outputs
    wire [162:0] r;

    // Instantiate the Unit Under Test (UUT)
    red uut (
        .D(D), 
        .r(r)
    );

    initial begin
        // Initialize Inputs
        D = 326'b0;

        // Wait 100 ns for global reset to finish
        #100;

        // Apply test vectors
        D = 326'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        #10;
        
        D = 326'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
        #10;
        
        D = 326'h1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF;
        #10;
        
        // Add more test vectors as needed
    end
      
    initial begin
        $monitor("Time = %0dns, D = %h, r = %h", $time, D, r);
    end

endmodule
