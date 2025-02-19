// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_connection_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serverConnectionManagerHash() =>
    r'210dd2f9d444fb3b1cb704f7a6917d3441fe0440';

/// See also [ServerConnectionManager].
@ProviderFor(ServerConnectionManager)
final serverConnectionManagerProvider =
    NotifierProvider<ServerConnectionManager, void>.internal(
  ServerConnectionManager.new,
  name: r'serverConnectionManagerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$serverConnectionManagerHash,
  dependencies: <ProviderOrFamily>[connectionStateProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    connectionStateProvider,
    ...?connectionStateProvider.allTransitiveDependencies
  },
);

typedef _$ServerConnectionManager = Notifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
