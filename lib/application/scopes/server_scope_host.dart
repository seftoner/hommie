import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/services/networking/server_connection_manager.dart';
import 'package:hommie/services/networking/server_scope_provider.dart';

/// Hosts a nested [ProviderScope] that injects server-specific overrides for the
/// currently selected Home Assistant server. When no server is active the
/// widget keeps the tree mounted without crashing consumers.
class ServerScopeHost extends ConsumerWidget {
  const ServerScopeHost({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeServer = ref.watch(activeServerProvider);

    return activeServer.when(
      data: (server) {
        if (server == null) {
          return ProviderScope(overrides: _fallbackOverrides, child: child);
        }

        return ProviderScope(
          overrides: [
            serverScopeIdProvider.overrideWith((innerRef) => server.id!),
            serverScopeServerProvider.overrideWith((innerRef) => server),
            serverScopeConnectionProvider.overrideWith(
              (innerRef) => innerRef
                  .watch(serverConnectionManagerProvider)
                  .getConnection(server.id!),
            ),
          ],
          child: child,
        );
      },
      loading: () => child,
      error: (error, stackTrace) {
        logger.e(
          'Failed to resolve active server: $error',
          error: error,
          stackTrace: stackTrace,
        );
        return ProviderScope(overrides: _fallbackOverrides, child: child);
      },
    );
  }
}

final _fallbackOverrides = [
  serverScopeIdProvider.overrideWith(
    (ref) => throw const NoActiveServerSelectedException(),
  ),
  serverScopeServerProvider.overrideWith(
    (ref) => throw const NoActiveServerSelectedException(),
  ),
  serverScopeConnectionProvider.overrideWith(
    (ref) => Future.error(const NoActiveServerSelectedException()),
  ),
];

class NoActiveServerSelectedException implements Exception {
  const NoActiveServerSelectedException();

  @override
  String toString() => 'No active server configured.';
}
