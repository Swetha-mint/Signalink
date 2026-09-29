# SIGNALINK Signal Lab — Experiment 01: Noise

**Goal:** observe how a useful signal changes when controlled noise is introduced, then explore how SIGNALINK can make stable decisions from a noisy input.

## Desmos model

Clean reference:

`y = A sin(2πfx)`

Noisy signal:

`y_noise = A sin(2πfx) + N sin(20πx)`

## Experiment 01A — Noise

- **Clean signal:** the reference waveform is clearly distinguishable.
- **Noisy signal:** the added higher-frequency component makes the underlying information harder to distinguish.

## Experiment 01B — Threshold

We introduced a decision threshold so SIGNALINK can classify a measured signal as detected or not detected.

Conceptually:

`y ≥ T → 1`

`y < T → 0`

This exposed an important problem: if noise makes the measured value repeatedly cross the threshold, the output can rapidly switch between 0 and 1.

## Experiment 01C — Hysteresis

To reduce this unstable switching, we introduced separate ON and OFF thresholds:

`T_on = 0.8`

`T_off = 0.2`

Decision behavior:

- `y ≥ 0.8` → switch **ON / 1**
- `y ≤ 0.2` → switch **OFF / 0**
- `0.2 < y < 0.8` → **keep the previous state**

The region between the two thresholds is the **hysteresis region**. Small fluctuations inside this region do not immediately change the output state.

### Key observation

A simple threshold asks: **"Is the signal above this value?"**

Hysteresis adds memory to the decision behavior: **"Has the signal crossed the appropriate boundary to change state?"**

This gives SIGNALINK a more stable decision mechanism when the input is noisy.

## Current pipeline

**Sense → Noise → Threshold → Hysteresis → Stable Decision**

## Next step

Implement the hysteresis behavior as an actual discrete-time state model in Desmos, then compare it with a circuit-level implementation.

This experiment begins the SIGNALINK **Sense → Process → Communicate → Assist** pipeline.
