// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_server_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$exampleEntitiesHash() => r'0ac90308fb5740ba7f90fe75ad32c19656a63fc1';

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
///
/// Copied from [exampleEntities].
@ProviderFor(exampleEntities)
final exampleEntitiesProvider =
    AutoDisposeFutureProvider<List<String>>.internal(
  exampleEntities,
  name: r'exampleEntitiesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$exampleEntitiesHash,
  dependencies: <ProviderOrFamily>[
    serverScopeConnectionProvider,
    serverScopeIdProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    serverScopeConnectionProvider,
    ...?serverScopeConnectionProvider.allTransitiveDependencies,
    serverScopeIdProvider,
    ...?serverScopeIdProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExampleEntitiesRef = AutoDisposeFutureProviderRef<List<String>>;
String _$exampleServerInfoHash() => r'4a835cc548b704421e24627916b75710a60ae49b';

/// See also [exampleServerInfo].
@ProviderFor(exampleServerInfo)
final exampleServerInfoProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
  exampleServerInfo,
  name: r'exampleServerInfoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$exampleServerInfoHash,
  dependencies: <ProviderOrFamily>[
    serverScopeServerProvider,
    serverScopeIdProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    serverScopeServerProvider,
    ...?serverScopeServerProvider.allTransitiveDependencies,
    serverScopeIdProvider,
    ...?serverScopeIdProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExampleServerInfoRef
    = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$exampleServerStatusHash() =>
    r'baf5fd0b27192e69baf62f2a203e03c55dab8c4a';

/// See also [exampleServerStatus].
@ProviderFor(exampleServerStatus)
final exampleServerStatusProvider = AutoDisposeFutureProvider<String>.internal(
  exampleServerStatus,
  name: r'exampleServerStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$exampleServerStatusHash,
  dependencies: <ProviderOrFamily>[serverScopeConnectionProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    serverScopeConnectionProvider,
    ...?serverScopeConnectionProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExampleServerStatusRef = AutoDisposeFutureProviderRef<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
