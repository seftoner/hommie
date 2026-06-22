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
          activeServerSessionProvider,
          serverSyncCoordinatorProvider,
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
          HomePageControllerProvider.$allTransitiveDependencies10,
          HomePageControllerProvider.$allTransitiveDependencies11,
          HomePageControllerProvider.$allTransitiveDependencies12,
          HomePageControllerProvider.$allTransitiveDependencies13,
          HomePageControllerProvider.$allTransitiveDependencies14,
        },
      );

  static const $allTransitiveDependencies0 = serverScopeServerProvider;
  static const $allTransitiveDependencies1 = cachedAreasProvider;
  static const $allTransitiveDependencies2 =
      CachedAreasProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies3 = cachedEntitiesProvider;
  static const $allTransitiveDependencies4 = activeServerSessionProvider;
  static const $allTransitiveDependencies5 =
      ActiveServerSessionProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies6 =
      ActiveServerSessionProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies7 =
      ActiveServerSessionProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies8 =
      ActiveServerSessionProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies9 =
      ActiveServerSessionProvider.$allTransitiveDependencies4;
  static const $allTransitiveDependencies10 =
      ActiveServerSessionProvider.$allTransitiveDependencies5;
  static const $allTransitiveDependencies11 =
      ActiveServerSessionProvider.$allTransitiveDependencies6;
  static const $allTransitiveDependencies12 = serverSyncCoordinatorProvider;
  static const $allTransitiveDependencies13 =
      ServerSyncCoordinatorProvider.$allTransitiveDependencies8;
  static const $allTransitiveDependencies14 =
      ServerSyncCoordinatorProvider.$allTransitiveDependencies9;

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
    r'a2fb0a15e6b9a1860d8e9c6a3df8cf17a4c8881c';

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
