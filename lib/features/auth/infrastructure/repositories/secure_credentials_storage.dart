import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/features/auth/domain/repository/i_credential_repository.dart';
import 'package:oauth2/oauth2.dart';

class SecureCredentialRepository implements ICredentialRepository {
  final FlutterSecureStorage _storage;

  SecureCredentialRepository(this._storage);

  static const String _key = 'oauthCredentialsForServer:';
  final Map<int, Credentials> _cachedCredentials = {};

  String _credentialKey(int serverId) => '$_key${serverId.toString()}';

  @override
  Future<Credentials?> read(int serverId) async {
    if (_cachedCredentials.containsKey(serverId)) {
      return _cachedCredentials[serverId]!;
    }

    final json = await _storage.read(key: _credentialKey(serverId));
    if (json == null) {
      return null;
    }
    try {
      final credentials = Credentials.fromJson(json);
      _cachedCredentials[serverId] = credentials;
      return credentials;
    } on FormatException catch (e) {
      logger.e('Error parsing credentials for server $serverId: $e');
      return null;
    }
  }

  @override
  Future<void> save(int serverId, Credentials credentials) {
    _cachedCredentials[serverId] = credentials;
    //BUG: apply force delete, cause write is not re-writing a new value
    _storage.delete(key: _credentialKey(serverId));
    return _storage.write(
      key: _credentialKey(serverId),
      value: credentials.toJson(),
    );
  }

  @override
  Future<void> clear(int serverId) {
    _cachedCredentials.remove(serverId);
    return _storage.delete(key: _credentialKey(serverId));
  }

  @override
  Future<bool> hasCredentials(int serverId) async {
    final credentials = await read(serverId);
    return credentials != null;
  }
}
