abstract class AppConfig {
  Future<String?> getRemoteHomeAssistantServerUri();
  void setRemoteHomeAssistantServerUri(String uri);
  void clearData();
}
