import 'app_state.dart';
import 'e2e_config.dart';
import 'hass_token_manager.dart';
import 'scenario_cleanup.dart';

class TestContext {
  factory TestContext.instance() => _singleton;
  TestContext._();
  static final TestContext _singleton = TestContext._();

  String? _authToken;
  late E2eTestConfig config;
  late ScenarioCleanup cleanup;
  late E2eAppState appState;
  HassTokenRef? token;
  String namespace = '';
  bool preserveSeed = false;
  final ownedAreaIds = <String>{};
  String get initialAreaName => '$namespace Initial';
  String get renamedAreaName => '$namespace Renamed';
  void begin(String scenarioId) {
    clear();
    config = E2eTestConfig.fromEnvironment();
    namespace = 'Hommie E2E ${config.runId} $scenarioId';
    cleanup = ScenarioCleanup();
    appState = E2eAppState();
  }

  void setAuthToken(String token) {
    _authToken = token;
  }

  String? get authToken => _authToken;

  void clear() {
    _authToken = null;
    token = null;
    preserveSeed = false;
    ownedAreaIds.clear();
  }
}
