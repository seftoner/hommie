import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/domain/repository/i_credential_repository.dart';
import 'package:oauth2/oauth2.dart';

class SecureCredentialRepository implements ICredentialRepository {
  final FlutterSecureStorage _storage;
  SecureCredentialRepository(this._storage);

  static const String _key = 'oauthCredentials';
  Credentials? _cachedCredentials;

  @override
  Future<Credentials?> read() async {
    if (_cachedCredentials != null) {
      return _cachedCredentials!;
    }

    final json = await _storage.read(key: _key);
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
    _storage.delete(key: _key);
    return _storage.write(key: _key, value: credentials.toJson());
  }

  @override
  Future<void> clear() {
    _cachedCredentials = null;
    return _storage.delete(key: _key);
  }
}
