import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_assistant_client/home_assistant_client.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

/// Hosts a nested [ProviderScope] that injects server-specific overrides for the
/// current Home Assistant server session.
@Dependencies([ActiveServerSession])
class ServerScopeHost extends ConsumerWidget {
  const ServerScopeHost({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(activeServerSessionProvider);

    return switch (session) {
      OnlineServerSession(:final activeServer, :final connection) =>
        _buildServerScope(activeServer, connection),
      ConnectingServerSession(:final activeServer) ||
      OfflineServerSession(:final activeServer) ||
      AuthRevokedServerSession(
        :final activeServer,
      ) => _buildServerScope(activeServer, null),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildServerScope(Server activeServer, IHAConnection? connection) {
    final serverId = activeServer.id;
    if (serverId == null) {
      return const SizedBox.shrink();
    }

    return ProviderScope(
      key: ValueKey((serverId, connection)),
      overrides: [
        serverScopeIdProvider.overrideWith((_) => serverId),
        serverScopeServerProvider.overrideWith((_) => activeServer),
        serverScopeConnectionProvider.overrideWith((_) {
          if (connection == null) {
            throw const ServerScopeConnectionUnavailableException();
          }
          return connection;
        }),
      ],
      child: child,
    );
  }
}
