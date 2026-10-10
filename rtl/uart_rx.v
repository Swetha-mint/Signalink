// =====================================================================
// Project: SIGNALINK (Sense. Process. Communicate. Assist.)
// Module: uart_rx
// Description: A Parameterized UART Receiver Core.
//              Monitors a single-wire serial input, detects framing sequences,
//              and reconstructs incoming bitstreams back into parallel bytes.
// =====================================================================

module uart_rx (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       rx_serial,
    output reg        rx_data_ready,
    output reg  [7:0] rx_data_out
);

    localparam STATE_IDLE  = 2'b00;
    localparam STATE_START = 2'b01;
    localparam STATE_DATA  = 2'b10;
    localparam STATE_STOP  = 2'b11;

    reg [1:0] current_state, next_state;
    reg [2:0] bit_index;
    reg [7:0] rx_shift_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= STATE_IDLE;
        else
            current_state <= next_state;
    end

    always @(*) begin
        next_state = current_state;
        case (current_state)
            STATE_IDLE:  if (rx_serial == 1'b0) next_state = STATE_START;
            STATE_START: next_state = STATE_DATA;
            STATE_DATA:  if (bit_index == 3'b111) next_state = STATE_STOP;
            STATE_STOP:  next_state = STATE_IDLE;
            default:     next_state = STATE_IDLE;
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rx_data_ready <= 1'b0;
            rx_data_out   <= 8'h00;
            bit_index     <= 3'b000;
            rx_shift_reg  <= 8'h00;
        end else begin
            rx_data_ready <= 1'b0;

            case (current_state)
                STATE_IDLE: begin
                    bit_index <= 3'b000;
                end
                STATE_START: begin
                    bit_index <= 3'b000;
                end
                STATE_DATA: begin
                    rx_shift_reg[bit_index] <= rx_serial;
                    if (bit_index < 3'b111)
                        bit_index <= bit_index + 1'b1;
                end
                STATE_STOP: begin
                    rx_data_out   <= rx_shift_reg;
                    rx_data_ready <= 1'b1;
                end
            endcase
        end
    end

endmodule
