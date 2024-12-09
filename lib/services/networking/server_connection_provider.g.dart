// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_connection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serverConnectionHash() => r'db64f35df3e1b96befebc4ff212fdb7d68235366';

/// See also [serverConnection].
@ProviderFor(serverConnection)
final serverConnectionProvider = FutureProvider<HAConnection>.internal(
  serverConnection,
  name: r'serverConnectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$serverConnectionHash,
  dependencies: <ProviderOrFamily>[authRepositoryProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    authRepositoryProvider,
    ...?authRepositoryProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ServerConnectionRef = FutureProviderRef<HAConnection>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
