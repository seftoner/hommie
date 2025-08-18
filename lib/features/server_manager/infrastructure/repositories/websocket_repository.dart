import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/features/home/domain/entities/device.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_websocket_repository.dart';
import 'package:hommie/services/networking/home_assistant_websocket/ha_commands.dart';
import 'package:hommie/services/networking/home_assistant_websocket/ha_connection.dart';
import 'package:hommie/services/networking/home_assistant_websocket/src/types/types.dart';

class WebSocketRepository implements IWebSocketRepository {
  final HAConnection _connection;

  WebSocketRepository(this._connection);

  @override
  Future<HassConfig> getConfig() async {
    return HACommands.getConfig(_connection);
  }

  @override
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
  }

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
