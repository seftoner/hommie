import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/core/infrastructure/networking/connection/ha_connection_factory.dart';
import 'package:hommie/core/infrastructure/networking/providers/server_config_provider.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

import '../../../../utils/tests_logger.dart';

class _FakeToken implements HAAuthToken {
  @override
  String get accessToken => 'token';

  @override
  bool get isExpired => false;

  @override
  Uri? get serverUri => Uri.parse('http://localhost:8123/auth/token');
}

HAConnectionOption _connectionOption() {
  return HAConnectionOption.withLogger(
    serverUrl: Uri.parse('http://localhost:8123'),
    fetchAuthToken: () async => _FakeToken(),
    enableDefaultLogging: false,
  );
}

class _FakeConnection extends HAConnection {
  _FakeConnection() : super(_connectionOption());

  bool closed = false;

  @override
  Future<void> close() async {
    closed = true;
  }

  @override
  HAResponse sendMessage(
    HAMessage message, {
    Duration timeout = const Duration(seconds: 15),
  }) => Future.value(null);

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    return HASubscription(logger: const NoOpLogger(), unsubscribe: () async {});
  }
}

class _LaggingAuthenticatedOrchestrator extends ConnectionOrchestrator {
  _LaggingAuthenticatedOrchestrator() : super(_connectionOption());

  final _states = StreamController<HASocketState>.broadcast(sync: true);
  final fakeConnection = _FakeConnection();
  bool closed = false;

  @override
  Stream<HASocketState> get state => _states.stream;

  @override
  HAConnection? get connection => fakeConnection;

  @override
  Future<void> connect() async {
    _states.add(const Connecting());
  }

  @override
  Future<void> close() async {
    closed = true;
    await _states.close();
  }
}

void main() {
  logger = testLogger;

  test(
    'accepts established connection when authenticated state delivery lags',
    () async {
      final orchestrator = _LaggingAuthenticatedOrchestrator();
      final factoryProvider = Provider(
        (ref) =>
            HAConnectionFactory(ref, createOrchestrator: (_) => orchestrator),
        dependencies: [serverConfigProvider],
      );
      final container = ProviderContainer(
        overrides: [
          serverConfigProvider.overrideWith(
            (_, serverId) => Server(
              id: serverId,
              name: 'Home',
              baseUrl: ServerUrl('http://localhost:8123'),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final opening = container.read(factoryProvider).open(1);
      final managed = await opening.future;

      expect(managed.connection, same(orchestrator.fakeConnection));
      expect(managed.currentState, isA<Authenticated>());
      expect(orchestrator.closed, isFalse);
    },
  );
}
