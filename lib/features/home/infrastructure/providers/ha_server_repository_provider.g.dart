// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ha_server_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
    r'64cb2eae2d7440428b430c8b1a5a91bfefbce933';
