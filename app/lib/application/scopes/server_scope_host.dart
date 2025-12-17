import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/servers/application/active_server.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_scope_host.g.dart';

@Riverpod(dependencies: [serverConnectionManager])
Future<IHAConnection> getServerConnection(Ref ref, int serverId) async {
  final connection = await ref
      .read(serverConnectionManagerProvider)
      .getConnection(serverId);

  return connection;
}

/// Hosts a nested [ProviderScope] that injects server-specific overrides for the
/// currently selected Home Assistant server. When no server is active the
/// widget keeps the tree mounted without crashing consumers.
@Dependencies([getServerConnection])
class ServerScopeHost extends ConsumerWidget {
  const ServerScopeHost({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeServer = ref.watch(activeServerProvider);

    return activeServer.when(
      data: (server) {
        if (server == null) {
          return _FallbackScope(child: child);
        }

        final connectionAsync = ref.watch(
          getServerConnectionProvider(server.id!),
        );

        return connectionAsync.when(
          data: (connection) {
            final overrides = [
              serverScopeIdProvider.overrideWith((_) => server.id!),
              serverScopeServerProvider.overrideWith((_) => server),
              serverScopeConnectionProvider.overrideWith((_) => connection),
            ];

            return ProviderScope(
              key: ValueKey(server.id),
              overrides: overrides,
              child: child,
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (error, stackTrace) {
            logger.e(
              'Failed to resolve server connection for ${server.id}: $error',
              error: error,
              stackTrace: stackTrace,
            );
            return const SizedBox.shrink();
          },
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) {
        logger.e(
          'Failed to resolve active server: $error',
          error: error,
          stackTrace: stackTrace,
        );
        return _FallbackScope(child: child);
      },
    );
  }
}

class _FallbackScope extends StatelessWidget {
  const _FallbackScope({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        serverScopeIdProvider.overrideWith(
          (_) => throw const NoActiveServerSelectedException(),
        ),
        serverScopeServerProvider.overrideWith(
          (_) => throw const NoActiveServerSelectedException(),
        ),
        serverScopeConnectionProvider.overrideWith(
          (_) => throw const NoActiveServerSelectedException(),
        ),
      ],
      child: child,
    );
  }
}

class NoActiveServerSelectedException implements Exception {
  const NoActiveServerSelectedException();

  @override
  String toString() => 'No active server configured.';
}
