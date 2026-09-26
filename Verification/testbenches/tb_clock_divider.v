`timescale 1ns / 1ps

module tb_clock_divider;

    reg  tb_clk_in;
    reg  tb_rst_n;
    wire tb_clk_out;

    clock_divider #(.TOGGLE_LIMIT(32'd4)) uut (
        .clk_in(tb_clk_in),
        .rst_n(tb_rst_n),
        .clk_out(tb_clk_out)
    );

    always #10 tb_clk_in = ~tb_clk_in;

    initial begin
        tb_clk_in = 0;
        tb_rst_n  = 0;

        $display("--- CLOCK DIVIDER VERIFICATION INITIALIZED ---");
        #40;
        tb_rst_n = 1;
        #200;

        $display("--- CLOCK DIVIDER TESTING COMPLETE ---");
        $finish;
    end

    initial begin
        $monitor("Time: %0dns | Master Clock: %b | Slow Divided Clock: %b",
                 $time, tb_clk_in, tb_clk_out);
    end

endmodule
