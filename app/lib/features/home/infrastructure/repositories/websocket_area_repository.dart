import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/services/networking/home_assistant_websocket/ha_commands.dart';
import 'package:hommie/services/networking/home_assistant_websocket/ha_connection.dart';

/// WebSocket-based implementation of area repository
/// Fetches area data from Home Assistant via WebSocket API
class WebSocketAreaRepository implements IAreaRepository {
  final HAConnection _connection;

  WebSocketAreaRepository(this._connection);

  @override
  Future<List<Area>> getAll() async {
    final areas = await HACommands.getAreas(_connection);
    return areas
        .map(
          (area) => Area(
            id: area.area_id,
            name: area.name,
            imageUrl: area.picture,
            aliases: area.aliases,
            // Note: backgroundUrl and labels not available in HA API response
          ),
        )
        .toList();
  }

  @override
  Future<Area?> getById(int id) async {
    // WebSocket API doesn't support get by internal ID
    // This would need to be implemented by getting all and filtering
    final areas = await getAll();
    return areas.cast<Area?>().firstWhere(
      (area) => area?.id == id.toString(),
      orElse: () => null,
    );
  }

  @override
  Future<Area?> getByHaId(String haId) async {
    final areas = await getAll();
    return areas.cast<Area?>().firstWhere(
      (area) => area?.id == haId,
      orElse: () => null,
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
