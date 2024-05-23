module inversion_op(
    input clk,
    input rst,
    input [162:0] inv_inp,
    output reg [162:0] inv_out
);

    reg [162:0] y, z;
    reg [7:0] k;
    wire [7:0] kwire;  // Assuming m-1 can be represented within 8 bits for simplification
    wire [162:0] shifted_y, multiplied_y, multiplied_y1;
    localparam integer r = 7; // Example value, should be ceil(log2(m-1)) for your specific m

    // Multiplier and Shifter Instances
    multiplier_163b multiply(.mult_out(multiplied_y), .mult_in1(y), .mult_in2(z));
    circ_leftshift_163b shift(.circ_shft_out(shifted_y), .circ_shft_inp(y), .circ_shft_val(1 << k)); // Dynamically calculate shift based on k
    multiplier_163b multiply1(.mult_out(multiplied_y1), .mult_in1(y), .mult_in2(y));

    // State Machine for controlling operation phases
    reg [2:0] state; // Adjusted state width to accommodate the new state
    localparam [2:0]
        IDLE = 3'b000,
        SHIFT = 3'b001,
        MULTIPLY = 3'b010,
        FINALIZE = 3'b011,
        DONE = 3'b100;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            y <= 0;
            z <= 0;
            k <= 0;
            inv_out <= 0;
            state <= IDLE;
        end else begin
            case(state)
                IDLE: begin
                    y <= inv_inp;
                    z <= inv_inp;  // Initialize y and z with input
                    k <= 0;
                    state <= SHIFT;
                end
                SHIFT: begin
                    if (k < r) begin
                        z <= shifted_y;  // Update z with the result of the shift
                        state <= MULTIPLY;
                    end else begin
                        state <= FINALIZE;
                    end
                end
                MULTIPLY: begin
                    if (k < r) begin
                        y <= multiplied_y; // Update y with the result of multiplication
                        k <= k + 1;
                        state <= SHIFT;
                    end else begin
                        state <= FINALIZE;
                    end
                end
                FINALIZE: begin
                    y <= multiplied_y1;  // Final multiplication
                    state <= DONE;
                end
                DONE: begin
                    inv_out <= y;  // Output the result
                    state <= IDLE; // Ready for next input
                end
            endcase
        end
    end

    assign kwire = k;  // Assign k directly to kwire

endmodule