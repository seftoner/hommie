import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/application/server_lifecycle/server_lifecycle_controller.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/application/session/auth_revocation_handler.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';

import '../../utils/tests_logger.dart';

class _FakeServerLifecycleController implements IServerLifecycleController {
  _FakeServerLifecycleController({List<Exception?>? signOutResults})
    : _signOutResults = [...?signOutResults];

  final signOutCalls = <int>[];
  final List<Exception?> _signOutResults;

  @override
  Future<void> deleteServer(int serverId) async {}

  @override
  Future<void> signOutActiveServer() async {}

  @override
  Future<void> signOutServer(int serverId) async {
    signOutCalls.add(serverId);
    if (_signOutResults.isEmpty) {
      return;
    }

    final result = _signOutResults.removeAt(0);
    if (result != null) {
      throw result;
    }
  }
}

class _SessionSource {
  _SessionSource(this.state);

  ActiveServerSessionState state;
}

class _FakeActiveServerSession extends ActiveServerSession {
  _FakeActiveServerSession(this.source);

  final _SessionSource source;

  @override
  ActiveServerSessionState build() => source.state;

  void emit(ActiveServerSessionState state) {
    this.state = state;
  }
}

class _FakeConnection implements IHAConnection {
  @override
  Future<void> close() async {}

  @override
  HAResponse sendMessage(HAMessage message) => Future.value(null);

  @override
  HASubscription subscribeMessage(HAMessage subscribeMessage) {
    return HASubscription(logger: const NoOpLogger(), unsubscribe: () async {});
  }
}

void main() {
  logger = testLogger;

  const server = Server(id: 1, name: 'Home');

  test('signs out revoked server once', () async {
    final lifecycle = _FakeServerLifecycleController();
    final container = ProviderContainer(
      overrides: [
        serverLifecycleControllerProvider.overrideWithValue(lifecycle),
        activeServerSessionProvider.overrideWithValue(
          const AuthRevokedServerSession(server),
        ),
      ],
    );
    addTearDown(container.dispose);

    container.read(authRevocationHandlerProvider);
    await container.pump();
    container.read(authRevocationHandlerProvider);
    await container.pump();

    expect(lifecycle.signOutCalls, [1]);
  });

  test('does not sign out online session', () async {
    final lifecycle = _FakeServerLifecycleController();
    final container = ProviderContainer(
      overrides: [
        serverLifecycleControllerProvider.overrideWithValue(lifecycle),
        activeServerSessionProvider.overrideWithValue(
          OnlineServerSession(
            activeServer: server,
            connection: _FakeConnection(),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    container.read(authRevocationHandlerProvider);
    await container.pump();

    expect(lifecycle.signOutCalls, isEmpty);
  });

  test(
    'catches lifecycle failure and retries on later revoked emission',
    () async {
      final lifecycle = _FakeServerLifecycleController(
        signOutResults: [Exception('sign out failed'), null],
      );
      final source = _SessionSource(const AuthRevokedServerSession(server));
      final container = ProviderContainer(
        overrides: [
          serverLifecycleControllerProvider.overrideWithValue(lifecycle),
          activeServerSessionProvider.overrideWith(
            () => _FakeActiveServerSession(source),
          ),
        ],
      );
      addTearDown(container.dispose);

      container.read(authRevocationHandlerProvider);
      await container.pump();

      final notifier =
          container.read(activeServerSessionProvider.notifier)
              as _FakeActiveServerSession;
      notifier.emit(const ResolvingServerSession());
      await container.pump();
      notifier.emit(const AuthRevokedServerSession(server));
      await container.pump();

      expect(lifecycle.signOutCalls, [1, 1]);
    },
  );

  test(
    'online session clears handled id so later revocation signs out again',
    () async {
      final lifecycle = _FakeServerLifecycleController();
      final source = _SessionSource(const AuthRevokedServerSession(server));
      final container = ProviderContainer(
        overrides: [
          serverLifecycleControllerProvider.overrideWithValue(lifecycle),
          activeServerSessionProvider.overrideWith(
            () => _FakeActiveServerSession(source),
          ),
        ],
      );
      addTearDown(container.dispose);

      container.read(authRevocationHandlerProvider);
      await container.pump();

      final notifier =
          container.read(activeServerSessionProvider.notifier)
              as _FakeActiveServerSession;
      notifier.emit(
        OnlineServerSession(
          activeServer: server,
          connection: _FakeConnection(),
        ),
      );
      await container.pump();
      notifier.emit(const AuthRevokedServerSession(server));
      await container.pump();

      expect(lifecycle.signOutCalls, [1, 1]);
    },
  );
}
