// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ha_servers_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(haServersRepository)
const haServersRepositoryProvider = HaServersRepositoryProvider._();

final class HaServersRepositoryProvider
    extends
        $FunctionalProvider<
          CachedHAServersRepository,
          CachedHAServersRepository,
          CachedHAServersRepository
        >
    with $Provider<CachedHAServersRepository> {
  const HaServersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'haServersRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$haServersRepositoryHash();

  @$internal
  @override
  $ProviderElement<CachedHAServersRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CachedHAServersRepository create(Ref ref) {
    return haServersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CachedHAServersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CachedHAServersRepository>(value),
    );
  }
}

String _$haServersRepositoryHash() =>
    r'bcb2be0dbfbc634a32b1943500a6ec85be7e25b7';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
