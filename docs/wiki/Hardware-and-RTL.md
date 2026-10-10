# Hardware and RTL

This page describes the digital-design source tree and how to approach verification. Do not claim a module passes simulation until the relevant testbench has been run and its output reviewed.

## Source layout

- `rtl/alu_core.v` — ALU core.
- `rtl/toffoli_gate.v` — reversible-logic gate experiment.
- `rtl/uart_tx.v` — UART transmitter.
- `rtl/uart_rx.v` — UART receiver.
- `rtl/signalink_core.v` — core integration module.
- `rtl/testbenches/tb_alu_core.v` — ALU testbench.
- `rtl/testbenches/tb_signalink_core.v` — core testbench.
- `rtl/testbenches/tb_signalink_loopback.v` — loopback testbench.

See also the [RTL folder README](../../rtl/README.md).

## Verification workflow

1. Install a Verilog simulator such as Icarus Verilog, if it is not already available.
2. From the repository root, run the relevant command documented in `rtl/README.md`.
3. Inspect the complete simulator output and any generated waveform, if applicable.
4. Compare observed behavior with the testbench's expected behavior.
5. Record simulator version, exact command, result, and any limitations in the [Verification Log](Verification-Log).
6. Keep failures visible; do not label a test as passed if it was not run.

## Integration questions to answer

- Are module ports and signal widths consistent?
- Are reset and clock assumptions explicit?
- Does UART timing match the configured clock and baud-rate assumptions?
- Does the loopback test cover both normal and boundary cases?
- Are testbench checks self-checking, or do they only print values?
- Are synthesis, timing, and hardware implementation results available, or is evidence limited to simulation?

## Evidence boundary

RTL source code demonstrates implementation intent. Simulation can provide behavioral evidence under tested conditions. Neither source code nor simulation alone proves that the design works on physical hardware, meets timing after implementation, or is suitable for safety-critical use.
