// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_service_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(entityServiceController)
const entityServiceControllerProvider = EntityServiceControllerProvider._();

final class EntityServiceControllerProvider
    extends
        $FunctionalProvider<
          EntityServiceController,
          EntityServiceController,
          EntityServiceController
        >
    with $Provider<EntityServiceController> {
  const EntityServiceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entityServiceControllerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[serverScopeConnectionProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          EntityServiceControllerProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = serverScopeConnectionProvider;

  @override
  String debugGetCreateSourceHash() => _$entityServiceControllerHash();

  @$internal
  @override
  $ProviderElement<EntityServiceController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EntityServiceController create(Ref ref) {
    return entityServiceController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EntityServiceController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EntityServiceController>(value),
    );
  }
}

String _$entityServiceControllerHash() =>
    r'6c83e2ab59c84fb2c898fa01122419e4ea195257';
