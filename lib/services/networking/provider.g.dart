// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hAServerConnectionHash() =>
    r'383dd44d1c2d8cd8a2575c49b6e7761190454de8';

/// See also [HAServerConnection].
@ProviderFor(HAServerConnection)
final hAServerConnectionProvider =
    AutoDisposeFutureProvider<HAConnection>.internal(
  HAServerConnection,
  name: r'hAServerConnectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hAServerConnectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HAServerConnectionRef = AutoDisposeFutureProviderRef<HAConnection>;
String _$haProviderHash() => r'9f9ca4d7dd7189468503127856dcb2eac0e3e549';

/// See also [haProvider].
@ProviderFor(haProvider)
final haProviderProvider = AutoDisposeProvider<HAConnection>.internal(
  haProvider,
  name: r'haProviderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$haProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HaProviderRef = AutoDisposeProviderRef<HAConnection>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
