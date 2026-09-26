`timescale 1ns / 1ps

module tb_register_file;

    reg        clk;
    reg        rst_n;
    reg        wr_en;
    reg  [1:0] wr_addr;
    reg  [1:0] rd_addr_a;
    reg  [1:0] rd_addr_b;
    reg  [3:0] wr_data;

    wire [3:0] out_a;
    wire [3:0] out_b;

    register_file uut (
        .clk(clk), .rst_n(rst_n), .write_en(wr_en),
        .write_addr(wr_addr), .read_addr_a(rd_addr_a), .read_addr_b(rd_addr_b),
        .write_data(wr_data), .read_data_a(out_a), .read_data_b(out_b)
    );

    always #10 clk = ~clk;

    initial begin
        clk = 0; rst_n = 0; wr_en = 0;
        wr_addr = 0; rd_addr_a = 0; rd_addr_b = 0; wr_data = 0;

        $display("--- REGISTER FILE VERIFICATION INITIALIZED ---");
        #40 rst_n = 1; #20;

        wr_addr = 2'b01; wr_data = 4'b1010; wr_en = 1; #20;
        wr_en = 0;

        wr_addr = 2'b10; wr_data = 4'b0111; wr_en = 1; #20;
        wr_en = 0;

        rd_addr_a = 2'b01; rd_addr_b = 2'b10; #20;

        $display("Time: %0dns | Read Port A (Reg 1): %b (Expected: 1010)", $time, out_a);
        $display("Time: %0dns | Read Port B (Reg 2): %b (Expected: 0111)", $time, out_b);

        if (out_a == 4'b1010 && out_b == 4'b0111)
            $display("⭐⭐⭐ REGISTER FILE MEMORY STORAGE MATRIX VERIFIED.");
        else
            $display("❌ MEMORY CORRUPTION IN REGISTER SLOTS.");

        $finish;
    end

endmodule
