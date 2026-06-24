import 'package:home_assistant_client/home_assistant_client.dart';

abstract interface class IServerConnectionManager {
  Future<IHAConnection> getConnection(int serverId);
  void disconnect(int serverId);
  void retryActiveConnection();
  void setActiveServer(int? serverId);
  void setNetworkAvailable({required bool isAvailable});
}
