// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'areas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$areasRepositoryHash() => r'18c599a132f229951377d8810fad9e25a4554179';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AreasRepositoryRef = AutoDisposeFutureProviderRef<AreasRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
