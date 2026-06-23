import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/networking/connection/ha_connection_factory.dart';
import 'package:hommie/core/infrastructure/networking/connection/managed_ha_connection.dart';
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
  return OneShotWebSocketConfigRepository(
    factory: HAConnectionFactory(ref),
    serverId: serverId,
  );
}

final class OneShotWebSocketConfigRepository
    implements IWebSocketConfigRepository {
  const OneShotWebSocketConfigRepository({
    required IHAConnectionFactory factory,
    required int serverId,
  }) : _factory = factory,
       _serverId = serverId;

  final IHAConnectionFactory _factory;
  final int _serverId;

  @override
  Future<HassConfig> getConfig() async {
    final opening = _factory.open(_serverId);
    ManagedHAConnection? managed;

    try {
      managed = await opening.future;
      return HACommands.getConfig(managed.connection);
    } finally {
      if (managed == null) {
        await opening.close();
      } else {
        await managed.close();
      }
    }
  }
}
