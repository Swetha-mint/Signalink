# SIGNALINK Verification Log

This log records evidence at the level currently documented. Update it when a test is actually run; include date, environment, exact procedure, and result.

## Initial status snapshot

| Area | Current evidence | Status / next check |
|---|---|---|
| Repository organization | RTL, testbenches, Python scripts, and security docs were grouped into folders; destination paths were checked after the move. | Organization pass completed; continue checking links and instructions. |
| RTL modules | Source modules and testbench files are present in the repository. | Runtime verification not confirmed by this log. Run the testbenches and record results. |
| Python experiments | Sensor pipeline and hardware-bridge simulation scripts are present. | Re-run with documented inputs and record observed output. |
| GitHub Pages | `index.html` and `script.js` remain at the repository root. | Website runtime was not re-tested after file organization. |
| MIT App Inventor | Project import/load was reported successful in project notes and the README. | Validate each sensor and control on the target device. |
| Physical sensor integration | Not established by the evidence recorded here. | Planned validation. |
| ESP32 communication | Not established by the evidence recorded here. | Planned validation with a physical board and reproducible tests. |

## How to add a verification entry

For every test, record:

- **Date:**
- **Component / commit:**
- **Environment:** simulator, version, OS, device, or board
- **Command / procedure:**
- **Expected result:**
- **Observed result:**
- **Outcome:** pass, fail, blocked, or not run
- **Evidence:** logs, screenshots, waveform, or linked artifact
- **Limitations / follow-up:**

## Rules for status labels

- **Present:** a file or project artifact exists.
- **Imported / loaded:** the development environment opened the project.
- **Run:** the code or procedure was executed.
- **Simulation verified:** the test was executed and observed behavior matched defined expectations under stated conditions.
- **Software demonstrated:** the application behavior was observed in its software environment.
- **Hardware tested:** the behavior was tested with the identified physical hardware.
- **Blocked / not run:** no passing result should be implied.

Do not convert an unchecked item into a completed milestone without evidence.
