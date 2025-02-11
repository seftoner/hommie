import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/features/home/domain/entities/device.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/types/types.dart';

abstract interface class IWebSocketRepository {
  Stream<HAServerConnectionState> get connectionState;
  Future<void> connect();
  Future<void> disconnect();
  Future<bool> sendPing();
  Future<HassConfig> getConfig();

  // Stream<List<Area>> getAreaUpdates();
  // Stream<List<Device>> getDeviceUpdates();
  // Stream<List<Entity>> getEntityUpdates();

  Future<List<Area>> getAreas();
  Future<List<Device>> getDevices();
  // Future<List<Entity>> getEntities();
}
