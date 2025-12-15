import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';

/// WebSocket-based implementation of area repository
/// Fetches area data from Home Assistant via WebSocket API
class WebSocketAreaRepository implements IAreaRepository {
  // ignore: unused_field
  final HAConnection _connection;

  WebSocketAreaRepository(this._connection);

  @override
  Future<List<Area>> getAll() async {
    throw UnsupportedError(
      'getAll is not supported in WebSocketAreaRepository',
    );
  }

  @override
  Future<Area?> getById(int id) async {
    throw UnsupportedError(
      'getById is not supported in WebSocketAreaRepository',
    );
  }

  @override
  Future<Area?> getByHaId(String haId) async {
    throw UnsupportedError(
      'getByHaId is not supported in WebSocketAreaRepository',
    );
  }

  @override
  Future<void> save(Area area) async {
    // WebSocket API is read-only for areas
    // This would need to be implemented via REST API or throw UnsupportedError
    throw UnsupportedError('WebSocket API does not support saving areas');
  }

  @override
  Future<void> delete(int id) async {
    // WebSocket API is read-only for areas
    throw UnsupportedError('WebSocket API does not support deleting areas');
  }

  @override
  Future<List<Area>> getByServer(int serverId) async {
    // All areas from this connection belong to the same server
    return getAll();
  }
}
