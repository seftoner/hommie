import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hommie/features/settings/domain/repository/i_server_settings_repository.dart';

class SecureServerSettingsRepository implements IServerSettingsRepository {
  final FlutterSecureStorage _storage;
  Uri? _cachedUri;
  static const _serverUrlKey = 'server_url';

  SecureServerSettingsRepository(this._storage);

  @override
  Future<Uri?> getServerUrl() async {
    if (_cachedUri != null) {
      return _cachedUri;
    }
    final url = await _storage.read(key: _serverUrlKey);
    return url != null ? Uri.parse(url) : null;
  }

  @override
  Future<void> saveServerUrl(String url) async {
    _cachedUri = Uri.parse(url);
    await _storage.delete(key: _serverUrlKey);
    await _storage.write(key: _serverUrlKey, value: url);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _serverUrlKey);
  }
}
