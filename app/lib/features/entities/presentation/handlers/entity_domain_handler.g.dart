// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_domain_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Registry of domain handlers keyed by domain. v1 registers only `light`.

@ProviderFor(entityDomainHandlers)
const entityDomainHandlersProvider = EntityDomainHandlersProvider._();

/// Registry of domain handlers keyed by domain. v1 registers only `light`.

final class EntityDomainHandlersProvider
    extends
        $FunctionalProvider<
          Map<String, EntityDomainHandler>,
          Map<String, EntityDomainHandler>,
          Map<String, EntityDomainHandler>
        >
    with $Provider<Map<String, EntityDomainHandler>> {
  /// Registry of domain handlers keyed by domain. v1 registers only `light`.
  const EntityDomainHandlersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entityDomainHandlersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$entityDomainHandlersHash();

  @$internal
  @override
  $ProviderElement<Map<String, EntityDomainHandler>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, EntityDomainHandler> create(Ref ref) {
    return entityDomainHandlers(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, EntityDomainHandler> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, EntityDomainHandler>>(
        value,
      ),
    );
  }
}

String _$entityDomainHandlersHash() =>
    r'fc9ba227b431db05521af365411de8a466ac23cc';
