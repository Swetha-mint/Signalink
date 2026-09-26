`timescale 1ns / 1ps

module tb_i2c_master;

    reg        clk;
    reg        rst_n;
    reg        trigger;
    reg  [6:0] target_addr;

    wire       scl;
    reg        sim_sda_in;
    wire       sda_out;
    wire       sda_oe;

    wire       valid;
    wire [7:0] result_data;

    i2c_master uut (
        .i2c_clk(clk), .rst_n(rst_n), .start_read(trigger), .slave_addr(target_addr),
        .scl(scl), .sda_in(sim_sda_in), .sda_out(sda_out), .sda_oe(sda_oe),
        .data_valid(valid), .sensor_byte(result_data)
    );

    always #10 clk = ~clk;

    initial begin
        clk = 0; rst_n = 0; trigger = 0;
        target_addr = 7'h50;
        sim_sda_in = 1'b1;

        $display("--- I2C MASTER STATE MACHINE SIMULATION INITIALIZED ---");
        #40 rst_n = 1; #20;

        trigger = 1'b1; #20; trigger = 1'b0;

        #250;

        sim_sda_in = 1'b1; #40;
        sim_sda_in = 1'b0; #40;
        sim_sda_in = 1'b1; #40;
        sim_sda_in = 1'b0; #40;
        sim_sda_in = 1'b0; #40;
        sim_sda_in = 1'b1; #40;
        sim_sda_in = 1'b0; #40;
        sim_sda_in = 1'b1; #40;

        @(posedge valid);
        #20;
        $display("Time: %0dns | Fully Reconstructed Data Byte Payload: 8'h%0h", $time, result_data);

        if (result_data == 8'hA5)
            $display("⭐⭐⭐ SUCCESS: I2C Master FSM accurately sequenced and captured sensor byte.");
        else
            $display("❌ ERROR: Frame payload corruption occurred during read phase.");

        $finish;
    end

endmodule
