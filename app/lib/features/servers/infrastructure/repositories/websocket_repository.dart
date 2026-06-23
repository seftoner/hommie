import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/features/servers/domain/repositories/i_websocket_repository.dart';

class WebSocketRepository implements IWebSocketRepository {
  final IHAConnection _connection;

  WebSocketRepository(this._connection);

  @override
  Future<HassConfig> getConfig() async {
    return HomeAssistantApi.fromConnection(_connection).config.get();
  }

  @override
  Future<bool> sendPing() async {
    try {
      await _connection.sendMessage(const PingMessage());
      return true;
    } catch (e) {
      return false;
    }
  }
}
