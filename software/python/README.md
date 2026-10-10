# Python Signal Processing

Python simulations and sensor-processing experiments live here.

## Scripts

- `sensor_pipeline.py` — synthetic multi-axis sensor stream, missing-value handling, magnitude calculation, and smoothing.
- `hardware_bridge_sim.py` — synthetic sensor waveform, filtering, clipping, and 4-bit quantization for RTL input experiments.

## Run

From the repository root:

```bash
python -m pip install numpy pandas
python software/python/sensor_pipeline.py
python software/python/hardware_bridge_sim.py
```

These scripts use synthetic data; they do not establish measurements from physical hardware.
