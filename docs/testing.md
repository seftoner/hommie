# Testing Guide

This guide explains how to set up and run integration tests for the Hommie project.

> [!NOTE]
> TODO: Currently, tests must be run locally on your development machine. Future updates will integrate these tests into the CI pipeline, allowing automated testing in GitHub Actions.

## Prerequisites

- Docker installed on your system
- Flutter development environment
- Available ports:
  - 8123 (Home Assistant)
  - 3000 (hass-cli-web service)

## Testing Setup

### 1. Initialize Test Environment

Make scripts executable and run setup:
```bash
chmod +x scripts/setup_test_env.sh scripts/cleanup_test_env.sh

./scripts/setup_test_env.sh
```

This script will automatically:
- Start the Docker containers
- Initialize Home Assistant
- Configure test credentials
- Set up authentication tokens
- Create necessary environment files

To clean up the test environment:
```bash
./scripts/cleanup_test_env.sh
```

### Default Test Instance Details

- **Home Assistant URL**: http://localhost:8123
- **Default credentials**:
  - Username: `admin`
  - Password: `yourpassword`

## Running Tests

### 1. Setup Patrol CLI
```bash
# Install Patrol CLI
dart pub global activate patrol_cli

# Install platform-specific dependencies
patrol doctor
```

### 2. Running Tests

#### Using VS Code
1. Open Command Palette (`Cmd/Ctrl + Shift + P`)
2. Type "Tasks: Run Test Task"
3. Select `patrol: run tests`

#### Using Command Line
Regular test run:
```bash
patrol test
```

Development mode:
```bash
patrol develop -d "<your device name>" -t --watch integration_test/your_test.dart
```

## Troubleshooting

### Common Issues
1. **Port conflicts**: Ensure ports 8123 and 3000 are available
2. **Docker not running**: Ensure Docker daemon is running
3. **Setup script failure**: Check Docker logs using `docker compose logs`
