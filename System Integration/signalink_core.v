// =====================================================================
// Project: SIGNALINK (Sense. Process. Communicate. Assist.)
// Module: signalink_core
// Description: Upgraded Top-Level System Wrapper. Integrates ALU execution
//              with a Synchronous Register File for internal memory storage
//              before serializing communication packages out to UART blocks.
// =====================================================================

module signalink_core (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       sys_trigger,
    input  wire       reg_write_en,
    input  wire [1:0] target_reg,
    input  wire [3:0] raw_data_a,
    input  wire [3:0] raw_data_b,
    input  wire [1:0] sys_opcode,
    output wire       tx_line,
    output wire       sys_busy,
    output wire       sys_tx_done
);

    wire [3:0] alu_processed_payload;
    wire       alu_carry_flag;
    wire [3:0] memory_saved_data;
    wire [7:0] extended_uart_frame;

    alu_core computational_engine (
        .alu_in_a(raw_data_a), .alu_in_b(raw_data_b), .op_code(sys_opcode),
        .alu_out(alu_processed_payload), .carry_out(alu_carry_flag)
    );

    register_file central_memory (
        .clk(clk), .rst_n(rst_n),
        .write_en(reg_write_en), .write_addr(target_reg),
        .read_addr_a(target_reg), .read_addr_b(2'b00),
        .write_data(alu_processed_payload),
        .read_data_a(memory_saved_data), .read_data_b()
    );

    assign extended_uart_frame = {4'b0000, memory_saved_data};

    uart_tx communication_engine (
        .clk(clk), .rst_n(rst_n), .tx_start(sys_trigger),
        .tx_data(extended_uart_frame), .tx_serial(tx_line),
        .tx_active(sys_busy), .tx_done(sys_tx_done)
    );

endmodule
