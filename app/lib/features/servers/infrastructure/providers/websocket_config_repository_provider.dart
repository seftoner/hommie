import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/features/servers/domain/repositories/i_websocket_config_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'websocket_config_repository_provider.g.dart';

/// Provides WebSocket config repository for server-level operations
///
/// This handles ping, config, and other server-wide operations via WebSocket
@riverpod
Future<IWebSocketConfigRepository> websocketConfigRepository(
  Ref ref,
  int serverId,
) async {
  final connection = await ref
      .watch(serverConnectionManagerProvider)
      .getConnection(serverId);
  return WebSocketConfigRepository(connection);
}
