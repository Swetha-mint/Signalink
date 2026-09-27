# 🚀 SIGNALINK Open-Source Onboarding: Good First Issues

To help new developers contribute to the SIGNALINK AGPL-3.0 stack without feeling intimidated, we break selected roadmap work into modular, bite-sized tasks. These blueprints can be opened as GitHub Issues for community contributors.

---

## 📌 ISSUE 01: Build a 4-Bit Synchronous Parameterized Decrementer Module

- **Roadmap Tier:** Block 01 (Digital Foundations)
- **Labels:** `good first issue`, `hardware-core`, `RTL`
- **Difficulty:** Easy / Beginner

### 💡 Task Description

Create a self-contained 4-bit decrementer module (`decrementer.v`) inside `RTL / Digital Processing`. The component should subtract `1'b1` on each rising clock edge when an enable flag is high. It is intended as a reusable building block for down-counting loops and assistive tracking logic.

### 🛠️ Technical Requirements

- Inputs: `clk`, `rst_n`, `dec_en`, `[3:0] data_in`
- Outputs: `[3:0] data_out`, `borrow_out`
- `borrow_out` should indicate an underflow when decrementing `4'b0000`.
- Follow the RTL coding and reset conventions used by the existing `alu_core.v` and related modules.
- Include a focused verification testbench.

---

## 📌 ISSUE 02: Expand Python Quantizer Testing via Synthetic Dataset Variation

- **Roadmap Tier:** Block 03 (Sense + Process)
- **Labels:** `good first issue`, `software-bridge`, `data-science`
- **Difficulty:** Easy / Intermediate

### 💡 Task Description

Extend `hardware_bridge_sim.py` with a `generate_step_signal()` function that simulates sudden, jerky movement using a step-function dataset. The goal is to stress-test the existing rolling-average filter and 4-bit quantization pipeline under abrupt changes.

### 🛠️ Technical Requirements

- Use native `pandas` and `numpy`.
- Include sudden amplitude changes from baseline values toward upper operating limits.
- Keep the generated data compatible with the existing filtering and quantization functions.
- Add a small verification or demonstration section showing the filter response to the step input.

---

## 🤝 Contributor Note

These are intentionally scoped as small, understandable entry points. Contributors should read `CONTRIBUTING.md` before opening a pull request and use the repository's existing verification flow where applicable.
