`timescale 1ns / 1ps

// =====================================================================
// Project: SIGNALINK (Sense. Process. Communicate. Assist.)
// Module: tb_signalink_loopback
// Description: Upgraded full system loopback verification testing
//              the computational ALU, internal memory registers,
//              and serial communication pathways together.
// =====================================================================

module tb_signalink_loopback;

    reg        clk;
    reg        rst_n;
    reg        trigger;
    reg        reg_we;
    reg  [1:0] target_addr;
    reg [3:0]  data_a;
    reg [3:0]  data_b;
    reg [1:0]  opcode;

    wire       loopback_wire;
    wire       sys_busy;
    wire       tx_done;
    wire       rx_ready;
    wire [7:0] rx_received_payload;

    signalink_core transmitter_system (
        .clk(clk), .rst_n(rst_n), .sys_trigger(trigger),
        .reg_write_en(reg_we), .target_reg(target_addr),
        .raw_data_a(data_a), .raw_data_b(data_b), .sys_opcode(opcode),
        .tx_line(loopback_wire), .sys_busy(sys_busy), .sys_tx_done(tx_done)
    );

    uart_rx receiver_engine (
        .clk(clk), .rst_n(rst_n), .rx_serial(loopback_wire),
        .rx_data_ready(rx_ready), .rx_data_out(rx_received_payload)
    );

    always #10 clk = ~clk;

    initial begin
        clk         = 1'b0;
        rst_n       = 1'b0;
        trigger     = 1'b0;
        reg_we      = 1'b0;
        target_addr = 2'b00;
        data_a      = 4'b0000;
        data_b      = 4'b0000;
        opcode      = 2'b00;

        $display("=======================================================");
        $display("🎛  SIGNALINK INTEGRATED CORE & MEMORY LOOPBACK TEST   ");
        $display("=======================================================");

        #40;
        rst_n = 1'b1;
        #20;

        data_a = 4'b0110;
        data_b = 4'b0010;
        opcode = 2'b01;
        target_addr = 2'b10;
        reg_we = 1'b1;

        #20;
        reg_we = 1'b0;

        trigger = 1'b1;
        #20;
        trigger = 1'b0;

        @(posedge rx_ready);

        $display("\n[LOOPBACK SUCCESS] Data Caught on Receive Buffer!");
        $display("Expected Transmitted Memory Byte: 8'h04");
        $display("Actual Reconstructed Payload:     8'h%0h (Binary: %b)",
                 rx_received_payload, rx_received_payload);

        if (rx_received_payload == 8'h04)
            $display("⭐⭐⭐ MATCH VERIFIED: Computation + Memory + Communication loop is intact.");
        else
            $display("❌ ERROR: Frame corruption detected in loopback serialization.");

        $display("=======================================================");
        $finish;
    end

endmodule
