// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registry_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(registryRepository)
const registryRepositoryProvider = RegistryRepositoryProvider._();

final class RegistryRepositoryProvider
    extends
        $FunctionalProvider<
          HaRegistryRepository,
          HaRegistryRepository,
          HaRegistryRepository
        >
    with $Provider<HaRegistryRepository> {
  const RegistryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registryRepositoryProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[serverScopeConnectionProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          RegistryRepositoryProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = serverScopeConnectionProvider;

  @override
  String debugGetCreateSourceHash() => _$registryRepositoryHash();

  @$internal
  @override
  $ProviderElement<HaRegistryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HaRegistryRepository create(Ref ref) {
    return registryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HaRegistryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HaRegistryRepository>(value),
    );
  }
}

String _$registryRepositoryHash() =>
    r'36ec33dfa32c734a27a6ebb8642640b5f776e384';
