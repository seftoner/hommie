import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/auth/domain/repository/i_credential_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/credential_repository_provider.dart';
import 'package:oauth2/src/credentials.dart';
import 'package:patrol/patrol.dart';
import '../utils/test_context.dart';
import '../utils/test_provider_overrides.dart';

Future<void> iHaveSuccessfullyLoggedIn(PatrolIntegrationTester $) async {
  final token = TestContext.instance().authToken;
  if (token == null) {
    throw Exception('Auth token not found in TestContext');
  }

  TestProviderOverrides.instance().setOverrides([
    credentialsRepositoryProvider
        .overrideWith((ref) => _CredentialsRepositoryMock(token)),
  ]);
}

class _CredentialsRepositoryMock implements ICredentialRepository {
  _CredentialsRepositoryMock(this.token);

  final String token;
  bool _isSigned = true;

  @override
  Future<void> clear() {
    _isSigned = false;
    return Future.value();
  }

  @override
  Future<Credentials?> read() {
    if (_isSigned != true) {
      return Future.value(null);
    }

    return Future.value(Credentials(
      token,
      refreshToken: token,
      expiration: DateTime.now().add(const Duration(days: 365)),
      tokenEndpoint: Uri.parse('http://10.0.2.2:8123/auth/token'),
    ));
  }

  @override
  Future<void> save(Credentials credentials) {
    return Future.value();
  }
}
