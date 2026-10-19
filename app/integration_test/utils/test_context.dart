import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/auth/infrastructure/providers/ha_servers_repository_provider.dart';
import 'package:hommie/features/auth/infrastructure/repositories/cached_ha_servers_repository.dart';

import 'app_state.dart';
import 'discovery_fixture.dart';
import 'e2e_config.dart';
import 'fault_proxy_client.dart';
import 'hass_token_manager.dart';
import 'remote_hass_cli.dart';
import 'scenario_cleanup.dart';

class TestContext {
  factory TestContext.instance() => _singleton;
  TestContext._();
  static final TestContext _singleton = TestContext._();

  String? _authToken;
  DiscoveryFixture? _discoveryFixture;
  late E2eTestConfig config;
  late ScenarioCleanup cleanup;
  late E2eAppState appState;
  late RemoteHassCli cli;
  late FaultProxyClient proxy;
  HassTokenRef? token;
  String namespace = '';
  bool preserveSeed = false;
  String get initialAreaName => '$namespace Initial';
  String get renamedAreaName => '$namespace Renamed';
  DiscoveryFixture get discoveryFixture =>
      _discoveryFixture ?? (throw StateError('No active discovery fixture'));

  void begin(String scenarioId, {E2eTestConfig? config}) {
    clear();
    this.config = config ?? E2eTestConfig.fromEnvironment();
    namespace = 'Hommie E2E ${this.config.runId} $scenarioId';
    cleanup = ScenarioCleanup();
    final fixture = DiscoveryFixture();
    _discoveryFixture = fixture;
    appState = E2eAppState(
      container: ProviderContainer(
        retry: (_, _) => null,
        overrides: [
          haServersRepositoryProvider.overrideWith(
            (_) => CachedHAServersRepository(baseRepository: fixture),
          ),
        ],
      ),
    );
  }

  void setAuthToken(String token) {
    _authToken = token;
  }

  String? get authToken => _authToken;

  void clear() {
    _authToken = null;
    _discoveryFixture = null;
    token = null;
    preserveSeed = false;
  }
}
