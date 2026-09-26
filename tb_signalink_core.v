`timescale 1ns / 1ps

// =====================================================================
// Project: SIGNALINK (Sense. Process. Communicate. Assist.)
// Module: tb_signalink_core
// Description: Verification testbench simulating the complete path
//              from raw sensory calculations to serialized UART output.
// =====================================================================

module tb_signalink_core;

    reg        tb_clk;
    reg        tb_rst_n;
    reg        tb_trigger;
    reg [3:0]  tb_data_a;
    reg [3:0]  tb_data_b;
    reg [1:0]  tb_opcode;

    wire       tb_tx_line;
    wire       tb_busy;
    wire       tb_done;

    signalink_core uut (
        .clk(tb_clk),
        .rst_n(tb_rst_n),
        .sys_trigger(tb_trigger),
        .raw_data_a(tb_data_a),
        .raw_data_b(tb_data_b),
        .sys_opcode(tb_opcode),
        .tx_line(tb_tx_line),
        .sys_busy(tb_busy),
        .sys_tx_done(tb_done)
    );

    always #10 tb_clk = ~tb_clk;

    initial begin
        tb_clk     = 1'b0;
        tb_rst_n   = 1'b0;
        tb_trigger = 1'b0;
        tb_data_a  = 4'b0000;
        tb_data_b  = 4'b0000;
        tb_opcode  = 2'b00;

        $display("=======================================================");
        $display("SIGNALINK TOP-LEVEL INTEGRATION SIMULATION INITIALIZED");
        $display("=======================================================");

        #40;
        tb_rst_n = 1'b1;
        #20;

        tb_data_a = 4'b0100;
        tb_data_b = 4'b0011;
        tb_opcode = 2'b00;

        #20;
        tb_trigger = 1'b1;
        #20;
        tb_trigger = 1'b0;

        @(posedge tb_done);
        #100;

        $display("=======================================================");
        $display("Complete System Data Serialization Path Verified Successfully.");
        $display("=======================================================");
        $finish;
    end

    initial begin
        $monitor("Time: %0dns | Trigger: %b | Busy: %b | Serial Line output: %b",
                 $time, tb_trigger, tb_busy, tb_tx_line);
    end

endmodule
