import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/features/auth/domain/repository/i_credential_repository.dart';
import 'package:hommie/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:oauth2/oauth2.dart';

import '../../../../utils/tests_logger.dart';

void main() {
  logger = testLogger;

  test(
    'signOut revokes the refresh token with the injected revocation client',
    () async {
      final credentials = _credentials();
      final credentialRepository = _FakeCredentialRepository(credentials);
      final requests = <http.Request>[];
      final repository = AuthRepository(
        credentialRepository,
        MockClient((_) async => throw AssertionError('refresh client used')),
        revocationHttpClient: MockClient((request) async {
          requests.add(request);
          return http.Response('', 200);
        }),
      );

      final result = await repository.signOut(7);
      await Future<void>.delayed(Duration.zero);

      expect(result.isRight(), isTrue);
      expect(requests, hasLength(1));
      expect(requests.single.method, 'POST');
      expect(requests.single.url, Uri.parse('http://127.0.0.1:9/auth/token'));
      expect(requests.single.bodyFields, {
        'token': 'refresh-token',
        'action': 'revoke',
      });
      expect(credentialRepository.clearedServerIds, [7]);
    },
  );

  test(
    'signOut clears credentials without waiting for token revocation',
    () async {
      final credentialRepository = _FakeCredentialRepository(_credentials());
      final revocationCompleter = Completer<http.Response>();
      final repository = AuthRepository(
        credentialRepository,
        MockClient((_) async => throw AssertionError('refresh client used')),
        revocationHttpClient: MockClient((_) => revocationCompleter.future),
      );

      final result = await repository.signOut(7);

      expect(result.isRight(), isTrue);
      expect(credentialRepository.clearedServerIds, [7]);
      expect(revocationCompleter.isCompleted, isFalse);

      revocationCompleter.complete(http.Response('', 200));
    },
  );

  test('signOut still clears credentials when token revocation fails', () async {
    final credentialRepository = _FakeCredentialRepository(_credentials());
    final repository = AuthRepository(
      credentialRepository,
      MockClient((_) async => throw AssertionError('refresh client used')),
      revocationHttpClient: MockClient(
        (_) => Future<http.Response>.error(TimeoutException('slow revoke')),
      ),
    );

    final result = await repository.signOut(7);
    await Future<void>.delayed(Duration.zero);

    expect(result.isRight(), isTrue);
    expect(credentialRepository.clearedServerIds, [7]);
  });
}

Credentials _credentials() {
  return Credentials(
    'access-token',
    refreshToken: 'refresh-token',
    tokenEndpoint: Uri.parse('http://127.0.0.1:9/auth/token'),
  );
}

final class _FakeCredentialRepository implements ICredentialRepository {
  _FakeCredentialRepository(this._credentials);

  final Credentials? _credentials;
  final clearedServerIds = <int>[];

  @override
  Future<void> clear(int serverId) async {
    clearedServerIds.add(serverId);
  }

  @override
  Future<bool> hasCredentials(int serverId) async => _credentials != null;

  @override
  Future<Credentials?> read(int serverId) async => _credentials;

  @override
  Future<void> save(int serverId, Credentials credentials) async {}
}
