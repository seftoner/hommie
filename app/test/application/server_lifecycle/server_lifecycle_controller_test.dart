import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart' as ha;
import 'package:hommie/application/server_lifecycle/server_lifecycle_controller.dart';
import 'package:hommie/core/infrastructure/networking/connection/i_server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/home/domain/entities/home_view.dart';
import 'package:hommie/features/home/domain/repositories/i_home_view_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/home_view_repository_provider.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:oauth2/oauth2.dart';

void main() {
  test(
    'signOutServer disconnects, clears credentials, deletes home view, and removes server',
    () async {
      final calls = <String>[];
      final container = _container(calls: calls);
      addTearDown(container.dispose);

      await container.read(serverLifecycleControllerProvider).signOutServer(42);

      expect(calls, [
        'disconnect:42',
        'signOut:42',
        'deleteHome:42',
        'remove:42:true',
      ]);
    },
  );

  test('deleteServer uses the same authenticated cleanup path', () async {
    final calls = <String>[];
    final container = _container(calls: calls);
    addTearDown(container.dispose);

    await container.read(serverLifecycleControllerProvider).deleteServer(7);

    expect(calls, [
      'disconnect:7',
      'signOut:7',
      'deleteHome:7',
      'remove:7:true',
    ]);
  });

  test('signOutActiveServer is a no-op when no active server exists', () async {
    final calls = <String>[];
    final container = _container(calls: calls, activeServer: null);
    addTearDown(container.dispose);

    await container
        .read(serverLifecycleControllerProvider)
        .signOutActiveServer();

    expect(calls, isEmpty);
  });

  test('signOutActiveServer uses active server cleanup path', () async {
    final calls = <String>[];
    final container = _container(
      calls: calls,
      activeServer: const Server(id: 99, name: 'Active'),
    );
    addTearDown(container.dispose);

    await container
        .read(serverLifecycleControllerProvider)
        .signOutActiveServer();

    expect(calls, [
      'disconnect:99',
      'signOut:99',
      'deleteHome:99',
      'remove:99:true',
    ]);
  });

  test(
    'signOutServer throws ServerLifecycleException when credential cleanup fails',
    () async {
      final calls = <String>[];
      final failure = const AuthFailure.storage();
      final container = _container(
        calls: calls,
        authRepository: _FakeAuthRepository(
          calls,
          signOutResult: left(failure),
        ),
      );
      addTearDown(container.dispose);

      await expectLater(
        container.read(serverLifecycleControllerProvider).signOutServer(42),
        throwsA(
          isA<ServerLifecycleException>()
              .having(
                (error) => error.message,
                'message',
                'Failed to clear credentials for server 42.',
              )
              .having((error) => error.cause, 'cause', failure),
        ),
      );

      expect(calls, ['disconnect:42', 'signOut:42']);
    },
  );

  test(
    'signOutServer throws lifecycle exception when home view deletion fails',
    () async {
      final calls = <String>[];
      final failure = Exception('home delete failed');
      final container = _container(calls: calls, homeDeleteFailure: failure);
      addTearDown(container.dispose);

      await expectLater(
        container.read(serverLifecycleControllerProvider).signOutServer(42),
        throwsA(
          isA<ServerLifecycleException>()
              .having(
                (error) => error.message,
                'message',
                'Failed to delete home view for server 42.',
              )
              .having((error) => error.cause, 'cause', failure),
        ),
      );

      expect(calls, ['disconnect:42', 'signOut:42', 'deleteHome:42']);
    },
  );

  test(
    'signOutServer throws lifecycle exception when server removal fails',
    () async {
      final calls = <String>[];
      final failure = Exception('server remove failed');
      final container = _container(calls: calls, serverRemovalFailure: failure);
      addTearDown(container.dispose);

      await expectLater(
        container.read(serverLifecycleControllerProvider).signOutServer(42),
        throwsA(
          isA<ServerLifecycleException>()
              .having(
                (error) => error.message,
                'message',
                'Failed to remove server 42.',
              )
              .having((error) => error.cause, 'cause', failure),
        ),
      );

      expect(calls, [
        'disconnect:42',
        'signOut:42',
        'deleteHome:42',
        'remove:42:true',
      ]);
    },
  );
}

ProviderContainer _container({
  required List<String> calls,
  Server? activeServer = const Server(id: 1, name: 'Home'),
  _FakeAuthRepository? authRepository,
  Exception? homeDeleteFailure,
  Exception? serverRemovalFailure,
}) {
  return ProviderContainer(
    overrides: [
      serverConnectionManagerProvider.overrideWithValue(
        _FakeConnectionManager(calls),
      ),
      authRepositoryProvider.overrideWithValue(
        authRepository ?? _FakeAuthRepository(calls),
      ),
      serverManagerProvider.overrideWithValue(
        _FakeServerManager(
          calls,
          activeServer: activeServer,
          removalFailure: serverRemovalFailure,
        ),
      ),
      homeViewRepositoryForServerProvider.overrideWith(
        (_, serverId) => _FakeHomeViewRepository(
          calls,
          serverId,
          deleteFailure: homeDeleteFailure,
        ),
      ),
    ],
  );
}

class _FakeConnectionManager implements IServerConnectionManager {
  const _FakeConnectionManager(this.calls);

  final List<String> calls;

  @override
  void disconnect(int serverId) {
    calls.add('disconnect:$serverId');
  }

  @override
  Future<ha.IHAConnection> getConnection(int serverId) {
    throw UnimplementedError();
  }

  @override
  void setActiveServer(int? serverId) {}
}

class _FakeAuthRepository implements IAuthRepository {
  const _FakeAuthRepository(
    this.calls, {
    this.signOutResult = const Right(unit),
  });

  final List<String> calls;
  final Either<AuthFailure, Unit> signOutResult;

  @override
  Future<Either<AuthFailure, Credentials>> getCredentials(int serverId) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isLoggedIn(int serverId) {
    throw UnimplementedError();
  }

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
    calls.add('signOut:$serverId');
    return signOutResult;
  }
}

class _FakeServerManager implements IServerManager {
  const _FakeServerManager(
    this.calls, {
    required this.activeServer,
    this.removalFailure,
  });

  final List<String> calls;
  final Server? activeServer;
  final Exception? removalFailure;

  @override
  Future<Server> addServer(Server config) {
    throw UnimplementedError();
  }

  @override
  Future<Server?> activateNextServer({int? excludingId}) {
    throw UnimplementedError();
  }

  @override
  Future<Server?> activateServer(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Server?> getActiveServer() async => activeServer;

  @override
  Future<List<Server>> getServers() {
    throw UnimplementedError();
  }

  @override
  Future<void> removeServer(int id, {bool allowRemovingLast = false}) async {
    calls.add('remove:$id:$allowRemovingLast');
    final failure = removalFailure;
    if (failure != null) {
      throw failure;
    }
  }

  @override
  Stream<Server?> watchActiveServer() {
    throw UnimplementedError();
  }
}

class _FakeHomeViewRepository implements IHomeViewRepository {
  const _FakeHomeViewRepository(
    this.calls,
    this.serverId, {
    this.deleteFailure,
  });

  final List<String> calls;
  final int serverId;
  final Exception? deleteFailure;

  @override
  Future<void> delete() async {
    calls.add('deleteHome:$serverId');
    final failure = deleteFailure;
    if (failure != null) {
      throw failure;
    }
  }

  @override
  Future<HomeViewConf?> get() {
    throw UnimplementedError();
  }

  @override
  Future<HomeViewConf> save(HomeViewConf conf) {
    throw UnimplementedError();
  }
}
