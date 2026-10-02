import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/core/database/database.dart';
import 'package:hommie/core/infrastructure/database/database_provider.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/features/auth/infrastructure/providers/credential_repository_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';

import '../../integration_test/utils/app_state.dart';
import '../utils/tests_logger.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'real repositories persist session; reset removes only app-owned keys',
    () async {
      logger = testLogger;
      FlutterSecureStorage.setMockInitialValues({
        'unrelated': 'keep',
        'oauthCredentialsForServer:99': 'stale',
      });
      final db = AppDatabase(NativeDatabase.memory());
      final container = ProviderContainer(
        overrides: [databaseConnectionProvider.overrideWithValue(db)],
      );
      final state = E2eAppState(container: container);
      addTearDown(() async {
        container.dispose();
        await db.close();
      });
      await state.reset();
      await state.seedSession(
        serverUrl: Uri.parse('http://127.0.0.1:18124'),
        accessToken: 'app-token',
      );
      final server = await container
          .read(serverManagerProvider)
          .getActiveServer();
      expect(
        server?.baseUrl?.value.getOrElse((_) => ''),
        'http://127.0.0.1:18124',
      );
      expect(
        (await container.read(credentialRepositoryProvider).read(server!.id!))
            ?.accessToken,
        'app-token',
      );
      expect(
        (await const FlutterSecureStorage().readAll()).keys,
        contains('oauthCredentialsForServer:${server.id}'),
      );
      await state.reset();
      await state.reset();
      expect(await container.read(serverManagerProvider).getServers(), isEmpty);
      expect(await const FlutterSecureStorage().readAll(), {
        'unrelated': 'keep',
      });
    },
  );
}
