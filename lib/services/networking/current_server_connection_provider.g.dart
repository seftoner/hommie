// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_server_connection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentServerConnectionHash() =>
    r'726380748416646c715f7449060b3aa7fb2be174';

/// Provides the WebSocket connection for the currently active server.
///
/// This provider automatically updates when the active server changes,
/// invalidating all dependent providers to ensure they reflect the new server's data.
///
/// Copied from [currentServerConnection].
@ProviderFor(currentServerConnection)
final currentServerConnectionProvider = FutureProvider<HAConnection>.internal(
  currentServerConnection,
  name: r'currentServerConnectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentServerConnectionHash,
  dependencies: <ProviderOrFamily>[activeServerProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    activeServerProvider,
    ...?activeServerProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentServerConnectionRef = FutureProviderRef<HAConnection>;
String _$currentServerIdHash() => r'9266b6c0b9f197c1100a47e856f630685a8c75a9';

/// Provides the current active server ID.
///
/// This is a convenience provider that other providers can depend on
/// to get just the server ID without needing the full server object.
///
/// Copied from [currentServerId].
@ProviderFor(currentServerId)
final currentServerIdProvider = FutureProvider<int>.internal(
  currentServerId,
  name: r'currentServerIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentServerIdHash,
  dependencies: <ProviderOrFamily>[activeServerProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    activeServerProvider,
    ...?activeServerProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentServerIdRef = FutureProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
