import 'package:hommie/core/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hommie/features/server_manager/domain/models/server.dart';
import 'package:hommie/features/server_manager/infrastructure/providers/server_manager_provider.dart';

part 'active_server_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
class ActiveServer extends _$ActiveServer {
  @override
  Future<Server?> build() async {
    final serverManager = ref.read(serverManagerProvider);
    return serverManager.getActiveServer();
  }

  Future<void> setActive(int serverId) async {
    final serverManager = ref.read(serverManagerProvider);
    final previousServer = state.valueOrNull;

    logger.i(
        'Switching active server from ${previousServer?.name} to server ID: $serverId');

    // Update the active server in the database
    await serverManager.setActiveServer(serverId);

    // Get the new active server
    final activeServer = await serverManager.getActiveServer();
    state = AsyncData(activeServer);

    logger.i('Active server switched to: ${activeServer?.name}');

    // Important: Invalidate all server-dependent providers
    // This ensures that all data (areas, entities, etc.) is refreshed for the new server
    _invalidateServerDependentProviders();
  }

  /// Invalidates all providers that depend on the current server connection.
  /// This ensures that switching servers properly refreshes all Home Assistant data.
  void _invalidateServerDependentProviders() {
    logger.d('Invalidating server-dependent providers');

    // With the new ProviderScope approach, all server-dependent providers will be
    // automatically updated when the active server changes. The ServerScopeWidget
    // creates a new scope with overridden providers for each server.

    // We can manually invalidate other providers if needed
    // Example: ref.invalidate(areasControllerProvider);
    // Example: ref.invalidate(entitiesControllerProvider);
  }
}
