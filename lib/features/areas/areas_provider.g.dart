// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'areas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$areasRepositoryHash() => r'7aca441e9a68a5cc003b3c813c071fa65a31da02';

/// See also [areasRepository].
@ProviderFor(areasRepository)
final areasRepositoryProvider =
    AutoDisposeFutureProvider<AreasRepository>.internal(
  areasRepository,
  name: r'areasRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$areasRepositoryHash,
  dependencies: <ProviderOrFamily>[serverConnectionProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    serverConnectionProvider,
    ...?serverConnectionProvider.allTransitiveDependencies
  },
);

typedef AreasRepositoryRef = AutoDisposeFutureProviderRef<AreasRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
