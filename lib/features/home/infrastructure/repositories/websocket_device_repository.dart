import 'package:hommie/features/home/domain/entities/device.dart';
import 'package:hommie/features/home/domain/repositories/i_device_repository.dart';
import 'package:hommie/services/networking/home_assistant_websocket/ha_connection.dart';

/// WebSocket-based implementation of device repository
/// Fetches device data from Home Assistant via WebSocket API
///
/// Note: Home Assistant doesn't have a direct device API via WebSocket.
/// Devices are usually inferred from entities. This implementation provides
/// a placeholder that can be extended when device support is added.
class WebSocketDeviceRepository implements IDeviceRepository {
  // ignore: unused_field
  final HAConnection _connection;

  WebSocketDeviceRepository(this._connection);

  @override
  Future<List<Device>> getAll() async {
    // TODO: Implement when HA WebSocket API supports device listing
    // For now, this could extract devices from entities or use other methods
    throw UnimplementedError(
      'Device listing via WebSocket API not yet implemented. '
      'Consider using Isar repository for cached device data.',
    );
  }

  @override
  Future<Device?> getById(int id) async {
    throw UnimplementedError(
      'Device get by ID via WebSocket API not yet implemented.',
    );
  }

  @override
  Future<Device?> getByHaId(String haId) async {
    throw UnimplementedError(
      'Device get by HA ID via WebSocket API not yet implemented.',
    );
  }

  @override
  Future<List<Device>> getByArea(int areaId) async {
    throw UnimplementedError(
      'Device listing by area via WebSocket API not yet implemented.',
    );
  }

  @override
  Future<void> save(Device device) async {
    throw UnsupportedError('WebSocket API does not support saving devices');
  }

  @override
  Future<void> delete(int id) async {
    throw UnsupportedError('WebSocket API does not support deleting devices');
  }
}
