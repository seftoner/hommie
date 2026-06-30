import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/core/infrastructure/networking/connection/ha_connection_factory.dart';
import 'package:hommie/core/infrastructure/networking/providers/server_config_provider.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:oauth2/oauth2.dart';

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

class _AuthFailedOrchestrator extends ConnectionOrchestrator {
  _AuthFailedOrchestrator() : super(_connectionOption());

  final _states = StreamController<HASocketState>.broadcast(sync: true);
  final fakeConnection = _FakeConnection();
  bool closed = false;

  @override
  Stream<HASocketState> get state => _states.stream;

  @override
  HAConnection? get connection => fakeConnection;

  @override
  Future<void> connect() async {
    _states.add(
      const Disconnected(type: DisconnectionType.authFailure, reason: 'bad'),
    );
  }

  @override
  Future<void> close() async {
    closed = true;
    await _states.close();
  }
}

class _FakeAuthRepository implements IAuthRepository {
  const _FakeAuthRepository(this.credentialsResult);

  final Either<AuthFailure, Credentials> credentialsResult;

  @override
  Future<Either<AuthFailure, Credentials>> getCredentials(int serverId) async {
    return credentialsResult;
  }

  @override
  Future<bool> isLoggedIn(int serverId) async => credentialsResult.isRight();

  @override
  Future<Either<AuthFailure, Credentials>> login({
    required int serverId,
    required String serverUrl,
    required Uri redirectUrl,
    required AuthResponseHandler handler,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut(int serverId) async {
    return right(unit);
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
      final factory = container.listen(factoryProvider, (_, _) {});
      addTearDown(factory.close);

      final opening = factory.read().open(1);
      final managed = await opening.future;

      expect(managed.connection, same(orchestrator.fakeConnection));
      expect(managed.currentState, isA<Authenticated>());
      expect(orchestrator.closed, isFalse);
    },
  );

  test(
    'rejects connection when orchestrator reports authentication failure',
    () async {
      final orchestrator = _AuthFailedOrchestrator();
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
      final factory = container.listen(factoryProvider, (_, _) {});
      addTearDown(factory.close);

      final opening = factory.read().open(1);

      await expectLater(opening.future, throwsA(isA<AuthenticationError>()));
      expect(orchestrator.closed, isTrue);
    },
  );

  test(
    'token resolution connection failure rejects opening as connection error',
    () async {
      final factoryProvider = Provider(
        HAConnectionFactory.new,
        dependencies: [serverConfigProvider, authRepositoryProvider],
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
          authRepositoryProvider.overrideWithValue(
            _FakeAuthRepository(left(const AuthFailure.connection())),
          ),
        ],
      );
      addTearDown(container.dispose);
      final factory = container.listen(factoryProvider, (_, _) {});
      addTearDown(factory.close);

      final opening = factory.read().open(1);

      await expectLater(opening.future, throwsA(isA<ConnectionError>()));
    },
  );

  test(
    'missing local credentials reject opening as connection error',
    () async {
      final factoryProvider = Provider(
        HAConnectionFactory.new,
        dependencies: [serverConfigProvider, authRepositoryProvider],
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
          authRepositoryProvider.overrideWithValue(
            _FakeAuthRepository(left(const AuthFailure.missingCredentials())),
          ),
        ],
      );
      addTearDown(container.dispose);
      final factory = container.listen(factoryProvider, (_, _) {});
      addTearDown(factory.close);

      final opening = factory.read().open(1);

      await expectLater(opening.future, throwsA(isA<ConnectionError>()));
    },
  );
}
