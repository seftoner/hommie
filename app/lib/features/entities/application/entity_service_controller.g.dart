// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_service_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(entityServiceController)
final entityServiceControllerProvider = EntityServiceControllerProvider._();

final class EntityServiceControllerProvider
    extends
        $FunctionalProvider<
          EntityServiceController,
          EntityServiceController,
          EntityServiceController
        >
    with $Provider<EntityServiceController> {
  EntityServiceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entityServiceControllerProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[serverScopeConnectionProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          EntityServiceControllerProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = serverScopeConnectionProvider;

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
    r'61d33b3c013b0ab1b00b7d8658e22e937bc84091';
