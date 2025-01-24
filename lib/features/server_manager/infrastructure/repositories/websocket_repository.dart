import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/features/home/domain/entities/device.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_websocket_repository.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';

class WebSocketRepository implements IWebSocketRepository {
  @override
  Future<void> connect() {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  // TODO: implement connectionState
  Stream<HAServerConnectionState> get connectionState =>
      throw UnimplementedError();

  @override
  Future<void> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  Future<List<Area>> getAreas() {
    // TODO: implement getAreas
    throw UnimplementedError();
  }

  @override
  Future<List<Device>> getDevices() {
    // TODO: implement getDevices
    throw UnimplementedError();
  }

  @override
  Future<bool> sendPing() {
    // TODO: implement sendPing
    throw UnimplementedError();
  }
}
