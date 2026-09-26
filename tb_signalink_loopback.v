`timescale 1ns / 1ps

// =====================================================================
// Project: SIGNALINK (Sense. Process. Communicate. Assist.)
// Module: tb_signalink_loopback
// Description: Full system loopback verification. Connects TX line 
//              directly to RX line to test complete data round-trips.
// =====================================================================

module tb_signalink_loopback;

    // --- Core System Drivers ---
    reg        clk;
    reg        rst_n;
    reg        trigger;
    reg [3:0]  data_a;
    reg [3:0]  data_b;
    reg [1:0]  opcode;

    // --- Interconnect Routing Wires ---
    wire       loopback_wire; // The physical single-wire serial short-circuit
    wire       sys_busy;
    wire       tx_done;
    
    // --- Receiver Side Outputs ---
    wire       rx_ready;
    wire [7:0] rx_received_payload;

    // --- Instantiate Top-Level System (The Talker) ---
    signalink_core transmitter_system (
        .clk(clk),
        .rst_n(rst_n),
        .sys_trigger(trigger),
        .raw_data_a(data_a),
        .raw_data_b(data_b),
        .sys_opcode(opcode),
        .tx_line(loopback_wire),
        .sys_busy(sys_busy),
        .sys_tx_done(tx_done)
    );

    // --- Instantiate Standalone Receiver (The Listener) ---
    uart_rx receiver_engine (
        .clk(clk),
        .rst_n(rst_n),
        .rx_serial(loopback_wire),
        .rx_data_ready(rx_ready),
        .rx_data_out(rx_received_payload)
    );

    // --- 50 MHz System Clock (20ns Period) ---
    always #10 clk = ~clk;

    initial begin
        // Initialize States
        clk     = 1'b0;
        rst_n   = 1'b0;
        trigger = 1'b0;
        data_a  = 4'b0000;
        data_b  = 4'b0000;
        opcode  = 2'b00;

        $display("=======================================================");
        $display("SIGNALINK COMPLETE LOOPBACK TRANSCEIVER SIMULATION");
        $display("=======================================================");
        
        #40;
        rst_n = 1'b1;
        #20;

        // --- Run Loopback Payload Test Case ---
        // Input A = 6 (0110), Input B = 2 (0010). Opcode = 01 (XOR)
        // Expected ALU Output: 6 XOR 2 = 4 (0100) -> Frame = 8'h04
        data_a = 4'b0110;
        data_b = 4'b0010;
        opcode = 2'b01; 
        
        #20;
        trigger = 1'b1;
        #20;
        trigger = 1'b0;

        // --- Wait for the receiver to reconstruct the frame ---
        @(posedge rx_ready);
        
        $display("\n[LOOPBACK SUCCESS] Data caught on receive buffer!");
        $display("Expected Transmitted Byte Frame: 8'h04");
        $display("Actual Reconstructed Payload:   8'h%0h (Binary: %b)", 
                 rx_received_payload, rx_received_payload);
                 
        if (rx_received_payload == 8'h04) begin
            $display("MATCH VERIFIED: Digital logic loopback passed.");
        end else begin
            $display("ERROR: Frame corruption detected in loopback serialization.");
        end

        $display("=======================================================");
        $finish;
    end

endmodule
