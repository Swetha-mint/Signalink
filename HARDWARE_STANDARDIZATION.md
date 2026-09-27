# 📐 SIGNALINK Hardware Standardization & Future-Proofing

To keep the SIGNALINK hardware architecture maintainable as Edge AI and embedded workloads evolve, the project follows an accessible, verification-first RTL workflow while defining a clear path toward SystemVerilog and FPGA prototyping.

## 1. Language Migration Path: SystemVerilog Core

The initial MVP infrastructure uses structural Verilog for accessibility and straightforward simulation. Future feature blocks and scaled acceleration cores are planned to use SystemVerilog (IEEE 1800).

Planned benefits include:

- **Enhanced Verification:** SystemVerilog `interface` constructs can simplify connections between the ALU, Register File, I2C, and future communication blocks.
- **Strong Typing:** `logic`, `enum`, and packed structures can make data-bus and state-machine mismatches easier to detect during compilation and verification.
- **Scalable RTL Architecture:** The migration path is intended to support larger verification environments without forcing the current MVP modules to be rewritten prematurely.

## 2. FPGA Target Prototyping Hardware

SIGNALINK aims to remain usable with accessible, off-the-shelf development boards. An initial target family for future FPGA prototyping is the AMD Xilinx Artix-7 ecosystem, including boards such as the Digilent Basys 3 and Arty A7.

### Resource and Design Constraints

- Keep the core design lightweight enough for entry-level FPGA experimentation.
- Track LUT, flip-flop, BRAM, and clock-resource usage during synthesis rather than treating a fixed percentage as a universal requirement.
- Keep clock domains explicit and avoid unnecessary clock-domain crossings.
- Use consistent reset conventions across modules and verify reset behavior in simulation.

## 3. Verification-First Standard

Every new hardware block should have a focused testbench before it is considered integrated into the system architecture.

Recommended flow:

```text
RTL Module
   ↓
Focused Testbench
   ↓
Simulation / Assertions
   ↓
System Integration
   ↓
Integration Verification
   ↓
FPGA Prototype
```

This keeps the current SIGNALINK architecture understandable while leaving a clean path toward larger hardware implementations.

## 4. Compatibility Principle

Hardware standardization is a roadmap constraint, not a requirement to prematurely optimize the MVP. Existing Verilog modules remain valid learning and verification artifacts while future modules can progressively adopt SystemVerilog and FPGA-oriented verification practices.
