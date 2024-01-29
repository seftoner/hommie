import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/networking/credential_storage.dart';
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

    final credentials = await _storage.read(key: _key);
    if (credentials == null) {
      return null;
    }
    try {
      return _cachedCredentials = Credentials.fromJson(credentials);
    } on FormatException catch (e) {
      print('Error parsing credentials: $e');
      return null;
    }
  }

  @override
  Future<void> save(Credentials credentials) async {
    await _storage.write(key: 'oauthCredentials', value: credentials.toJson());
    await _storage.write(key: 'token', value: credentials.accessToken);
    await _storage.write(key: 'refreshToken', value: credentials.refreshToken);
  }

  @override
  Future<void> clear() {
    _cachedCredentials = null;
    return _storage.delete(key: _key);
  }
}
