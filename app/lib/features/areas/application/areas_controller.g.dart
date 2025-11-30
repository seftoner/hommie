// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'areas_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$areasControllerHash() => r'2205a7c4a7d648c7fb2982bd5fe6d64d7ccd69a4';

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
