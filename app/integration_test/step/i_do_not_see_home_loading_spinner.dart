import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/ui/keys.dart';
import 'package:patrol/patrol.dart';

Future<void> iDoNotSeeHomeLoadingSpinner(PatrolIntegrationTester $) async {
  final timeout = DateTime.now().add(const Duration(seconds: 20));

  while (DateTime.now().isBefore(timeout)) {
    await $.pump(const Duration(milliseconds: 250));
    if (!$.tester.any(find.byKey(K.home.loadingSpinner))) {
      return;
    }
  }

  expect(find.byKey(K.home.loadingSpinner), findsNothing);
}
