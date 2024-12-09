// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$connectionStateHash() => r'1d73411dfe737466719c9a623496b4fe2a5df812';

/// A Riverpod provider that manages the network connection state of the application.
///
/// This provider keeps track of the current network connectivity status and
/// provides methods to update the connection state. It is marked as keepAlive
/// to ensure the state persists across widget rebuilds.
///
/// Copied from [ConnectionState].
@ProviderFor(ConnectionState)
final connectionStateProvider =
    NotifierProvider<ConnectionState, NetworkConnectionState>.internal(
  ConnectionState.new,
  name: r'connectionStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$connectionStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ConnectionState = Notifier<NetworkConnectionState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package