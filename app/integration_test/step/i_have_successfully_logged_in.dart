import 'package:patrol/patrol.dart';

import '../utils/test_context.dart';

Future<void> iHaveSuccessfullyLoggedIn(PatrolIntegrationTester $) async {
  final context = TestContext.instance();
  final token = context.authToken;
  if (token == null) throw StateError('Owned access token is not configured');
  await context.appState.seedSession(
    serverUrl: context.config.appServerUrl,
    accessToken: token,
  );
}
