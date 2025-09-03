import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/servers/domain/i_server_manager.dart';
import 'package:hommie/features/servers/domain/models/server.dart';
import 'package:hommie/features/servers/domain/repositories/i_server_repository.dart';

class ServerManager implements IServerManager {
  final IServerRepository _serverRepository;

  ServerManager(this._serverRepository);

  @override
  Future<Server> addServer(Server config) {
    return _serverRepository.save(config);
  }

  @override
  Future<Server?> getActiveServer() {
    return _serverRepository.getActiveServer();
  }

  @override
  Future<List<Server>> getAvailableServers() {
    return _serverRepository.getAll();
  }

  @override
  Future<void> removeServer(int id) async {
    await _removeServerInternal(id, allowLastServer: false);
  }

  /// Force remove a server, even if it's the last one (used during sign out)
  @override
  Future<void> forceRemoveServer(int id) async {
    await _removeServerInternal(id, allowLastServer: true);
  }

  Future<void> _removeServerInternal(
    int id, {
    required bool allowLastServer,
  }) async {
    // Get all servers to check if this is the last one
    final allServers = await getAvailableServers();
    final isLastServer = allServers.length <= 1;

    if (isLastServer && !allowLastServer) {
      throw Exception(
        'Cannot delete the last server. At least one server must be configured.',
      );
    }

    // Check if this is the active server
    final activeServer = await getActiveServer();
    final isActiveServer = activeServer?.id == id;

    // 1. Delete the server from database
    await _serverRepository.delete(id);

    // 2. Handle active server logic (only if we're not deleting the last server)
    if (!isLastServer) {
      final remainingServers = await getAvailableServers();

      if (remainingServers.length == 1) {
        // If only one server remains, automatically make it active
        logger.i(
          'Only one server remaining, making it active: ${remainingServers.first.name}',
        );
        await setActiveServer(remainingServers.first.id!);
      } else if (isActiveServer && remainingServers.isNotEmpty) {
        // If deleted server was active and multiple servers remain, switch to the first one
        logger.i(
          'Deleted active server, switching to ${remainingServers.first.name}',
        );
        await setActiveServer(remainingServers.first.id!);
      }
    } else {
      // If this was the last server, clear the active server
      logger.i('Removed the last server, clearing active server');
    }

    logger.i('Successfully removed server $id');
  }

  @override
  Future<void> setActiveServer(int id) {
    return _serverRepository.setActiveServer(id);
  }
}
