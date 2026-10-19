class E2eTestConfig {
  final Uri appServerUrl, fixtureControlUrl, faultControlUrl;
  final String managementToken, username, password, runId, coldPhase;
  E2eTestConfig._(
    this.appServerUrl,
    this.fixtureControlUrl,
    this.faultControlUrl,
    this.managementToken,
    this.username,
    this.password,
    this.runId,
    this.coldPhase,
  );
  factory E2eTestConfig.fromEnvironment() => E2eTestConfig.fromValues({
    'E2E_APP_SERVER_URL': const String.fromEnvironment('E2E_APP_SERVER_URL'),
    'E2E_FIXTURE_CONTROL_URL': const String.fromEnvironment(
      'E2E_FIXTURE_CONTROL_URL',
    ),
    'E2E_FAULT_CONTROL_URL': const String.fromEnvironment(
      'E2E_FAULT_CONTROL_URL',
    ),
    'HASS_TOKEN': const String.fromEnvironment('HASS_TOKEN'),
    'HASS_USERNAME': const String.fromEnvironment(
      'HASS_USERNAME',
      defaultValue: 'admin',
    ),
    'HASS_PASSWORD': const String.fromEnvironment(
      'HASS_PASSWORD',
      defaultValue: 'yourpassword',
    ),
    'E2E_RUN_ID': const String.fromEnvironment('E2E_RUN_ID'),
    'E2E_COLD_PHASE': const String.fromEnvironment(
      'E2E_COLD_PHASE',
      defaultValue: 'none',
    ),
  });
  factory E2eTestConfig.fromValues(Map<String, String> values) {
    Uri url(String key, int port) {
      final v = values[key];
      final uri = Uri.tryParse(
        v == null || v.isEmpty ? 'http://127.0.0.1:$port' : v,
      );
      if (uri == null ||
          uri.scheme != 'http' ||
          uri.host.isEmpty ||
          uri.userInfo.isNotEmpty ||
          uri.hasQuery ||
          uri.hasFragment) {
        throw FormatException('Invalid endpoint: $key');
      }
      return uri;
    }

    final token = values['HASS_TOKEN'] ?? '',
        runId = values['E2E_RUN_ID'] ?? '';
    if (token.isEmpty) {
      throw const FormatException(
        'HASS_TOKEN management credential is required',
      );
    }
    if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(runId)) {
      throw const FormatException('Valid E2E_RUN_ID is required');
    }
    final phase = values['E2E_COLD_PHASE'] ?? 'none';
    if (!['none', 'seed', 'verify'].contains(phase)) {
      throw const FormatException('Invalid E2E_COLD_PHASE');
    }
    return E2eTestConfig._(
      url('E2E_APP_SERVER_URL', 18124),
      url('E2E_FIXTURE_CONTROL_URL', 3000),
      url('E2E_FAULT_CONTROL_URL', 18474),
      token,
      values['HASS_USERNAME'] ?? 'admin',
      values['HASS_PASSWORD'] ?? 'yourpassword',
      runId,
      phase,
    );
  }
}
