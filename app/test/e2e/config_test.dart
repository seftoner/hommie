import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../scripts/e2e/config.dart';
import '../../integration_test/utils/e2e_config.dart';

void main() {
  test('default run addresses the iOS proxy and independent controls', () {
    final config = E2eConfig.parse([], {}, Directory('/tmp/a repo'));
    expect(config.platform, 'ios');
    expect(config.appServerUrl.toString(), 'http://127.0.0.1:18124');
    expect(config.fixtureControlUrl.port, 3000);
    expect(config.faultControlUrl.port, 18474);
    expect(config.repeat, 1);
  });
  test('rejects invalid input before starting services', () {
    for (final args in [
      ['--repeat', '0'],
      ['--timeout-seconds', '-1'],
      ['--unknown'],
      ['--develop'],
      ['--target', '../escape'],
    ]) {
      expect(
        () => E2eConfig.parse(args, {}, Directory('/tmp')),
        throwsFormatException,
      );
    }
  });
  test('explicit port overrides also change device endpoints', () {
    final config = E2eConfig.parse([], {
      'E2E_PROXY_PORT': '19200',
    }, Directory('/tmp'));
    expect(config.appServerUrl.port, 19200);
  });
  test('mobile config fails explicitly for missing management credentials', () {
    expect(() => E2eTestConfig.fromValues({}), throwsFormatException);
  });
  test('mobile endpoints can address an optional Android emulator', () {
    final config = E2eTestConfig.fromValues({
      'HASS_TOKEN': 'private',
      'E2E_RUN_ID': 'run-1',
      'E2E_APP_SERVER_URL': 'http://10.0.2.2:18124',
      'E2E_FIXTURE_CONTROL_URL': 'http://10.0.2.2:3000',
      'E2E_FAULT_CONTROL_URL': 'http://10.0.2.2:18474',
    });
    expect(config.appServerUrl.host, '10.0.2.2');
  });
}
