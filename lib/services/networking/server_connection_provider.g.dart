// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_connection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serverConnectionHash() => r'38bf73f5d1451debf5374246b2c23b221f8c0d79';

/// See also [serverConnection].
@ProviderFor(serverConnection)
final serverConnectionProvider = FutureProvider<HAConnection>.internal(
  serverConnection,
  name: r'serverConnectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$serverConnectionHash,
  dependencies: <ProviderOrFamily>[serverConnectionManagerProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    serverConnectionManagerProvider,
    ...?serverConnectionManagerProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ServerConnectionRef = FutureProviderRef<HAConnection>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
