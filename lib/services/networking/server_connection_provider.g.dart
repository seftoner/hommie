// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_connection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serverConnectionHash() => r'f012220bca42a34f39a5f98b64ce96247da013e1';

/// See also [ServerConnection].
@ProviderFor(ServerConnection)
final serverConnectionProvider =
    AsyncNotifierProvider<ServerConnection, HAConnection>.internal(
  ServerConnection.new,
  name: r'serverConnectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$serverConnectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ServerConnection = AsyncNotifier<HAConnection>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
