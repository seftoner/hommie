# 🏠 Hommie - Flutter Client for HomeAssistant

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL%203.0-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)](https://flutter.dev)

Welcome to Hommie! This project is all about crafting a stunning and user-friendly app for Home Assistant (HA) using Dart and Flutter. We chat with your Home Assistant via WebSocket API.

## 💡 Why Hommie?
Why not? We want a gorgeous, easy-to-use client for Home Assistant that works everywhere. Plus, it's a fun way to practice coding and dive into new tech!

## ✨ Cool Features
We're just getting started, but here's what's cooking:
- **Authentication**: Secure login and logout. Tested on local networks.
  - Server Discovery: Finds Home Assistant servers on your local network and lists them for easy pickings.
- **Areas**: Browse through different areas.
- **Companion App**: (In Progress) Register the app on Home Assistant and send location and sensor data.
- **Logs**: View and export app logs.

### 🖥️ Platforms
1. iOS - ✅
2. MacOS - ✅
3. Android - ✅
4. Windows - ⚠️ (Not tested)
5. Linux - ⚠️ (Not tested)

## 🛠️ Development Requirements
- Flutter SDK 3.24 or higher
- Dart SDK 3.6 or higher
- Android Studio / VS Code with Flutter extensions
- A running Home Assistant instance for testing

## 🚀 Build & Run
1. Grab dependencies: `flutter pub get`
2. Fire up build_runner: `dart run build_runner watch`

> [!TIP]
> VS Code users, hit:
> - macOS: `Cmd + Shift + P`, then type "Tasks: Run Build Task"
> - Windows/Linux: `Ctrl + Shift + P`, then type "Tasks: Run Build Task"
>   
> Choose `flutter: build_runner watch` from the list.

## 🛠️ Dev Workflow

Before you dive in, check out our [Development Workflow Guide](docs/development_workflow.md). It covers:
- Branching strategy
- Commit message format
- Pull request process
- Testing requirements

## 🧪 Testing Setup & Execution

For all the deets on setting up and running tests, see our [Testing Guide](docs/testing.md).

## 🤝 Join the Fun
We love contributions! Fork the repo, make your changes, and send a pull request. Or open an issue to report bugs or suggest features.

## 📄 License
This project rocks the [GPL-3.0 License](LICENSE).
