# SIGNALINK v1.0 — MIT App Inventor Mobile Bridge

## Milestone

SIGNALINK v1.0 has been successfully imported and loaded in MIT App Inventor using a compatible Version 1 component configuration.

This establishes the first mobile application layer for the SIGNALINK hardware roadmap.

## Public-facing architecture

**SENSORS → PROCESSING → OUTPUT → FUTURE ESP32 / FPGA**

### Current Version 1 scope

1. SIGNALINK — Sense. Process. Communicate. Assist.
2. Phone Accelerometer
3. Orientation Sensor
4. Proximity Sensor
5. Start/Stop sensor input
6. Live sensor values
7. Communication output
8. Text-to-speech demo
9. BluetoothClient reserved for the future ESP32 bridge
10. Architecture shown as SENSORS → PROCESSING → OUTPUT → FUTURE ESP32 / FPGA

## Engineering boundary

The Version 1 App Inventor interface is intentionally a clean demonstration and integration layer. Deeper signal-processing methods can remain behind this interface and evolve independently as the project moves toward ESP32, external sensors, FPGA/RTL, and later silicon-oriented work.

## Next implementation stage

- Validate live sensor readings on a physical phone.
- Implement the sensor start/stop blocks.
- Implement the communication-output behavior.
- Validate the text-to-speech demonstration.
- Establish the Bluetooth communication path when the ESP32 bridge is ready.

## Status

**Import:** Validated  
**Version:** 1.0  
**Next:** Sensor behavior → ESP32 bridge
