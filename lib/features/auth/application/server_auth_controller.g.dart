// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serverAuthControllerHash() =>
    r'70bf664225ccd19bcee938fbf41e43a06c212098';

/// See also [ServerAuthController].
@ProviderFor(ServerAuthController)
final serverAuthControllerProvider =
    AsyncNotifierProvider<ServerAuthController, AuthState>.internal(
  ServerAuthController.new,
  name: r'serverAuthControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$serverAuthControllerHash,
  dependencies: <ProviderOrFamily>[activeServerProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    activeServerProvider,
    ...?activeServerProvider.allTransitiveDependencies
  },
);

typedef _$ServerAuthController = AsyncNotifier<AuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
