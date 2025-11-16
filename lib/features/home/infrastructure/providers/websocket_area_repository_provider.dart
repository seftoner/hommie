import 'package:hommie/features/home/domain/repositories/i_area_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/websocket_area_repository.dart';
import 'package:hommie/services/networking/server_connection_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'websocket_area_repository_provider.g.dart';

/// Provides WebSocket-based area repository for a specific server
///
/// This fetches area data directly from Home Assistant via WebSocket API
/// Use this when you need real-time area data from a specific server
@Riverpod(dependencies: [serverConnectionManager])
Future<IAreaRepository> websocketAreaRepository(Ref ref, int serverId) async {
  final connection = await ref
      .watch(serverConnectionManagerProvider)
      .getConnection(serverId);
  return WebSocketAreaRepository(connection);
}
