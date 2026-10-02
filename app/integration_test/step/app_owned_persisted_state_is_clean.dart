import 'package:patrol/patrol.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';

import '../utils/test_context.dart';

Future<void> appOwnedPersistedStateIsClean(PatrolIntegrationTester $) async {
  final state = TestContext.instance().appState;
  expect(
    await state.container.read(serverManagerProvider).getServers(),
    isEmpty,
  );
  expect(
    (await state.storage.readAll()).keys.where(
      (key) =>
          key == 'server_url' || key.startsWith('oauthCredentialsForServer:'),
    ),
    isEmpty,
  );
}
