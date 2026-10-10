# RTL and Digital Design

Synthesizable Verilog modules are kept in this folder. Simulation testbenches live in `testbenches/`.

## RTL modules

- `alu_core.v` — 4-bit ALU core
- `toffoli_gate.v` — reversible Toffoli logic gate
- `uart_tx.v` — UART transmitter
- `uart_rx.v` — UART receiver
- `signalink_core.v` — top-level SIGNALINK integration wrapper
- `testbenches/` — RTL simulation testbenches

## Example simulations

Run from the repository root in an environment with Icarus Verilog installed:

```bash
iverilog -o /tmp/alu_test rtl/alu_core.v rtl/testbenches/tb_alu_core.v
vvp /tmp/alu_test

iverilog -o /tmp/core_test rtl/alu_core.v rtl/uart_tx.v rtl/signalink_core.v rtl/testbenches/tb_signalink_core.v
vvp /tmp/core_test

iverilog -o /tmp/loopback_test rtl/alu_core.v rtl/uart_tx.v rtl/uart_rx.v rtl/signalink_core.v rtl/testbenches/tb_signalink_loopback.v
vvp /tmp/loopback_test
```

If a testbench uses additional module dependencies, include those source files in the same `iverilog` command. Keep generated simulation artifacts outside the repository.
