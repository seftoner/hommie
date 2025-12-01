import 'package:home_assistant_websocket/home_assistant_websocket.dart';

/// Repository for WebSocket-only operations (ping, config, etc.)
///
/// This handles operations that don't fit into domain-specific repositories
/// but are needed for server management and connectivity
abstract interface class IWebSocketConfigRepository {
  Future<HassConfig> getConfig();
}

class WebSocketConfigRepository implements IWebSocketConfigRepository {
  final HAConnection _connection;

  WebSocketConfigRepository(this._connection);

  @override
  Future<HassConfig> getConfig() async {
    return HACommands.getConfig(_connection);
  }
}
