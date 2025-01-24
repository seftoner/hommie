import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/domain/repository/i_credential_repository.dart';
import 'package:oauth2/oauth2.dart';

class SecureCredentialRepository implements ICredentialRepository {
  final FlutterSecureStorage _storage;
  final int _serverId;

  SecureCredentialRepository(this._storage, this._serverId);

  static const String _key = 'oauthCredentialsForServer:';
  Credentials? _cachedCredentials;

  String get _credentialKey => '$_key${_serverId.toString()}';

  @override
  Future<Credentials?> read() async {
    if (_cachedCredentials != null) {
      return _cachedCredentials!;
    }

    final json = await _storage.read(key: _credentialKey);
    if (json == null) {
      return null;
    }
    try {
      return _cachedCredentials = Credentials.fromJson(json);
    } on FormatException catch (e) {
      logger.e('Error parsing credentials: $e');
      return null;
    }
  }

  @override
  Future<void> save(Credentials credentials) {
    _cachedCredentials = credentials;
    //BUG: apply force delete, cause write is not re-writing a new value
    _storage.delete(key: _credentialKey);
    return _storage.write(key: _credentialKey, value: credentials.toJson());
  }

  @override
  Future<void> clear() {
    _cachedCredentials = null;
    return _storage.delete(key: _credentialKey);
  }
}
