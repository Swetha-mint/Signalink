// =====================================================================
// Project: SIGNALINK (Sense. Process. Communicate. Assist.)
// Module: clock_divider
// Description: Parameterized Clock Divider to scale high-frequency
//              system clocks down to standard peripheral speeds (e.g., I2C).
// =====================================================================

module clock_divider #(
    parameter TOGGLE_LIMIT = 32'd250
)(
    input  wire clk_in,
    input  wire rst_n,
    output reg  clk_out
);

    reg [31:0] counter;

    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 32'd0;
            clk_out <= 1'b0;
        end else begin
            if (counter >= (TOGGLE_LIMIT - 1)) begin
                counter <= 32'd0;
                clk_out <= ~clk_out;
            end else begin
                counter <= counter + 1'b1;
            end
        end
    end

endmodule
