// =====================================================================
// Project: SIGNALINK (Sense. Process. Communicate. Assist.)
// Module: uart_tx
// Description: A Parameterized UART Transmitter Core.
//              Converts parallel data words into a time-synchronized
//              serial bit stream for assistive peripheral routing.
// =====================================================================

module uart_tx (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       tx_start,
    input  wire [7:0] tx_data,
    output reg        tx_serial,
    output reg        tx_active,
    output reg        tx_done
);

    localparam STATE_IDLE  = 2'b00;
    localparam STATE_START = 2'b01;
    localparam STATE_DATA  = 2'b10;
    localparam STATE_STOP  = 2'b11;

    reg [1:0] current_state, next_state;
    reg [2:0] bit_index;
    reg [7:0] tx_buffer;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= STATE_IDLE;
        else
            current_state <= next_state;
    end

    always @(*) begin
        next_state = current_state;
        case (current_state)
            STATE_IDLE:  if (tx_start) next_state = STATE_START;
            STATE_START: next_state = STATE_DATA;
            STATE_DATA:  if (bit_index == 3'b111) next_state = STATE_STOP;
            STATE_STOP:  next_state = STATE_IDLE;
            default:     next_state = STATE_IDLE;
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx_serial  <= 1'b1;
            tx_active  <= 1'b0;
            tx_done    <= 1'b0;
            bit_index  <= 3'b000;
            tx_buffer  <= 8'h00;
        end else begin
            tx_done <= 1'b0;
            case (current_state)
                STATE_IDLE: begin
                    tx_serial <= 1'b1;
                    tx_active <= 1'b0;
                    bit_index <= 3'b000;
                    if (tx_start)
                        tx_buffer <= tx_data;
                end
                STATE_START: begin
                    tx_active <= 1'b1;
                    tx_serial <= 1'b0;
                end
                STATE_DATA: begin
                    tx_serial <= tx_buffer[bit_index];
                    if (bit_index < 3'b111)
                        bit_index <= bit_index + 1'b1;
                end
                STATE_STOP: begin
                    tx_serial <= 1'b1;
                    tx_done   <= 1'b1;
                    tx_active <= 1'b0;
                end
            endcase
        end
    end
endmodule
