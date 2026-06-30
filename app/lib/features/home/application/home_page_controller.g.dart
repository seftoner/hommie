// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomePageController)
final homePageControllerProvider = HomePageControllerProvider._();

final class HomePageControllerProvider
    extends $NotifierProvider<HomePageController, HomePageState> {
  HomePageControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homePageControllerProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[
          serverScopeServerProvider,
          cachedAreasProvider,
          cachedEntitiesProvider,
          cachedDevicesProvider,
          homeTileOverridesProvider,
          homeConnectionLoadingProvider,
          serverSyncCoordinatorProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
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
          HomePageControllerProvider.$allTransitiveDependencies15,
          HomePageControllerProvider.$allTransitiveDependencies16,
          HomePageControllerProvider.$allTransitiveDependencies17,
        },
      );

  static final $allTransitiveDependencies0 = serverScopeServerProvider;
  static final $allTransitiveDependencies1 = cachedAreasProvider;
  static final $allTransitiveDependencies2 =
      CachedAreasProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies3 =
      CachedAreasProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies4 =
      CachedAreasProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies5 = cachedEntitiesProvider;
  static final $allTransitiveDependencies6 = cachedDevicesProvider;
  static final $allTransitiveDependencies7 = homeTileOverridesProvider;
  static final $allTransitiveDependencies8 = homeConnectionLoadingProvider;
  static final $allTransitiveDependencies9 =
      HomeConnectionLoadingProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies10 =
      HomeConnectionLoadingProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies11 =
      HomeConnectionLoadingProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies12 =
      HomeConnectionLoadingProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies13 =
      HomeConnectionLoadingProvider.$allTransitiveDependencies4;
  static final $allTransitiveDependencies14 = serverSyncCoordinatorProvider;
  static final $allTransitiveDependencies15 =
      ServerSyncCoordinatorProvider.$allTransitiveDependencies6;
  static final $allTransitiveDependencies16 =
      ServerSyncCoordinatorProvider.$allTransitiveDependencies7;
  static final $allTransitiveDependencies17 =
      ServerSyncCoordinatorProvider.$allTransitiveDependencies8;

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
    r'62ede5295849dcc806899231a34fefb0a7783c05';

abstract class _$HomePageController extends $Notifier<HomePageState> {
  HomePageState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<HomePageState, HomePageState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HomePageState, HomePageState>,
              HomePageState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
