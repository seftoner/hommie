import 'package:flutter_test/flutter_test.dart';

import '../../integration_test/utils/e2e_config.dart';

void main() {
  test('mobile config fails explicitly for missing management credentials', () {
    expect(() => E2eTestConfig.fromValues({}), throwsFormatException);
  });
}
