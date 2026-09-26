`timescale 1ns / 1ps

module tb_toffoli_gate;

    // Inputs
    reg a;
    reg b;
    reg c;

    // Outputs
    wire q_a;
    wire q_b;
    wire q_c;

    // Instantiate the Unit Under Test (UUT)
    toffoli_gate uut (
        .a(a), .b(b), .c(c), 
        .q_a(q_a), .q_b(q_b), .q_c(q_c)
    );

    initial begin
        // Initialize Inputs and print header
        $display("Time\t A B C -> Q_A Q_B Q_C");
        $monitor("%0d\t %b %b %b ->  %b   %b   %b", $time, a, b, c, q_a, q_b, q_c);

        // Test all 8 possible binary states
        a = 0; b = 0; c = 0; #10;
        a = 0; b = 0; c = 1; #10;
        a = 0; b = 1; c = 0; #10;
        a = 0; b = 1; c = 1; #10;
        a = 1; b = 0; c = 0; #10;
        a = 1; b = 0; c = 1; #10;
        
        // These cases should trigger the conditional target flip (a=1, b=1)
        a = 1; b = 1; c = 0; #10;
        a = 1; b = 1; c = 1; #10;

        $finish;
    end
      
endmodule
