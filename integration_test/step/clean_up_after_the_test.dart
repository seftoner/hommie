import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import '../utils/test_provider_overrides.dart';

/// Usage: clean up after the test
Future<void> cleanUpAfterTheTest(PatrolIntegrationTester $) async {
  TestProviderOverrides.instance().clear();
}
