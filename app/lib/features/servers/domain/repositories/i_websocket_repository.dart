import 'package:home_assistant_client/home_assistant_client.dart';

abstract interface class IWebSocketRepository {
  Future<bool> sendPing();
  Future<HassConfig> getConfig();

  // Stream<List<Area>> getAreaUpdates();
  // Stream<List<Device>> getDeviceUpdates();
  // Stream<List<Entity>> getEntityUpdates();

  // Future<List<Area>> getAreas();
  // Future<List<Device>> getDevices();
  // Future<List<Entity>> getEntities();
}
