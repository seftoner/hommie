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
        dependencies: const <ProviderOrFamily>[activeServerSessionProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          EntityServiceControllerProvider.$allTransitiveDependencies0,
          EntityServiceControllerProvider.$allTransitiveDependencies1,
          EntityServiceControllerProvider.$allTransitiveDependencies2,
          EntityServiceControllerProvider.$allTransitiveDependencies3,
          EntityServiceControllerProvider.$allTransitiveDependencies4,
          EntityServiceControllerProvider.$allTransitiveDependencies5,
        },
      );

  static const $allTransitiveDependencies0 = activeServerSessionProvider;
  static const $allTransitiveDependencies1 =
      ActiveServerSessionProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      ActiveServerSessionProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      ActiveServerSessionProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      ActiveServerSessionProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 =
      ActiveServerSessionProvider.$allTransitiveDependencies4;

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
    r'94503cdda73e26f84eb3bb99e2d0ceea51f283a2';
