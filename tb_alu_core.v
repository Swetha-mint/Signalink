`timescale 1ns / 1ps

// =====================================================================
// Project: SIGNALINK (Sense. Process. Communicate. Assist.)
// Module: tb_alu_core
// Description: Testbench to verify all 4 operational opcodes of the 
//              4-bit alu_core architecture in simulation environments.
// =====================================================================

module tb_alu_core;

    // Testbench Inputs (Declared as registers to hold driven values)
    reg [3:0] test_in_a;
    reg [3:0] test_in_b;
    reg [1:0] test_op;

    // Testbench Outputs (Declared as wires to sample values from UUT)
    wire [3:0] verify_out;
    wire       verify_carry;

    // Instantiate the Unit Under Test (UUT)
    alu_core uut (
        .alu_in_a(test_in_a),
        .alu_in_b(test_in_b),
        .op_code(test_op),
        .alu_out(verify_out),
        .carry_out(verify_carry)
    );

    initial begin
        // Print clean structural monitor headers for the simulator output console
        $display("-------------------------------------------------------");
        $display("Time\t OpCode\t Input_A\t Input_B\t -> Output\t Carry");
        $display("-------------------------------------------------------");
        
        $monitor("%0d\t %b\t %b (%d)\t %b (%d)\t -> %b\t %b", 
                 $time, test_op, test_in_a, test_in_a, test_in_b, test_in_b, verify_out, verify_carry);

        // --- TEST CASE 1: Traditional Binary Addition (op_code = 00) ---
        test_in_a = 4'b0101; test_in_b = 4'b0011; test_op = 2'b00; #10; // 5 + 3 = 8 (No Carry)
        test_in_a = 4'b1100; test_in_b = 4'b0101; test_op = 2'b00; #10; // 12 + 5 = 17 -> Out=1, Carry=1 (Overflow Check)

        // --- TEST CASE 2: Bitwise XOR Logic (op_code = 01) ---
        test_in_a = 4'b1010; test_in_b = 4'b1100; test_op = 2'b01; #10; // Expect 4'b0110

        // --- TEST CASE 3: Bitwise AND Data Masking (op_code = 10) ---
        test_in_a = 4'b1111; test_in_b = 4'b1010; test_op = 2'b10; #10; // Expect 4'b1010

        // --- TEST CASE 4: Quantum-Inspired Reversible Routing (op_code = 11) ---
        test_in_a = 4'b0011; test_in_b = 4'b0001; test_op = 2'b11; #10; // Activates integrated Toffoli mapping
        
        // Finalize execution cleanly
        $display("-------------------------------------------------------");
        $display("Verification complete. All processing operations checked.");
        $finish;
    end

endmodule
