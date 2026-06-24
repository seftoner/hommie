import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/features/auth/infrastructure/providers/auth_repository_provider.dart';
import 'package:hommie/features/home/infrastructure/providers/home_view_repository_provider.dart';
import 'package:hommie/features/servers/infrastructure/providers/server_manager_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_lifecycle_controller.g.dart';

abstract interface class IServerLifecycleController {
  Future<void> signOutActiveServer();
  Future<void> signOutServer(int serverId);
  Future<void> deleteServer(int serverId);
}

final class ServerLifecycleException implements Exception {
  const ServerLifecycleException(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() {
    final failure = cause;
    if (failure == null) {
      return 'ServerLifecycleException($message)';
    }

    return 'ServerLifecycleException($message, cause: $failure)';
  }
}

final class ServerLifecycleController implements IServerLifecycleController {
  const ServerLifecycleController(this._ref);

  final Ref _ref;

  @override
  Future<void> signOutActiveServer() async {
    final activeServer = await _ref
        .read(serverManagerProvider)
        .getActiveServer();
    final serverId = activeServer?.id;
    if (serverId == null) {
      return;
    }

    await signOutServer(serverId);
  }

  @override
  Future<void> signOutServer(int serverId) {
    return _removeAuthenticatedServer(serverId);
  }

  @override
  Future<void> deleteServer(int serverId) {
    return _removeAuthenticatedServer(serverId);
  }

  Future<void> _removeAuthenticatedServer(int serverId) async {
    _ref.read(serverConnectionManagerProvider).disconnect(serverId);

    final signOutResult = await _ref
        .read(authRepositoryProvider)
        .signOut(serverId);
    signOutResult.match(
      (failure) => throw ServerLifecycleException(
        'Failed to clear credentials for server $serverId.',
        failure,
      ),
      (_) {},
    );

    try {
      await _ref.read(homeViewRepositoryForServerProvider(serverId)).delete();
    } catch (error) {
      throw ServerLifecycleException(
        'Failed to delete home view for server $serverId.',
        error,
      );
    }

    try {
      await _ref
          .read(serverManagerProvider)
          .removeServer(serverId, allowRemovingLast: true);
    } catch (error) {
      throw ServerLifecycleException(
        'Failed to remove server $serverId.',
        error,
      );
    }
  }
}

@Riverpod(
  keepAlive: true,
  dependencies: [serverConnectionManager, authRepository, serverManager],
)
IServerLifecycleController serverLifecycleController(Ref ref) {
  return ServerLifecycleController(ref);
}
