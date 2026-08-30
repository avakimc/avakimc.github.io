---
title: Real-Time Vehicle Telemetry Dashboard
context: Columbia University's Formula SAE Team · Telemetry Sub-Team
dates: Fall 2025 – Spring 2026
order: 2
tags: [Python, JavaScript, WebSockets, Chart.js]
links: []
media:
  - src: /media/telemetry-mock-mode.jpg
    alt: >-
      The telemetry dashboard running in mock mode: six live time-series charts for wheel
      speed, brake pressure, damper position, motor speed, g-force, and torque, beside
      tables of vehicle state, cell temperatures, voltages, and tire temperatures.
    caption: The dashboard in mock mode, driven entirely by simulated signals.
    width: 1400
    height: 659
---

A telemetry system that decodes live vehicle data and visualizes it in a browser dashboard.
Packets arrive over a serial link and are decoded against signal definitions. A Python
WebSocket server pushes the latest values to the browser, where JavaScript routes each
signal to a Chart.js time series, a status table, or a fault alert. Measurements include
wheel and motor speed, torque, acceleration, battery temperature and voltage, and tire
temperature.

I contributed to the team's existing system. I first refactored the entire repository,
eliminating dead and repetitive code blocks and reducing bug-prone patterns.

My largest individual contribution was a configurable mock telemetry mode: simulated
versions of every expected signal, independently randomized within per-measurement ranges
and updated at a configurable frequency, pushed through the same pipeline as live data. It
let the dashboard and frontend be developed and tested while the physical car was still in
development.

I also built a high-frequency stress-testing mode that updates large groups of signals
repeatedly and simulates periodic bursts of signal traffic — a controlled way to see how
the backend, WebSocket server, and frontend behave under heavier loads.

<!-- OPTIONAL: a screenshot from a live competition run would pair well with the mock-mode
     one already here.
     OPTIONAL: the source doc has an ASCII architecture diagram of the full pipeline. It
     would need redrawing as inline SVG to be legible on mobile — ask if you want it. -->
