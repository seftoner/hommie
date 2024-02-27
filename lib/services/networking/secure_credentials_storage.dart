import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/services/networking/credential_storage.dart';
import 'package:oauth2/oauth2.dart';

class SecureCredentialStorage implements CredentialStorage {
  final FlutterSecureStorage _storage;
  SecureCredentialStorage(this._storage);

  static const String _key = "oauthCredentials";
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
      print('Error parsing credentials: $e');
      return null;
    }
  }

  @override
  Future<void> save(Credentials credentials) {
    _cachedCredentials = credentials;
    return _storage.write(key: _key, value: credentials.toJson());
  }

  @override
  Future<void> clear() {
    _cachedCredentials = null;
    return _storage.delete(key: _key);
  }
}
