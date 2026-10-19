import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/features/auth/application/servers_discovery_controller.dart';
import 'package:hommie/features/auth/infrastructure/providers/ha_servers_repository_provider.dart';
import 'package:hommie/features/auth/infrastructure/repositories/cached_ha_servers_repository.dart';
import 'package:hommie/features/common/domain/entities/ha_server.dart';
import 'package:hommie/features/common/domain/entities/ha_version.dart';

import '../../integration_test/utils/discovery_fixture.dart';
import '../../integration_test/utils/e2e_config.dart';
import '../../integration_test/utils/test_context.dart';
import '../utils/tests_logger.dart';

void main() {
  setUpAll(() => logger = testLogger);

  final server = HaServer(
    uuid: 'e2e-discovery',
    name: 'Hommie E2E',
    uri: Uri.parse('http://127.0.0.1:18124'),
    version: HaVersion.fromString('2024.12.5'),
  );

  test('returns immutable copied results and preserves snapshots', () async {
    final fixture = DiscoveryFixture();
    expect(await fixture.getAvailableServers(), isEmpty);
    final input = [server];
    fixture.setServers(input);
    input.clear();
    final snapshot = await fixture.getAvailableServers();
    expect(snapshot, [server]);
    expect(() => snapshot.clear(), throwsUnsupportedError);
    fixture.clear();
    expect(await fixture.getAvailableServers(), isEmpty);
    expect(snapshot, [server]);
  });

  test('new scenario does not inherit fixture or cached results', () async {
    final context = TestContext.instance();
    final config = E2eTestConfig.fromValues({
      'HASS_TOKEN': 'test-management-token',
      'E2E_RUN_ID': 'discovery_unit',
    });
    context.begin('first', config: config);
    final firstContainer = context.appState.container;
    addTearDown(firstContainer.dispose);
    final firstFixture = context.discoveryFixture;
    firstFixture.setServers([server]);
    final firstRepository = firstContainer.listen(
      haServersRepositoryProvider,
      (_, _) {},
    );
    expect(await firstRepository.read().getAvailableServers(), [server]);

    context.begin('second', config: config);
    final secondContainer = context.appState.container;
    addTearDown(secondContainer.dispose);
    addTearDown(context.clear);
    expect(context.discoveryFixture, isNot(same(firstFixture)));
    expect(secondContainer, isNot(same(firstContainer)));
    expect(
      await secondContainer
          .read(haServersRepositoryProvider)
          .getAvailableServers(),
      isEmpty,
    );
    expect(await firstRepository.read().getAvailableServers(), [server]);
    context.clear();
    expect(() => context.discoveryFixture, throwsStateError);
  });

  test(
    'real force refresh reads a changed fixture through the cache',
    () async {
      final fixture = DiscoveryFixture()..setServers([server]);
      final container = ProviderContainer(
        overrides: [
          haServersRepositoryProvider.overrideWith(
            (_) => CachedHAServersRepository(baseRepository: fixture),
          ),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        serversDiscoveryControllerProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);
      expect(await container.read(serversDiscoveryControllerProvider.future), [
        server,
      ]);
      fixture.clear();
      expect(
        await container.read(haServersRepositoryProvider).getAvailableServers(),
        [server],
      );
      await container
          .read(serversDiscoveryControllerProvider.notifier)
          .forceRefresh();
      expect(subscription.read().requireValue, isEmpty);
    },
  );
}
