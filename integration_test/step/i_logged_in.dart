import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/auth/domain/repository/i_credential_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/credential_repository_provider.dart';
import 'package:oauth2/src/credentials.dart';
import 'package:patrol/patrol.dart';
import '../utils/test_provider_overrides.dart';

Future<void> iLoggedIn(PatrolIntegrationTester $) async {
  TestProviderOverrides.instance().setOverrides([
    credentialsRepositoryProvider
        .overrideWith((ref) => _CredentialsRepositoryMock()),
  ]);
}

class _CredentialsRepositoryMock implements ICredentialRepository {
  bool _isSigned = true;
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2MzI3Mzc3OGNjYWU0ZmM4OTRhZjhjZDgxM2IyM2JiNSIsImlhdCI6MTczNDk1OTI2MCwiZXhwIjoyMDUwMzE5MjYwfQ.Ix-n_ErzSoOqEH87AOsf-1bPDBN62woy8hXmPWc5WWI';

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
