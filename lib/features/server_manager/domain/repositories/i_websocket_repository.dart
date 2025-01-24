import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/features/home/domain/entities/device.dart';
import 'package:hommie/services/networking/connection_state_provider.dart';

abstract interface class IWebSocketRepository {
  Stream<HAServerConnectionState> get connectionState;
  Future<void> connect();
  Future<void> disconnect();
  Future<bool> sendPing();

  // Stream<List<Area>> getAreaUpdates();
  // Stream<List<Device>> getDeviceUpdates();
  // Stream<List<Entity>> getEntityUpdates();

  Future<List<Area>> getAreas();
  Future<List<Device>> getDevices();
  // Future<List<Entity>> getEntities();
}
