import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/auth/application/auth_state.dart';
import 'package:hommie/features/auth/application/auth_state_machine.dart';
import 'package:hommie/features/auth/application/server_token_store.dart';
import 'package:hommie/features/auth/application/token_store_provider.dart';
import 'package:hommie/features/auth/domain/entities/auth_failure.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/domain/repository/i_credential_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:oauth2/oauth2.dart';
import 'package:riverpod/riverpod.dart';

class _FakeAuthRepository implements IAuthRepository {
  _FakeAuthRepository(this._credentialsResult);

  Either<AuthFailure, Credentials> _credentialsResult;

  @override
  Future<Either<AuthFailure, Credentials>> getCredentials(int serverId) async {
    return _credentialsResult;
  }

  void setResult(Either<AuthFailure, Credentials> result) {
    _credentialsResult = result;
  }

  @override
  Future<bool> isLoggedIn(int serverId) async => _credentialsResult.isRight();

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
  Future<Either<AuthFailure, Unit>> signOut(int serverId) {
    throw UnimplementedError();
  }
}

class _DummyCredentialRepository implements ICredentialRepository {
  @override
  Future<void> clear(int serverId) async {}

  @override
  Future<bool> hasCredentials(int serverId) async => false;

  @override
  Future<Credentials?> read(int serverId) async => null;

  @override
  Future<void> save(int serverId, Credentials credentials) async {}
}

class _TestServerTokenStore extends ServerTokenStore {
  _TestServerTokenStore(int serverId)
    : super(_DummyCredentialRepository(), serverId);

  bool cleared = false;

  @override
  Future<void> clear() async {
    cleared = true;
  }
}

void main() {
  const serverId = 1;
  final credentials = Credentials('token', refreshToken: 'refresh');

  group('AuthStateMachine', () {
    test('build returns authenticated when credentials exist', () async {
      final repository = _FakeAuthRepository(right(credentials));
      final store = _TestServerTokenStore(serverId);
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
          tokenStoreProvider(serverId).overrideWithValue(store),
        ],
      );
      addTearDown(container.dispose);

      final state = await container.read(
        authStateMachineProvider(serverId).future,
      );

      expect(state, isA<Authenticated>());
      final notifier = container.read(
        authStateMachineProvider(serverId).notifier,
      );
      expect(notifier.state.asData?.value, isA<Authenticated>());
    });

    test('build returns unauthenticated on missing credentials', () async {
      final repository = _FakeAuthRepository(
        left(const AuthFailure.missingCredentials()),
      );
      final store = _TestServerTokenStore(serverId);
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
          tokenStoreProvider(serverId).overrideWithValue(store),
        ],
      );
      addTearDown(container.dispose);

      final state = await container.read(
        authStateMachineProvider(serverId).future,
      );

      expect(state, isA<Unauthenticated>());
    });

    test('markRevoked sets revoked state', () async {
      final repository = _FakeAuthRepository(right(credentials));
      final store = _TestServerTokenStore(serverId);
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
          tokenStoreProvider(serverId).overrideWithValue(store),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(
        authStateMachineProvider(serverId).notifier,
      );
      await notifier.hydrate();
      notifier.markRevoked(const AuthFailure.invalidToken());

      expect(notifier.state.asData?.value, isA<Revoked>());
    });

    test('clearSession clears token store and sets unauthenticated', () async {
      final repository = _FakeAuthRepository(right(credentials));
      final store = _TestServerTokenStore(serverId);
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
          tokenStoreProvider(serverId).overrideWithValue(store),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(
        authStateMachineProvider(serverId).notifier,
      );
      notifier.setAuthenticatedWithCredentials(credentials);

      await notifier.clearSession();

      expect(store.cleared, isTrue);
      expect(notifier.state.asData?.value, isA<Unauthenticated>());
    });
  });
}
