// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_server_connection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// Provides the WebSocket connection for the currently active server.
///
/// This provider automatically updates when the active server changes,
/// invalidating all dependent providers to ensure they reflect the new server's data.
@ProviderFor(currentServerConnection)
const currentServerConnectionProvider = CurrentServerConnectionProvider._();

/// Provides the WebSocket connection for the currently active server.
///
/// This provider automatically updates when the active server changes,
/// invalidating all dependent providers to ensure they reflect the new server's data.
final class CurrentServerConnectionProvider
    extends
        $FunctionalProvider<
          AsyncValue<HAConnection>,
          HAConnection,
          FutureOr<HAConnection>
        >
    with $FutureModifier<HAConnection>, $FutureProvider<HAConnection> {
  /// Provides the WebSocket connection for the currently active server.
  ///
  /// This provider automatically updates when the active server changes,
  /// invalidating all dependent providers to ensure they reflect the new server's data.
  const CurrentServerConnectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentServerConnectionProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          activeServerProvider,
          serverConnectionProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          CurrentServerConnectionProvider.$allTransitiveDependencies0,
          CurrentServerConnectionProvider.$allTransitiveDependencies1,
          CurrentServerConnectionProvider.$allTransitiveDependencies2,
          CurrentServerConnectionProvider.$allTransitiveDependencies3,
          CurrentServerConnectionProvider.$allTransitiveDependencies4,
          CurrentServerConnectionProvider.$allTransitiveDependencies5,
        },
      );

  static const $allTransitiveDependencies0 = activeServerProvider;
  static const $allTransitiveDependencies1 =
      ActiveServerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      ActiveServerProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 = serverConnectionProvider;
  static const $allTransitiveDependencies4 =
      ServerConnectionProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies5 =
      ServerConnectionProvider.$allTransitiveDependencies4;

  @override
  String debugGetCreateSourceHash() => _$currentServerConnectionHash();

  @$internal
  @override
  $FutureProviderElement<HAConnection> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HAConnection> create(Ref ref) {
    return currentServerConnection(ref);
  }
}

String _$currentServerConnectionHash() =>
    r'f0589beb444fce48e516a5a3d994cd99346fb4c5';

/// Provides the current active server ID.
///
/// This is a convenience provider that other providers can depend on
/// to get just the server ID without needing the full server object.
@ProviderFor(currentServerId)
const currentServerIdProvider = CurrentServerIdProvider._();

/// Provides the current active server ID.
///
/// This is a convenience provider that other providers can depend on
/// to get just the server ID without needing the full server object.
final class CurrentServerIdProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Provides the current active server ID.
  ///
  /// This is a convenience provider that other providers can depend on
  /// to get just the server ID without needing the full server object.
  const CurrentServerIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentServerIdProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[activeServerProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          CurrentServerIdProvider.$allTransitiveDependencies0,
          CurrentServerIdProvider.$allTransitiveDependencies1,
          CurrentServerIdProvider.$allTransitiveDependencies2,
        ],
      );

  static const $allTransitiveDependencies0 = activeServerProvider;
  static const $allTransitiveDependencies1 =
      ActiveServerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      ActiveServerProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$currentServerIdHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return currentServerId(ref);
  }
}

String _$currentServerIdHash() => r'9266b6c0b9f197c1100a47e856f630685a8c75a9';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
