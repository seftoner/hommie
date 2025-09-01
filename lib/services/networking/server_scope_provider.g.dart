// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_scope_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
@ProviderFor(serverScopeConnection)
const serverScopeConnectionProvider = ServerScopeConnectionProvider._();

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
final class ServerScopeConnectionProvider
    extends
        $FunctionalProvider<
          AsyncValue<HAConnection>,
          HAConnection,
          FutureOr<HAConnection>
        >
    with $FutureModifier<HAConnection>, $FutureProvider<HAConnection> {
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
  const ServerScopeConnectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverScopeConnectionProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[],
        $allTransitiveDependencies: const <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$serverScopeConnectionHash();

  @$internal
  @override
  $FutureProviderElement<HAConnection> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HAConnection> create(Ref ref) {
    return serverScopeConnection(ref);
  }
}

String _$serverScopeConnectionHash() =>
    r'a52289ea974f47ad49442c1e7938f005aa98f42d';

/// A scoped provider that represents the current server ID.
///
/// Like serverScopeConnection, this should be overridden in a ProviderScope
/// to provide the current server context.
@ProviderFor(serverScopeId)
const serverScopeIdProvider = ServerScopeIdProvider._();

/// A scoped provider that represents the current server ID.
///
/// Like serverScopeConnection, this should be overridden in a ProviderScope
/// to provide the current server context.
final class ServerScopeIdProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// A scoped provider that represents the current server ID.
  ///
  /// Like serverScopeConnection, this should be overridden in a ProviderScope
  /// to provide the current server context.
  const ServerScopeIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverScopeIdProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[],
        $allTransitiveDependencies: const <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$serverScopeIdHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return serverScopeId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$serverScopeIdHash() => r'1ec1108c0391b713f03b9131cb7fba1c11fba9b9';

/// A scoped provider that represents the current server object.
///
/// This provides access to the full server configuration in the current scope.
@ProviderFor(serverScopeServer)
const serverScopeServerProvider = ServerScopeServerProvider._();

/// A scoped provider that represents the current server object.
///
/// This provides access to the full server configuration in the current scope.
final class ServerScopeServerProvider
    extends $FunctionalProvider<AsyncValue<Server>, Server, FutureOr<Server>>
    with $FutureModifier<Server>, $FutureProvider<Server> {
  /// A scoped provider that represents the current server object.
  ///
  /// This provides access to the full server configuration in the current scope.
  const ServerScopeServerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverScopeServerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[],
        $allTransitiveDependencies: const <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$serverScopeServerHash();

  @$internal
  @override
  $FutureProviderElement<Server> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Server> create(Ref ref) {
    return serverScopeServer(ref);
  }
}

String _$serverScopeServerHash() => r'2626685f73e10e324f972ce4a35fa06a92d71a48';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
