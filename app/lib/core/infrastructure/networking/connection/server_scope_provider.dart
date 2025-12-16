import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:hommie/features/servers/domain/entities/server.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'server_scope_provider.g.dart';

/// A scoped provider that represents the connection for the current server context.
///
/// This provider is designed to be overridden in a ProviderScope when the active
/// server changes. All server-dependent providers should depend on this instead
/// of specific server connections.
///
/// Usage:
/// ```dart
/// @Riverpod(dependencies: [serverScopeConnection])
/// Future<List<Entity>> myEntities(Ref ref) async {
///   final connection = await ref.watch(serverScopeConnectionProvider.future);
///   // Use connection to fetch data...
/// }
/// ```
///
/// Benefits:
/// - No manual invalidation needed when switching servers
/// - All dependent providers automatically update
/// - Clear dependency chain
/// - Type-safe server context
@Riverpod(dependencies: [])
IHAConnection serverScopeConnection(Ref ref) {
  throw UnimplementedError(
    'serverScopeConnection must be overridden in a ProviderScope',
  );
}

/// A scoped provider that represents the current server ID.
///
/// Like serverScopeConnection, this should be overridden in a ProviderScope
/// to provide the current server context.
@Riverpod(dependencies: [])
int serverScopeId(Ref ref) {
  throw UnimplementedError(
    'serverScopeId must be overridden in a ProviderScope',
  );
}

/// A scoped provider that represents the current server object.
///
/// This provides access to the full server configuration in the current scope.
@Riverpod(dependencies: [])
Server serverScopeServer(Ref ref) {
  throw UnimplementedError(
    'serverScopeServer must be overridden in a ProviderScope',
  );
}
