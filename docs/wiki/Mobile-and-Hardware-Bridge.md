# Mobile and Hardware Bridge

The MIT App Inventor prototype is a stepping stone toward testing a sensor-to-processing-to-output path. It is not, by itself, evidence of a completed physical hardware bridge.

## Current documented scope

The root README records a SIGNALINK v1.0 MIT App Inventor project that has been imported and loaded. The intended mobile architecture includes:

**Sensors → Processing → Output → Future ESP32 / FPGA**

The project description lists accelerometer, orientation, and proximity sensor inputs; Start/Stop controls; live sensor values; communication output; text-to-speech; and a BluetoothClient reserved for a future ESP32 bridge.

**Important:** These are documented design elements. Each sensor and control must be tested on the actual target device before its behavior is described as verified.

## Device validation checklist

- [ ] Record phone model, OS version, and app/project version.
- [ ] Test whether each requested sensor is available.
- [ ] Start input and confirm readings change when the device changes.
- [ ] Stop input and confirm readings stop updating as expected.
- [ ] Check behavior when a sensor is unavailable or returns an unusual value.
- [ ] Test output and text-to-speech independently.
- [ ] Record screenshots or a short screen recording as evidence, avoiding personal data.
- [ ] Document crashes, delays, and limitations.

## Future ESP32 communication

Before treating Bluetooth or another interface as functional, document:

- Board and firmware version
- Interface and connection settings
- Message framing and data types
- Update rate and timing assumptions
- Disconnect/reconnect behavior
- Invalid-message handling
- Tests using known input and expected output

## Evidence boundary

Successful project import means the project can be loaded by the development environment. It does not prove that sensors, speech output, Bluetooth, or ESP32 communication work end to end. Record each claim at the level actually tested.
