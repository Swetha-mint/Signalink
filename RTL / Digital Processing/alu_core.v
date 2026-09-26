// =====================================================================
// Project: SIGNALINK (Sense. Process. Communicate. Assist.)
// Module: alu_core
// Description: A 4-bit Arithmetic Logic Unit (ALU) with digital foundations
//              and a quantum-inspired reversible mode selection.
// =====================================================================

module alu_core (
    input  wire [3:0] alu_in_a,
    input  wire [3:0] alu_in_b,
    input  wire [1:0] op_code,
    output reg  [3:0] alu_out,
    output reg        carry_out
);

    wire q_a, q_b, q_c;

    toffoli_gate alu_reversible_unit (
        .a(alu_in_a[0]),
        .b(alu_in_b[0]),
        .c(alu_in_a[1]),
        .q_a(q_a),
        .q_b(q_b),
        .q_c(q_c)
    );

    always @(*) begin
        carry_out = 1'b0;
        case (op_code)
            2'b00: begin
                {carry_out, alu_out} = alu_in_a + alu_in_b;
            end
            2'b01: begin
                alu_out = alu_in_a ^ alu_in_b;
                carry_out = 1'b0;
            end
            2'b10: begin
                alu_out = alu_in_a & alu_in_b;
                carry_out = 1'b0;
            end
            2'b11: begin
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
