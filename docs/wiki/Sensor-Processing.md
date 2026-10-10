# Sensor Processing

SIGNALINK explores how sensor streams can be transformed into compact, useful representations for responsive assistive applications.

## Relevant source files

- `software/python/sensor_pipeline.py` — sensor-processing experiment.
- `software/python/hardware_bridge_sim.py` — simulated hardware-bridge experiment.

See the [Python folder README](../../software/python/README.md) for the repository's run instructions.

## Recommended experiment record

For each run, document:

1. **Question:** What behavior or engineering assumption is being tested?
2. **Input:** Where the data came from, its units, format, sampling rate, and whether it is synthetic or physical.
3. **Method:** Filtering, thresholding, quantization, feature extraction, or other transformations used.
4. **Parameters:** Thresholds, window sizes, precision, and any tuning choices.
5. **Metrics:** Latency, representation size, error rate, stability, or other relevant measurements.
6. **Results:** Expected versus observed behavior across ordinary and edge cases.
7. **Limitations:** Conditions not tested, dataset limitations, and known failure modes.
8. **Reproduction:** Environment, dependencies, command, and input needed to repeat the experiment.

## Important distinctions

- Simulated sensor values are not physical sensor measurements.
- A smaller representation is not automatically more accurate or more useful.
- A single successful example does not establish robustness.
- Recognition accuracy should be reported with the test-set definition and sample counts.
- Avoid publishing personal or sensitive sensor data without appropriate consent and review.

## Next actions

- Run each script using the instructions in its README.
- Save a small, reproducible test case.
- Record output and failure cases in the [Verification Log](Verification-Log).
- Compare simulated behavior with physical measurements only after the sensor interface is working.
