// =====================================================================
// Project: SIGNALINK (Sense. Process. Communicate. Assist.)
// Module: alu_core
// Description: A 4-bit Arithmetic Logic Unit (ALU) with digital foundations
//              and a quantum-inspired reversible mode selection.
// =====================================================================

module alu_core (
    input  wire [3:0] alu_in_a,   // 4-bit Data Input A
    input  wire [3:0] alu_in_b,   // 4-bit Data Input B
    input  wire [1:0] op_code,     // 2-bit Operation Selector
    output reg  [3:0] alu_out,    // 4-bit Output Data
    output reg        carry_out   // Carry flag for arithmetic overflow
);

    // Internal wires to connect our reversible logic block if needed
    wire q_a, q_b, q_c;
    
    // Instantiate our existing Toffoli Gate inside the ALU framework
    // Using the lower bits of our data inputs for the reversible test mode
    toffoli_gate alu_reversible_unit (
        .a(alu_in_a[0]), 
        .b(alu_in_b[0]), 
        .c(alu_in_a[1]), 
        .q_a(q_a), 
        .q_b(q_b), 
        .q_c(q_c)
    );

    always @(*) begin
        // Reset flags default state
        carry_out = 1'b0;
        
        case (op_code)
            2'b00: begin // Operation 0: Traditional Binary Addition
                {carry_out, alu_out} = alu_in_a + alu_in_b;
            end
            
            2'b01: begin // Operation 1: Bitwise XOR (Fundamental to logic matching)
                alu_out = alu_in_a ^ alu_in_b;
                carry_out = 1'b0;
            end
            
            2'b10: begin // Operation 2: Bitwise AND (Data masking / filtering)
                alu_out = alu_in_a & alu_in_b;
                carry_out = 1'b0;
            end
            
            2'b11: begin // Operation 3: Quantum-Inspired Reversible Routing Mode
                // Here we output the result modified by the internal Toffoli Gate
                alu_out = {alu_in_a[3:2], q_c, q_a};
                carry_out = 1'b0;
            end
            
            default: begin
                alu_out = 4'b0000;
                carry_out = 1'b0;
            end
        endcase
    end

endmodule
