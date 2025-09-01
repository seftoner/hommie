import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/servers/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/services/networking/server_connection_provider.dart';
import 'package:hommie/services/networking/server_scope_provider.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

/// A widget that creates a ProviderScope with the current active server context.
///
/// This widget automatically updates the server scope when the active server changes,
/// causing all dependent providers to refresh with the new server's data.
///
/// All server-dependent providers should depend on the scoped providers instead
/// of directly accessing server connections.
@Dependencies([ActiveServer])
class ServerScopeWidget extends ConsumerWidget {
  final Widget child;

  const ServerScopeWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeServerAsync = ref.watch(activeServerProvider);

    return switch (activeServerAsync) {
      AsyncData(:final value) =>
        value == null ? _buildFallbackScope() : _buildServerScope(value),
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncError(:final error) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text('Error loading active server: $error'),
          ],
        ),
      ),
    };
  }

  Widget _buildFallbackScope() {
    // No active server - provide fallback implementations that return empty/error states
    logger.d('No active server - creating fallback server scope');

    return ProviderScope(
      overrides: [
        // Provide fallback implementations that don't crash
        serverScopeConnectionProvider.overrideWith((ref) async {
          throw Exception(
            'No active server configured. Please add and select a server.',
          );
        }),

        serverScopeIdProvider.overrideWith((ref) {
          throw Exception(
            'No active server configured. Please add and select a server.',
          );
        }),

        serverScopeServerProvider.overrideWith((ref) async {
          throw Exception(
            'No active server configured. Please add and select a server.',
          );
        }),
      ],
      child: child,
    );
  }

  Widget _buildServerScope(activeServer) {
    logger.d(
      'Creating server scope for: ${activeServer.name} (ID: ${activeServer.id})',
    );

    // Create a new ProviderScope with server-specific overrides
    return ProviderScope(
      overrides: [
        // Override the scoped connection provider with the active server's connection
        serverScopeConnectionProvider.overrideWith((ref) async {
          final connection = await ref.watch(
            serverConnectionProvider(activeServer.id!).future,
          );
          return connection;
        }),

        // Override the scoped server ID provider
        serverScopeIdProvider.overrideWith((ref) => activeServer.id!),

        // Override the scoped server provider
        serverScopeServerProvider.overrideWith((ref) async => activeServer),
      ],
      child: child,
    );
  }
}
