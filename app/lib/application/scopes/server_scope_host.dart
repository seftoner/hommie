import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/core/infrastructure/logging/logger.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_connection_manager.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/core/infrastructure/networking/connection/unavailable_ha_connection.dart';
import 'package:hommie/features/servers/application/active_server.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

/// Hosts a nested [ProviderScope] that injects server-specific overrides for the
/// currently selected Home Assistant server. When no server is active the
/// widget keeps the tree mounted without crashing consumers.
@Dependencies([serverConnectionManager])
class ServerScopeHost extends ConsumerStatefulWidget {
  const ServerScopeHost({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<ServerScopeHost> createState() => _ServerScopeHostState();
}

class _ServerScopeHostState extends ConsumerState<ServerScopeHost> {
  int? _serverId;
  Future<IHAConnection>? _connectionFuture;

  Future<IHAConnection> _connectionFor(int serverId) {
    if (_serverId == serverId && _connectionFuture != null) {
      return _connectionFuture!;
    }

    _serverId = serverId;
    _connectionFuture = ref
        .read(serverConnectionManagerProvider)
        .getConnection(serverId);
    return _connectionFuture!;
  }

  @override
  Widget build(BuildContext context) {
    final activeServer = ref.watch(activeServerProvider);

    return switch (activeServer) {
      AsyncLoading() => const SizedBox.shrink(),
      AsyncError(:final error, :final stackTrace) => _buildActiveServerError(
        error,
        stackTrace,
      ),
      AsyncData(:final value) when value == null => _buildNoServer(),
      AsyncData(:final value) => _buildServerScope(value!),
    };
  }

  Widget _buildActiveServerError(Object error, StackTrace stackTrace) {
    logger.e(
      'Failed to resolve active server: $error',
      error: error,
      stackTrace: stackTrace,
    );
    return _FallbackScope(child: widget.child);
  }

  Widget _buildNoServer() {
    _serverId = null;
    _connectionFuture = null;
    return _FallbackScope(child: widget.child);
  }

  Widget _buildServerScope(Server server) {
    final serverId = server.id!;

    return FutureBuilder<IHAConnection>(
      future: _connectionFor(serverId),
      builder: (context, snapshot) {
        final connection = snapshot.data;
        final scopedConnection =
            connection ??
            UnavailableHAConnection(
              serverId: serverId,
              cause:
                  snapshot.error ??
                  (snapshot.connectionState == ConnectionState.done
                      ? 'Connection unavailable'
                      : 'Connection is still loading'),
            );

        if (connection == null && snapshot.hasError) {
          logger.w(
            'Server $serverId running without connection (offline mode): ${snapshot.error}',
            error: snapshot.error,
            stackTrace: snapshot.stackTrace,
          );
        }

        return ProviderScope(
          key: ValueKey(serverId),
          overrides: [
            serverScopeIdProvider.overrideWith((_) => serverId),
            serverScopeServerProvider.overrideWith((_) => server),
            serverScopeConnectionProvider.overrideWith((_) => scopedConnection),
          ],
          child: widget.child,
        );
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
