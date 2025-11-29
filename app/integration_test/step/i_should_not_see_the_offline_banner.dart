import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/ui/keys.dart';
import 'package:patrol/patrol.dart';

/// Usage: I should not see the offline banner
Future<void> iShouldNotSeeTheOfflineBanner(PatrolIntegrationTester $) async {
  expect($(K.common.offlineBanner), findsNothing);
}
