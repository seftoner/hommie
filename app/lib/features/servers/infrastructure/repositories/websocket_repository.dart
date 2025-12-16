import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/features/servers/domain/repositories/i_websocket_repository.dart';

class WebSocketRepository implements IWebSocketRepository {
  final HAConnection _connection;

  WebSocketRepository(this._connection);

  @override
  Future<HassConfig> getConfig() async {
    return HACommands.getConfig(_connection);
  }

  /*   @override
  Future<List<Area>> getAreas() async {
    throw UnimplementedError();
    // final areas = await HACommands.getAreas(_connection);
    // return areas.map((area) => Area.fromHassArea(area)).toList();
  }

  @override
  Future<List<Device>> getDevices() async {
    throw UnimplementedError();
    // final devices = await HACommands.getDevices(_connection);
    // return devices.map((device) => Device.fromHassDevice(device)).toList();
  } */

  @override
  Future<bool> sendPing() async {
    try {
      await HACommands.pingServer(_connection);
      return true;
    } catch (e) {
      return false;
    }
  }
}
