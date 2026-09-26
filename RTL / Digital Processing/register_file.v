// =====================================================================
// Project: SIGNALINK (Sense. Process. Communicate. Assist.)
// Module: register_file
// Description: A 4-entry by 4-bit synchronous Register File memory block.
//              Allows the ALU to store and recall past calculation states.
// =====================================================================

module register_file (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       write_en,
    input  wire [1:0] write_addr,
    input  wire [1:0] read_addr_a,
    input  wire [1:0] read_addr_b,
    input  wire [3:0] write_data,
    output wire [3:0] read_data_a,
    output wire [3:0] read_data_b
);

    reg [3:0] memory_array [3:0];

    assign read_data_a = memory_array[read_addr_a];
    assign read_data_b = memory_array[read_addr_b];

    integer i;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 4; i = i + 1)
                memory_array[i] <= 4'b0000;
        end else if (write_en) begin
            memory_array[write_addr] <= write_data;
        end
    end

endmodule
