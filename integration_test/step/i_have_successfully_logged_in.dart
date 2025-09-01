import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/features/auth/domain/repository/i_credential_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/credential_repository_provider.dart';
import 'package:hommie/features/settings/domain/repository/i_server_settings_repository.dart';
import 'package:hommie/features/settings/infrastructure/providers/server_settings_provider.dart';
import 'package:oauth2/src/credentials.dart';
import 'package:patrol/patrol.dart';
import '../utils/test_context.dart';
import '../utils/test_provider_overrides.dart';

Future<void> iHaveSuccessfullyLoggedIn(PatrolIntegrationTester $) async {
  final token = TestContext.instance().authToken;
  if (token == null) {
    throw Exception('Auth token not found in TestContext');
  }

  // In Riverpod 3, for family providers we use overrideWithValue or override the family itself
  TestProviderOverrides.instance().setOverrides([
    // Override the family provider for all server IDs
    credentialsRepositoryProvider.overrideWith(
      (ref, serverId) => _CredentialsRepositoryMock(token),
    ),
    serverSettingsProvider.overrideWith(
      (ref) => _ServerSettingRepositoryMock(),
    ),
  ]);
}

const _serverUrl = 'http://10.0.2.2:8123';

class _ServerSettingRepositoryMock implements IServerSettingsRepository {
  @override
  Future<void> clear() async {}

  @override
  Future<Uri?> getServerUrl() async {
    return Uri.parse(_serverUrl);
  }

  @override
  Future<void> saveServerUrl(String url) async {}
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
      return Future.value();
    }

    return Future.value(
      Credentials(
        token,
        refreshToken: token,
        expiration: DateTime.now().add(const Duration(days: 365)),
        tokenEndpoint: Uri.parse('$_serverUrl/auth/token'),
      ),
    );
  }

  @override
  Future<void> save(Credentials credentials) {
    return Future.value();
  }
}
