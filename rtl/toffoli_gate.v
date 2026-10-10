// =====================================================================
// Project: SIGNALINK (Sense. Process. Communicate. Assist.)
// Module: toffoli_gate
// Description: A 3-bit Reversible Quantum-Inspired Logic Gate.
//              If both control inputs (a and b) are 1, it flips the 
//              target input (c). Otherwise, inputs pass through.
//              This ensures zero information loss in computational pathways.
// =====================================================================

module toffoli_gate (
    input  wire a,      // Control input 1
    input  wire b,      // Control input 2
    input  wire c,      // Target input
    output wire q_a,    // Passthrough output 1
    output wire q_b,    // Passthrough output 2
    output wire q_c     // Transformed target output
);

    // Control bits pass through completely unchanged (Reversible Property)
    assign q_a = a;
    assign q_b = b;

    // Target bit flips ONLY if both control bits are high (a AND b)
    assign q_c = c ^ (a & b);

endmodule
