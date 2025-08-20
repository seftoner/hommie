// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeDataControllerHash() =>
    r'fd396eedbb2c6d3b475a6829c0d34a9b059294c7';

/// Example controller that demonstrates server-specific data.
///
/// This controller automatically refreshes when the active server changes thanks to
/// the ProviderScope approach. No manual invalidation needed!
///
/// To add new server-dependent providers:
/// 1. Depend on serverScopeConnectionProvider and/or serverScopeIdProvider
/// 2. Add the dependencies annotation: @Riverpod(dependencies: [serverScopeConnection, serverScopeId])
/// 3. That's it! The provider will automatically update when servers switch
///
/// Copied from [HomeDataController].
@ProviderFor(HomeDataController)
final homeDataControllerProvider = AutoDisposeAsyncNotifierProvider<
    HomeDataController, Map<String, dynamic>>.internal(
  HomeDataController.new,
  name: r'homeDataControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeDataControllerHash,
  dependencies: <ProviderOrFamily>[
    serverScopeConnectionProvider,
    serverScopeIdProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    serverScopeConnectionProvider,
    ...?serverScopeConnectionProvider.allTransitiveDependencies,
    serverScopeIdProvider,
    ...?serverScopeIdProvider.allTransitiveDependencies
  },
);

typedef _$HomeDataController = AutoDisposeAsyncNotifier<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
