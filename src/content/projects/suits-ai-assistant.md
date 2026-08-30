---
title: Luna — In-Headset Voice Assistant
context: Columbia Space Initiative · NASA SUITS Challenge
role: AIA Sub-Team Co-Lead
dates: Fall 2025 – Spring 2026
order: 3
tags: [Unity, C#, Magic Leap 2, OpenXR, Vosk, Text-to-Speech]
links: []
media: []
---

Part of a Unity augmented-reality system built for the NASA SUITS challenge, running on a
Magic Leap 2 headset, which supports an astronaut through simulated tasks and navigation.
I was one of two co-leads for the AI Assistant (AIA) sub-team, which built a voice-driven
agent named Luna that answers spoken questions about tasks and telemetry data and moves
the astronaut between mission scenes hands-free.

Luna is activated by the spoken phrase "Hey Luna" or a button press, and uses on-device
transcription through Vosk with the partial transcript shown live as the astronaut speaks.
Recording stops automatically after a pause, or once the button is pressed again. The
final transcript goes to a Gemma backend, set up by my sub-team co-lead, and the answer is
parsed, displayed in a transparent textbox that doesn't block the wearer's view, and
spoken aloud through text-to-speech.

Development was shaped by constraints of Unity and the Magic Leap 2:

- Speech-to-text moved from Whisper to Vosk once the Magic Leap OpenXR Android build turned
  out to need an x86-64 package, while the available Whisper package path was
  ARM64-oriented.
- Scene-local copies of the assistant competing with the persistent prefab produced
  conflicting voice events and microphone state, which pushed the design toward a single
  prefab.
- Scene-navigation phrases are matched locally rather than sent to the model, so transitions
  stay deterministic and work even when the backend is offline.
- Only the current question reaches the model, keeping the prompt from growing even as the
  chat history visible to the user gets longer.

<!-- MEDIA: screenshots or a capture of the in-headset view — the textbox over the AR
     scene, ideally mid-conversation showing a You:/Luna: exchange. -->
