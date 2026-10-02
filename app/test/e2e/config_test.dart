import 'package:flutter_test/flutter_test.dart';

import '../../integration_test/utils/e2e_config.dart';

void main() {
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
