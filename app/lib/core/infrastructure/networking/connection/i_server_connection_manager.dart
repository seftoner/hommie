import 'package:home_assistant_client/home_assistant_client.dart';

abstract interface class IServerConnectionManager {
  Future<IHAConnection> getConnection(int serverId);
  void disconnect(int serverId);
  void setActiveServer(int? serverId);
}
