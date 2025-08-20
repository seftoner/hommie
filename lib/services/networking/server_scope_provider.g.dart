// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_scope_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serverScopeConnectionHash() =>
    r'5a8152a145ce31e32d476c4f53c5d3ed4db02587';

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
///
/// Copied from [serverScopeConnection].
@ProviderFor(serverScopeConnection)
final serverScopeConnectionProvider =
    AutoDisposeFutureProvider<HAConnection>.internal(
  serverScopeConnection,
  name: r'serverScopeConnectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$serverScopeConnectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ServerScopeConnectionRef = AutoDisposeFutureProviderRef<HAConnection>;
String _$serverScopeIdHash() => r'b5b2ef1dd8cd73e0d4c66977996a0644acfe230f';

/// A scoped provider that represents the current server ID.
///
/// Like serverScopeConnection, this should be overridden in a ProviderScope
/// to provide the current server context.
///
/// Copied from [serverScopeId].
@ProviderFor(serverScopeId)
final serverScopeIdProvider = AutoDisposeProvider<int>.internal(
  serverScopeId,
  name: r'serverScopeIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$serverScopeIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ServerScopeIdRef = AutoDisposeProviderRef<int>;
String _$serverScopeServerHash() => r'88f844f2b472ef0853e902542c8f95ec6b44095b';

/// A scoped provider that represents the current server object.
///
/// This provides access to the full server configuration in the current scope.
///
/// Copied from [serverScopeServer].
@ProviderFor(serverScopeServer)
final serverScopeServerProvider = AutoDisposeFutureProvider<Server>.internal(
  serverScopeServer,
  name: r'serverScopeServerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$serverScopeServerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ServerScopeServerRef = AutoDisposeFutureProviderRef<Server>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
