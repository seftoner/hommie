import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/auth/domain/repository/i_auth_repository.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/server_manager/domain/i_server_manager.dart';
import 'package:hommie/features/server_manager/domain/models/server.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_server_repository.dart';
import 'package:hommie/features/server_manager/domain/repositories/i_websocket_repository.dart';
import 'package:hommie/features/server_manager/infrastructure/repositories/websocket_repository.dart';
import 'package:hommie/services/networking/server_connection_provider.dart';

class ServerManager implements IServerManager {
  final IServerRepository _serverRepository;
  final Ref _ref;

  ServerManager(this._serverRepository, this._ref);

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

  Future<void> _removeServerInternal(int id,
      {required bool allowLastServer}) async {
    // Get all servers to check if this is the last one
    final allServers = await getAvailableServers();
    final isLastServer = allServers.length <= 1;

    if (isLastServer && !allowLastServer) {
      throw Exception(
          'Cannot delete the last server. At least one server must be configured.');
    }

    // Check if this is the active server
    final activeServer = await getActiveServer();
    final isActiveServer = activeServer?.id == id;

    try {
      // 1. Revoke OAuth token and clear credentials for this server (best effort)
      await _revokeServerToken(id);
    } catch (e) {
      // Log but don't fail deletion if token revocation fails
      logger.w('Failed to revoke token for server $id: $e');
    }

    // 2. Delete the server from database
    await _serverRepository.delete(id);

    // 3. Handle active server logic (only if we're not deleting the last server)
    if (!isLastServer) {
      final remainingServers = await getAvailableServers();

      if (remainingServers.length == 1) {
        // If only one server remains, automatically make it active
        logger.i(
            'Only one server remaining, making it active: ${remainingServers.first.name}');
        await setActiveServer(remainingServers.first.id!);
      } else if (isActiveServer && remainingServers.isNotEmpty) {
        // If deleted server was active and multiple servers remain, switch to the first one
        logger.i(
            'Deleted active server, switching to ${remainingServers.first.name}');
        await setActiveServer(remainingServers.first.id!);
      }
    } else {
      // If this was the last server, clear the active server
      logger.i('Removed the last server, clearing active server');
    }

    logger.i('Successfully removed server $id');
  }

  /// Revoke the OAuth token for a server
  Future<void> _revokeServerToken(int serverId) async {
    try {
      final authRepository = getAuthRepository(serverId);

      // Use the same approach as signOut() in AuthRepository
      // This properly revokes the token via OAuth2 token endpoint
      final result = await authRepository.signOut();

      result.fold(
        (failure) {
          logger.w('Failed to revoke token for server $serverId: $failure');
        },
        (_) {
          logger.i('Successfully revoked token for server $serverId');
        },
      );
    } catch (e) {
      logger.e('Error during token revocation for server $serverId: $e');
      rethrow;
    }
  }

  @override
  Future<void> setActiveServer(int id) {
    return _serverRepository.setActiveServer(id);
  }

  @override
  Future<IWebSocketRepository> webSocketRepository(int serverId) async {
    final connection =
        await _ref.read(serverConnectionProvider(serverId).future);
    return WebSocketRepository(connection);
  }

  @override
  IAuthRepository getAuthRepository(int serverId) {
    return _ref.read(authRepositoryProvider(serverId));
  }
}
