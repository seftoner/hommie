import 'package:hommie/services/networking/home_assistant_websocket/home_assistant_websocket.dart';

abstract interface class IServerConnectionManager {
  Future<HAConnection> getConnection(int serverId);
  Future<void> reconnect(int serverId);
  void disconnect(int serverId);
  void setActiveServer(int? serverId);
}
