// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomePageController)
const homePageControllerProvider = HomePageControllerProvider._();

final class HomePageControllerProvider
    extends $NotifierProvider<HomePageController, HomePageState> {
  const HomePageControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homePageControllerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          serverScopeServerProvider,
          cachedAreasProvider,
          cachedEntitiesProvider,
          areaRegistrySyncControllerProvider,
          entityRegistrySyncControllerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          HomePageControllerProvider.$allTransitiveDependencies0,
          HomePageControllerProvider.$allTransitiveDependencies1,
          HomePageControllerProvider.$allTransitiveDependencies2,
          HomePageControllerProvider.$allTransitiveDependencies3,
          HomePageControllerProvider.$allTransitiveDependencies4,
          HomePageControllerProvider.$allTransitiveDependencies5,
          HomePageControllerProvider.$allTransitiveDependencies6,
          HomePageControllerProvider.$allTransitiveDependencies7,
          HomePageControllerProvider.$allTransitiveDependencies8,
          HomePageControllerProvider.$allTransitiveDependencies9,
        },
      );

  static const $allTransitiveDependencies0 = serverScopeServerProvider;
  static const $allTransitiveDependencies1 = cachedAreasProvider;
  static const $allTransitiveDependencies2 =
      CachedAreasProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies3 = cachedEntitiesProvider;
  static const $allTransitiveDependencies4 = areaRegistrySyncControllerProvider;
  static const $allTransitiveDependencies5 =
      AreaRegistrySyncControllerProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies6 =
      AreaRegistrySyncControllerProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies7 =
      entityRegistrySyncControllerProvider;
  static const $allTransitiveDependencies8 =
      EntityRegistrySyncControllerProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies9 =
      EntityRegistrySyncControllerProvider.$allTransitiveDependencies3;

  @override
  String debugGetCreateSourceHash() => _$homePageControllerHash();

  @$internal
  @override
  HomePageController create() => HomePageController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomePageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomePageState>(value),
    );
  }
}

String _$homePageControllerHash() =>
    r'38af56a2f2df015b6cf31e7f90d495b99d49ab3e';

abstract class _$HomePageController extends $Notifier<HomePageState> {
  HomePageState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<HomePageState, HomePageState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HomePageState, HomePageState>,
              HomePageState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
