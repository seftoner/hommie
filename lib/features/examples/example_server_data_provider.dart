import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/services/networking/server_scope_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'example_server_data_provider.g.dart';

/// Example of how easy it is to create server-dependent providers with the new approach.
///
/// Before (old approach):
/// - Had to manually invalidate this provider in active_server_provider.dart
/// - Had to remember to add ref.invalidate() calls
/// - Risk of forgetting to invalidate, causing stale data
///
/// Now (ProviderScope approach):
/// - Just depend on the scoped providers
/// - Automatically updates when server changes
/// - No manual invalidation needed
/// - No risk of stale data

@Riverpod(dependencies: [serverScopeConnection, serverScopeId])
Future<List<String>> exampleEntities(Ref ref) async {
  // Just depend on the scoped connection - that's it!
  await ref.watch(serverScopeConnectionProvider.future);
  final serverId = ref.watch(serverScopeIdProvider);

  // Simulate fetching entities from the current server
  // This will automatically refresh when switching servers
  await Future.delayed(const Duration(milliseconds: 500));

  return [
    'Server $serverId - Light 1',
    'Server $serverId - Switch 1',
    'Server $serverId - Sensor 1',
  ];
}

@Riverpod(dependencies: [serverScopeServer, serverScopeId])
Future<Map<String, dynamic>> exampleServerInfo(Ref ref) async {
  // Another example - also automatically server-aware
  final server = await ref.watch(serverScopeServerProvider.future);
  final serverId = ref.watch(serverScopeIdProvider);

  return {
    'server_name': server.name,
    'server_id': serverId,
    'url': server.url,
    'last_updated': DateTime.now().toIso8601String(),
  };
}

@Riverpod(dependencies: [serverScopeConnection])
Future<String> exampleServerStatus(Ref ref) async {
  // Yet another example showing how simple it is
  final connection = await ref.watch(serverScopeConnectionProvider.future);

  // Use the connection to check server status
  // This automatically switches to the new server's connection
  return 'Connected to server via ${connection.toString()}';
}
