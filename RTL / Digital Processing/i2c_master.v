// =====================================================================
// Project: SIGNALINK (Sense. Process. Communicate. Assist.)
// Module: i2c_master
// Description: A simplified I2C Master Controller FSM designed to read
//              an 8-bit data packet from a gesture sensor interface.
// =====================================================================

module i2c_master (
    input  wire       i2c_clk,
    input  wire       rst_n,
    input  wire       start_read,
    input  wire [6:0] slave_addr,
    output reg        scl,
    input  wire       sda_in,
    output reg        sda_out,
    output reg        sda_oe,
    output reg        data_valid,
    output reg  [7:0] sensor_byte
);

    localparam STATE_IDLE  = 3'b000;
    localparam STATE_START = 3'b001;
    localparam STATE_ADDR  = 3'b010;
    localparam STATE_READ  = 3'b011;
    localparam STATE_STOP  = 3'b100;

    reg [2:0] current_state, next_state;
    reg [3:0] bit_counter;
    reg [7:0] addr_frame;

    always @(posedge i2c_clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= STATE_IDLE;
        else
            current_state <= next_state;
    end

    always @(*) begin
        next_state = current_state;
        case (current_state)
            STATE_IDLE:  if (start_read) next_state = STATE_START;
            STATE_START: next_state = STATE_ADDR;
            STATE_ADDR:  if (bit_counter == 4'd8) next_state = STATE_READ;
            STATE_READ:  if (bit_counter == 4'd7) next_state = STATE_STOP;
            STATE_STOP:  next_state = STATE_IDLE;
            default:     next_state = STATE_IDLE;
        endcase
    end

    always @(posedge i2c_clk or negedge rst_n) begin
        if (!rst_n) begin
            scl         <= 1'b1;
            sda_out     <= 1'b1;
            sda_oe      <= 1'b1;
            bit_counter <= 4'd0;
            data_valid  <= 1'b0;
            sensor_byte <= 8'h00;
            addr_frame  <= 8'h00;
        end else begin
            data_valid <= 1'b0;

            case (current_state)
                STATE_IDLE: begin
                    scl         <= 1'b1;
                    sda_out     <= 1'b1;
                    sda_oe      <= 1'b1;
                    bit_counter <= 4'd0;
                    if (start_read)
                        addr_frame <= {slave_addr, 1'b1};
                end

                STATE_START: begin
                    scl         <= 1'b1;
                    sda_out     <= 1'b0;
                    sda_oe      <= 1'b1;
                    bit_counter <= 4'd0;
                end

                STATE_ADDR: begin
                    scl <= ~scl;
                    if (bit_counter < 4'd8) begin
                        sda_oe      <= 1'b1;
                        sda_out     <= addr_frame[4'd7 - bit_counter];
                        bit_counter <= bit_counter + 1'b1;
                    end else begin
                        sda_oe      <= 1'b0;
                        bit_counter <= 4'd0;
                    end
                end

                STATE_READ: begin
                    scl    <= ~scl;
                    sda_oe <= 1'b0;
                    if (scl == 1'b0) begin
                        sensor_byte[4'd7 - bit_counter] <= sda_in;
                        if (bit_counter < 4'd7)
                            bit_counter <= bit_counter + 1'b1;
                        else
                            bit_counter <= 4'd0;
                    end
                end

                STATE_STOP: begin
                    scl        <= 1'b1;
                    sda_oe     <= 1'b1;
                    sda_out    <= 1'b1;
                    data_valid <= 1'b1;
                end
            endcase
        end
    end

endmodule
