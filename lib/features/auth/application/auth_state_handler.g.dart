// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authStateHandlerHash() => r'32a537de3e0c2ce54afdb770a2d701bf37f213a3';

/// See also [authStateHandler].
@ProviderFor(authStateHandler)
final authStateHandlerProvider = Provider<void>.internal(
  authStateHandler,
  name: r'authStateHandlerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateHandlerHash,
  dependencies: <ProviderOrFamily>[
    authControllerProvider,
    connectionStateProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    authControllerProvider,
    ...?authControllerProvider.allTransitiveDependencies,
    connectionStateProvider,
    ...?connectionStateProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateHandlerRef = ProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
