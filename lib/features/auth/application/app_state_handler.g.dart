// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appStateHandlerHash() => r'a6dc22aa6efd3b1be479f7ac3df252df469f3cab';

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
