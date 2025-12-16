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
          homeViewRepositoryProvider,
          serverScopeServerProvider,
          areasForHomeProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          HomePageControllerProvider.$allTransitiveDependencies0,
          HomePageControllerProvider.$allTransitiveDependencies1,
          HomePageControllerProvider.$allTransitiveDependencies2,
          HomePageControllerProvider.$allTransitiveDependencies3,
          HomePageControllerProvider.$allTransitiveDependencies4,
        },
      );

  static const $allTransitiveDependencies0 = homeViewRepositoryProvider;
  static const $allTransitiveDependencies1 =
      HomeViewRepositoryProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = areasForHomeProvider;
  static const $allTransitiveDependencies3 =
      AreasForHomeProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies4 =
      AreasForHomeProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$homePageControllerHash();

  @$internal
  @override
  HomePageController create() => HomePageController();
}

String _$homePageControllerHash() =>
    r'f0e14c7e608c56df778d32dfdf0c79d78d6342c9';

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
