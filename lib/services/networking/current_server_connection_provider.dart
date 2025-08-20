import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/services/networking/home_assistant_websocket/home_assistant_websocket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hommie/features/server_manager/infrastructure/providers/active_server_provider.dart';
import 'package:hommie/services/networking/server_connection_provider.dart';

part 'current_server_connection_provider.g.dart';

/// Provides the WebSocket connection for the currently active server.
///
/// This provider automatically updates when the active server changes,
/// invalidating all dependent providers to ensure they reflect the new server's data.
@Riverpod(keepAlive: true, dependencies: [ActiveServer])
Future<HAConnection> currentServerConnection(Ref ref) async {
  // Watch the active server
  final activeServer = await ref.watch(activeServerProvider.future);

  if (activeServer == null) {
    throw Exception('No active server configured');
  }

  logger.i(
      'Current server connection for: ${activeServer.name} (ID: ${activeServer.id})');

  // Get the connection for the active server
  final connection =
      await ref.read(serverConnectionProvider(activeServer.id!).future);

  return connection;
}

/// Provides the current active server ID.
///
/// This is a convenience provider that other providers can depend on
/// to get just the server ID without needing the full server object.
@Riverpod(keepAlive: true, dependencies: [ActiveServer])
Future<int> currentServerId(Ref ref) async {
  final activeServer = await ref.watch(activeServerProvider.future);

  if (activeServer?.id == null) {
    throw Exception('No active server configured');
  }

  return activeServer!.id!;
}
