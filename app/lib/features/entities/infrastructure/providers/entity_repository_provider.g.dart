// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(entityRepository)
const entityRepositoryProvider = EntityRepositoryProvider._();

final class EntityRepositoryProvider
    extends
        $FunctionalProvider<
          IEntityRepository,
          IEntityRepository,
          IEntityRepository
        >
    with $Provider<IEntityRepository> {
  const EntityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entityRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$entityRepositoryHash();

  @$internal
  @override
  $ProviderElement<IEntityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IEntityRepository create(Ref ref) {
    return entityRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IEntityRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IEntityRepository>(value),
    );
  }
}

String _$entityRepositoryHash() => r'bc4d6672d5617237b13304699b01eb18cb6ed778';
