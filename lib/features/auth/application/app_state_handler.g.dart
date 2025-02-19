// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appStateHandlerHash() => r'b4fc81974b393cbb6e5719c256446b2586920521';

/// See also [AppStateHandler].
@ProviderFor(AppStateHandler)
final appStateHandlerProvider =
    AsyncNotifierProvider<AppStateHandler, void>.internal(
  AppStateHandler.new,
  name: r'appStateHandlerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appStateHandlerHash,
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

typedef _$AppStateHandler = AsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
