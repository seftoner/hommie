// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'areas_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$areasControllerHash() => r'1e6456331ecd7e6c4f696c3157ebb726ba4afdb4';

/// See also [AreasController].
@ProviderFor(AreasController)
final areasControllerProvider = AutoDisposeAsyncNotifierProvider<
    AreasController, List<AreaEntity>>.internal(
  AreasController.new,
  name: r'areasControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$areasControllerHash,
  dependencies: <ProviderOrFamily>[areasRepositoryProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    areasRepositoryProvider,
    ...?areasRepositoryProvider.allTransitiveDependencies
  },
);

typedef _$AreasController = AutoDisposeAsyncNotifier<List<AreaEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
