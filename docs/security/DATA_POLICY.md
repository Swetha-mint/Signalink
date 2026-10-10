# SIGNALINK Data Stewardship & Privacy Principles

**Project:** SIGNALINK (Sense. Process. Communicate. Assist.)  
**Status:** Project data and privacy principles  
**License:** AGPL-3.0

## 1. Our principle

> **Data is valuable. We protect it; we do not treat other people's data as something to take.**

SIGNALINK is an open-source engineering project, but open engineering does **not** mean indiscriminate collection, publication, or sharing of personal data.

We aim to build useful technology while respecting the people whose participation, feedback, or environments help us learn.

## 2. Data minimization

SIGNALINK should collect or retain only the information reasonably necessary for a clearly defined engineering, research, testing, or accessibility purpose.

Whenever practical, we prefer:

- Local processing over unnecessary cloud transmission.
- Derived features over raw personal data.
- Aggregated results over individually identifiable records.
- Short retention periods over indefinite storage.
- Explicit documentation of what is collected and why.

## 3. Personal and sensitive data

SIGNALINK must not ask contributors or participants to place personal, confidential, biometric, health, institutional, or other sensitive information into a public repository merely to participate in the project.

Do **not** commit such information to GitHub.

Examples include:

- Names, phone numbers, addresses, or personal identifiers.
- Raw images, video, or audio containing identifiable people.
- Raw gesture or sensor recordings that could reasonably identify a person.
- Health or accessibility records that identify an individual.
- Institution-confidential documents or operational information.
- Authentication credentials, API keys, tokens, or private cryptographic material.

If sensitive information is genuinely necessary for an approved study or pilot, the collection, storage, access, retention, and deletion process must be defined separately and handled through an appropriate controlled environment.

## 4. Consent and participation

When SIGNALINK testing, research, or pilot work involves people or institutions:

- Participation should be voluntary and appropriately informed.
- The purpose of data collection should be clear before collection.
- Only necessary information should be collected.
- Participants should not be pressured to provide personal information.
- Institutional or project approvals should be obtained where required.
- Data should not be reused for an unrelated purpose simply because it was available.

## 5. Open source does not mean open data

SIGNALINK's source code is open-source under the repository's stated license. That does **not** automatically make every dataset, experiment record, participant contribution, or real-world observation public.

Open-source engineering and responsible data stewardship are compatible:

**Open code + documented methods + responsible data handling.**

Where datasets or benchmarks are published, SIGNALINK will consider whether they are appropriate for public release and will favor minimized, aggregated, anonymized, synthetic, or otherwise safely shareable forms where appropriate.

## 6. Contributions to the repository

Before opening a pull request, contributors should check that their submission contains no personal or confidential information.

If a contribution includes data, contributors should document:

- What the data represents.
- Why it is needed.
- Its source and permission/license status.
- Whether it contains personal or sensitive information.
- Any restrictions on redistribution or reuse.

When in doubt, **do not publish the data first**. Raise the question with the maintainers privately.

## 7. Security and access

SIGNALINK treats data protection as part of system architecture.

The project therefore aims to:

- Minimize unnecessary data exposure.
- Keep sensitive processing local where practical.
- Restrict access to data that does not belong in the public repository.
- Separate public engineering artifacts from controlled research data.
- Document security boundaries as the system evolves.

See [THREAT_MODEL.md](THREAT_MODEL.md) for the project's current security architecture and threat-model direction.

## 8. Project data as an engineering asset

SIGNALINK may generate technical information such as benchmark results, failure cases, test conditions, model evaluation metrics, and engineering observations.

These can be valuable engineering assets.

The project therefore aims to **protect the integrity, provenance, and appropriate access to project data** rather than treating data as something to collect indiscriminately.

Useful project data should help us:

**Measure → Learn → Improve → Verify.**

## 9. No unnecessary surveillance

SIGNALINK is an assistive communication project. Its purpose is not to create a general-purpose surveillance system.

Features involving cameras, sensors, or other inputs should be designed around the minimum information necessary to provide the intended functionality.

## 10. Important scope note

This document describes SIGNALINK's engineering and project principles. It is **not a legal privacy policy, regulatory certification, or guarantee of compliance with every jurisdiction or deployment environment**.

Requirements will be reviewed and strengthened as SIGNALINK moves from prototypes to institution-approved pilots and physical deployments.