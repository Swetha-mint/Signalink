// =====================================================================
// Project: SIGNALINK (Sense. Process. Communicate. Assist.)
// Module: toffoli_gate
// Description: A 3-bit Reversible Quantum-Inspired Logic Gate.
//              If both control inputs (a and b) are 1, it flips the 
//              target input (c). Otherwise, inputs pass through.
//              This ensures zero information loss in computational pathways.
// =====================================================================

module toffoli_gate (
    input  wire a,
    input  wire b,
    input  wire c,
    output wire q_a,
    output wire q_b,
    output wire q_c
);

    assign q_a = a;
    assign q_b = b;
    assign q_c = c ^ (a & b);

endmodule
