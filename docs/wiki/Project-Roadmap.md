# SIGNALINK Project Roadmap

This roadmap separates current implementation from work that still needs evidence. Milestones should only be marked complete when their acceptance checks are met.

## Milestones

### 1. Repository structure and documentation
**Status:** Organization pass completed; documentation continues.

- [x] Group RTL modules and testbenches into dedicated folders.
- [x] Group Python experiments under `software/python/`.
- [x] Place security documents under `docs/security/`.
- [ ] Keep documentation and run commands synchronized with the source.

### 2. RTL verification
**Status:** Verification evidence needs to be recorded.

- [ ] Run the ALU testbench.
- [ ] Run the integrated-core testbench.
- [ ] Run the loopback testbench.
- [ ] Record simulator/version, commands, expected outputs, observed outputs, and pass/fail results.
- [ ] Fix and document any failures before claiming verification.

Relevant files: `rtl/` and `rtl/testbenches/`.

### 3. Sensor-processing experiments
**Status:** Python experiment scripts exist; reproduce and document results.

- [ ] Document input format and assumptions.
- [ ] Run the sensor pipeline on a known test input.
- [ ] Record measurable outputs and edge cases.
- [ ] Document what is simulated versus measured from a physical sensor.

Relevant files: `software/python/sensor_pipeline.py` and `software/python/hardware_bridge_sim.py`.

### 4. Mobile sensor validation
**Status:** The MIT App Inventor project has been imported and loaded; sensor behavior still needs validation.

- [ ] Test each available sensor on the target device.
- [ ] Verify Start and Stop behavior.
- [ ] Record sample readings and device/app conditions.
- [ ] Document unavailable sensors and observed limitations.

### 5. Physical hardware bridge
**Status:** Planned; not yet validated in this repository's current evidence log.

- [ ] Select and document the target board and interface.
- [ ] Define message format, timing, and error handling.
- [ ] Test communication with known inputs.
- [ ] Record successful and failed cases.

### 6. Integrated assistive prototype
**Status:** Future integration milestone.

- [ ] Connect only components that have been individually tested.
- [ ] Define an end-to-end test set and success criteria.
- [ ] Evaluate responsiveness, reliability, and usability.
- [ ] Document limitations and accessibility feedback with appropriate consent.

### 7. Reproducible research
**Status:** Ongoing practice.

- [ ] Publish setup and reproduction instructions.
- [ ] Preserve raw/derived data responsibly and avoid publishing sensitive personal data.
- [ ] Record experiment versions and limitations.
- [ ] Distinguish measured results from hypotheses and future targets.

## Definition of done

A milestone is complete only when its acceptance checks have evidence linked from the [Verification Log](Verification-Log). A folder, code file, or successful import alone is not proof of runtime behavior.
