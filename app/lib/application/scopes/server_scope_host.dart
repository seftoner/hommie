import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/application/session/active_server_session_controller.dart';
import 'package:hommie/application/session/active_server_session_state.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

/// Hosts a nested [ProviderScope] that injects server-specific overrides for the
/// currently online Home Assistant server.
@Dependencies([ActiveServerSession])
class ServerScopeHost extends ConsumerWidget {
  const ServerScopeHost({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(activeServerSessionProvider);

    return switch (session) {
      OnlineServerSession(:final activeServer, :final connection)
          when activeServer.id != null =>
        ProviderScope(
          key: ValueKey(activeServer.id),
          overrides: [
            serverScopeIdProvider.overrideWith((_) => activeServer.id!),
            serverScopeServerProvider.overrideWith((_) => activeServer),
            serverScopeConnectionProvider.overrideWith((_) => connection),
          ],
          child: child,
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
