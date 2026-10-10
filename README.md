# SIGNALINK

> **Sense → Process → Communicate → Assist**

SIGNALINK is an open-source engineering platform exploring low-latency assistive communication technologies.

## Repository Structure

```text
.
├── index.html, script.js        # GitHub Pages landing page (kept at root)
├── rtl/                         # Verilog RTL modules
│   └── testbenches/             # RTL simulation testbenches
├── software/python/             # Sensor and hardware-bridge simulations
├── docs/                         # Project and milestone documentation
│   ├── security/                # Data stewardship and threat model
│   └── wiki/                    # Engineering wiki source pages
├── README.md
├── CONTRIBUTING.md
└── LICENSE
```

The website entry point stays at the repository root so the existing GitHub Pages setup and relative asset paths keep working. RTL and Python examples are grouped by purpose; security documentation is under `docs/security/`. The engineering documentation source pages are under `docs/wiki/`.

## Engineering documentation

Start with the [SIGNALINK Engineering Wiki Home](docs/wiki/Home.md), then explore the [project roadmap](docs/wiki/Project-Roadmap.md), [hardware and RTL guide](docs/wiki/Hardware-and-RTL.md), [sensor processing](docs/wiki/Sensor-Processing.md), [mobile and hardware bridge](docs/wiki/Mobile-and-Hardware-Bridge.md), [experiments and research](docs/wiki/Experiments-and-Research.md), and [verification log](docs/wiki/Verification-Log.md).

These Markdown pages are maintained in the repository as source documentation. GitHub's separate Wiki pages must be published through the repository's Wiki interface.

## What we explore

- **Edge AI** — local, responsive intelligence
- **Sensory processing** — turning real-world signals into structured information
- **Embedded systems** — hardware–software integration
- **VLSI & digital design** — RTL, simulation, architectures, and processing cores
- **Communication** — efficient digital interfaces and protocols
- **Quantum-inspired computing** — an exploratory research direction

Sign-language communication is one starting application within a broader mission: using engineering to create practical technology for communities whose communication and accessibility needs are often overlooked.

## Build philosophy

**Learn → Build → Measure → Explain → Share**

We want prototypes and research to be reproducible, documented, and open to improvement.

## Roadmap

1. Digital foundations: logic, ALU, registers, processing core
2. Communication core: UART, interfaces, RTL and simulation
3. Sense + process: sensors, signal processing, edge intelligence
4. Assistive systems: integrated communication prototypes
5. Research frontier: hardware acceleration and quantum-inspired exploration

## Mobile / Hardware Bridge — SIGNALINK v1.0

**New milestone:** a working **MIT App Inventor SIGNALINK v1.0** project has now been successfully imported and loaded.

The Version 1 mobile architecture establishes the public-facing signal path:

**SENSORS → PROCESSING → OUTPUT → FUTURE ESP32 / FPGA**

Current Version 1 scope:

- Phone **Accelerometer**
- **Orientation Sensor**
- **Proximity Sensor**
- Start/Stop sensor input
- Live sensor-value display
- Communication output
- Text-to-speech demonstration
- **BluetoothClient** reserved for the future ESP32 bridge
- SIGNALINK identity: **Sense. Process. Communicate. Assist.**

The mobile app is being used as a bridge toward the next hardware stage rather than as the final SIGNALINK architecture. Internal signal-processing methods remain an engineering layer behind the presentation interface.

> **Milestone status:** MIT App Inventor project import validated. Sensor behavior and ESP32 communication are the next implementation steps.

## Data Stewardship & Privacy

> **Data is valuable. We protect it; we do not treat other people's data as something to take.**

SIGNALINK is open-source, but open engineering does **not** mean indiscriminate collection or publication of personal data.

We aim to:

- Collect or retain only data necessary for a defined engineering, research, testing, or accessibility purpose.
- Prefer local processing, derived features, aggregation, and minimized retention where practical.
- Avoid placing personal, biometric, health, confidential institutional, credential, or other sensitive information in the public repository.
- Use appropriate consent and institutional approval for real-world testing and pilots where required.
- Distinguish **open source code** from **open data**.
- Protect the integrity, provenance, and appropriate access of project-generated technical data.

**Open code + documented methods + responsible data handling.**

Read the full [SIGNALINK Data Stewardship & Privacy Principles](docs/security/DATA_POLICY.md).

## Security Architecture

SIGNALINK treats security and privacy as architectural concerns from the beginning because future assistive systems may process sensitive gestural, sensor-derived, and biometric inputs.

The repository maintains a dedicated threat model describing the security boundary between the open-source community architecture and future hardened Enterprise/Silicon architecture.

🛡️ **[Read the SIGNALINK Threat Model & Security Specification](docs/security/THREAT_MODEL.md)**

The security specification documents:

- Sensor-data interception and bus-level threats
- Firmware tampering and hardware root-of-trust requirements
- Side-channel considerations
- Replay and authenticated-communication requirements
- Future protected sensory-processing boundaries
- Vulnerability disclosure expectations

> **Security status:** The threat model distinguishes implemented prototype capabilities from future security architecture targets. SIGNALINK is not currently presented as a hardened security product or security certification.

## Website

`index.html` is the project landing page and is designed for GitHub Pages.

## Status

Early-stage, actively developing. Blocks 01–03 currently contain implemented and verified development work, while Block 04 is the next assistive-system integration phase and Block 05 is the research frontier.

## License

SIGNALINK is released under the **GNU Affero General Public License v3.0 (AGPL-3.0)**.

See [`LICENSE`](LICENSE) for the full license text.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for contribution guidelines and [`.github/ISSUE_TEMPLATE/`](.github/ISSUE_TEMPLATE/) for structured bug reports and feature requests.
