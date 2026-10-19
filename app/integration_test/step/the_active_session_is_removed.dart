import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:patrol/patrol.dart';

import '../utils/test_context.dart';

Future<void> theActiveSessionIsRemoved(PatrolIntegrationTester $) async {
  final container = TestContext.instance().appState.container;
  expect(await container.read(serverManagerProvider).getActiveServer(), isNull);
  expect(
    container.read(activeServerSessionProvider),
    isA<NoActiveServerSession>(),
  );
  final keys = await const FlutterSecureStorage().readAll();
  expect(
    keys.keys.where((key) => key.startsWith('oauthCredentialsForServer:')),
    isEmpty,
  );
}
