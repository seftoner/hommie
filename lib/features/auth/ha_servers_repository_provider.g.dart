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
          IHAServersRepository,
          IHAServersRepository,
          IHAServersRepository
        >
    with $Provider<IHAServersRepository> {
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
  $ProviderElement<IHAServersRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IHAServersRepository create(Ref ref) {
    return haServersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IHAServersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IHAServersRepository>(value),
    );
  }
}

String _$haServersRepositoryHash() =>
    r'815002ea66628d8e41de2709cf8bee820c7b00cb';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
