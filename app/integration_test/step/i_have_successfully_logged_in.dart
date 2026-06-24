import 'dart:async';

import 'package:hommie/features/auth/domain/repository/i_credential_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/credential_repository_provider.dart';
import 'package:hommie/features/common/domain/values/server_url.dart';
import 'package:hommie/features/settings/domain/repository/i_server_settings_repository.dart';
import 'package:hommie/features/settings/infrastructure/providers/server_settings_provider.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
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
    // Override the credential repository provider
    credentialRepositoryProvider.overrideWith(
      (ref) => _CredentialsRepositoryMock(token),
    ),
    serverSettingsProvider.overrideWith(
      (ref) => _ServerSettingRepositoryMock(),
    ),
    serverManagerProvider.overrideWith((ref) => _ServerManagerMock()),
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
  Future<void> clear(int serverId) {
    _isSigned = false;
    return Future.value();
  }

  @override
  Future<Credentials?> read(int serverId) {
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
  Future<void> save(int serverId, Credentials credentials) {
    return Future.value();
  }

  @override
  Future<bool> hasCredentials(int serverId) {
    return Future.value(_isSigned);
  }
}

class _ServerManagerMock implements IServerManager {
  _ServerManagerMock();

  final _controller = StreamController<Server?>.broadcast();
  Server? _active = Server(
    id: 1,
    name: 'Test home',
    baseUrl: ServerUrl(_serverUrl),
  );

  @override
  Future<Server> addServer(Server config) async {
    final saved = Server(
      id: config.id ?? 1,
      name: config.name,
      baseUrl: config.baseUrl ?? ServerUrl(_serverUrl),
      internalUrl: config.internalUrl,
      externalUrl: config.externalUrl,
      version: config.version,
    );
    _active = saved;
    _controller.add(saved);
    return saved;
  }

  @override
  Future<Server?> getActiveServer() async => _active;

  @override
  Future<List<Server>> getServers() async => [?_active];

  @override
  Stream<Server?> watchActiveServer() => _controller.stream;

  @override
  Future<Server?> activateServer(int id) async {
    _controller.add(_active);
    return _active;
  }

  @override
  Future<Server?> activateNextServer({int? excludingId}) async {
    _active = null;
    _controller.add(null);
    return null;
  }

  @override
  Future<void> removeServer(int id, {bool allowRemovingLast = false}) async {
    _active = null;
    _controller.add(null);
  }
}
