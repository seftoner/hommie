import 'package:hommie/ui/keys.dart';
import 'package:patrol/patrol.dart';

Future<void> iCompleteOnboarding(PatrolIntegrationTester $) async {
  // Check if we're on the welcome page
  final welcomePage = await $(K.onboarding.welcomePage).waitUntilVisible();

  if (welcomePage.exists) {
    // Tap continue on welcome page
    await $(K.onboarding.welcomeContinueButton).tap();

    // Wait for permissions page
    await $(K.onboarding.permissionPage).waitUntilVisible();

    // Tap connect on permissions page
    await $(K.onboarding.permissionsConnectButton).tap();
  }
}
