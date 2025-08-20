// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_auth_navigation_coordinator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serverAuthNavigationCoordinatorHash() =>
    r'53d806fa472f5cee6463e37694f62ae2195113f1';

/// See also [ServerAuthNavigationCoordinator].
@ProviderFor(ServerAuthNavigationCoordinator)
final serverAuthNavigationCoordinatorProvider =
    AsyncNotifierProvider<ServerAuthNavigationCoordinator, void>.internal(
  ServerAuthNavigationCoordinator.new,
  name: r'serverAuthNavigationCoordinatorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$serverAuthNavigationCoordinatorHash,
  dependencies: <ProviderOrFamily>[
    activeServerProvider,
    serverAuthControllerProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    activeServerProvider,
    ...?activeServerProvider.allTransitiveDependencies,
    serverAuthControllerProvider,
    ...?serverAuthControllerProvider.allTransitiveDependencies
  },
);

typedef _$ServerAuthNavigationCoordinator = AsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
