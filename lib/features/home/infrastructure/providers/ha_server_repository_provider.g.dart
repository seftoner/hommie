// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ha_server_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(haServerRepository)
const haServerRepositoryProvider = HaServerRepositoryProvider._();

final class HaServerRepositoryProvider
    extends
        $FunctionalProvider<
          IServerEntityRepository,
          IServerEntityRepository,
          IServerEntityRepository
        >
    with $Provider<IServerEntityRepository> {
  const HaServerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'haServerRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$haServerRepositoryHash();

  @$internal
  @override
  $ProviderElement<IServerEntityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IServerEntityRepository create(Ref ref) {
    return haServerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IServerEntityRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IServerEntityRepository>(value),
    );
  }
}

String _$haServerRepositoryHash() =>
    r'c34210338403f4380332ca072b36f138ac2961e5';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
