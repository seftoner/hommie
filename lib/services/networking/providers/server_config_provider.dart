import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_config_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
Future<Server> serverConfig(Ref ref, int serverId) async {
  final manager = ref.read(serverManagerProvider);
  final servers = await manager.getAvailableServers();
  final server = servers.firstWhere(
    (element) => element.id == serverId,
    orElse: () => throw StateError('Server $serverId not found'),
  );
  return server;
}
