`timescale 1ns / 1ps

module tb_ks3;

// Inputs
reg [2:0] a;
reg [2:0] b;

// Outputs
wire [4:0] y;

// Instantiate the Unit Under Test (UUT)
ks3 uut (
	.a(a),
	.b(b),
	.y(y)
);

initial begin
	// Initialize Inputs
	b = 3'b011; // constant value

	// Monitor the changes
	$monitor("Time: %0t | a = %b | b = %b | y = %b", $time, a, b, y);

	// Apply random stimulus to input 'a'
	repeat (10) begin
		#10;
		a = $random % 8; // Random value for 'a' between 0 and 7
	end

	// Finish the simulation
	#10;
	$finish;
end

endmodule