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
    extends $AsyncNotifierProvider<HomePageController, HomePageState> {
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
          homeViewRepositoryProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          HomePageControllerProvider.$allTransitiveDependencies0,
          HomePageControllerProvider.$allTransitiveDependencies1,
          HomePageControllerProvider.$allTransitiveDependencies2,
          HomePageControllerProvider.$allTransitiveDependencies3,
        },
      );

  static const $allTransitiveDependencies0 = serverScopeServerProvider;
  static const $allTransitiveDependencies1 = cachedAreasProvider;
  static const $allTransitiveDependencies2 =
      CachedAreasProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies3 = homeViewRepositoryProvider;

  @override
  String debugGetCreateSourceHash() => _$homePageControllerHash();

  @$internal
  @override
  HomePageController create() => HomePageController();
}

String _$homePageControllerHash() =>
    r'6e6c1b4327309e2b4735e4a0e1e7c5d9b42cf237';

abstract class _$HomePageController extends $AsyncNotifier<HomePageState> {
  FutureOr<HomePageState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<HomePageState>, HomePageState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HomePageState>, HomePageState>,
              AsyncValue<HomePageState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
