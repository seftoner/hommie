// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'areas_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(AreasController)
const areasControllerProvider = AreasControllerProvider._();

final class AreasControllerProvider
    extends $AsyncNotifierProvider<AreasController, List<AreaEntity>> {
  const AreasControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'areasControllerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[serverScopeConnectionProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          AreasControllerProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = serverScopeConnectionProvider;

  @override
  String debugGetCreateSourceHash() => _$areasControllerHash();

  @$internal
  @override
  AreasController create() => AreasController();
}

String _$areasControllerHash() => r'26edd4182e73efdfd63e5decd65232433fd49d09';

abstract class _$AreasController extends $AsyncNotifier<List<AreaEntity>> {
  FutureOr<List<AreaEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<AreaEntity>>, List<AreaEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AreaEntity>>, List<AreaEntity>>,
              AsyncValue<List<AreaEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
