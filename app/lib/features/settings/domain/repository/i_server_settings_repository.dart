abstract class IServerSettingsRepository {
  Future<Uri?> getServerUrl();
  Future<void> saveServerUrl(String url);
  Future<void> clear();
}
