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
          homeViewRepositoryProvider,
          areasRepositoryProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          HomePageControllerProvider.$allTransitiveDependencies0,
          HomePageControllerProvider.$allTransitiveDependencies1,
          HomePageControllerProvider.$allTransitiveDependencies2,
          HomePageControllerProvider.$allTransitiveDependencies3,
        },
      );

  static const $allTransitiveDependencies0 = serverScopeServerProvider;
  static const $allTransitiveDependencies1 = homeViewRepositoryProvider;
  static const $allTransitiveDependencies2 = areasRepositoryProvider;
  static const $allTransitiveDependencies3 =
      AreasRepositoryProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$homePageControllerHash();

  @$internal
  @override
  HomePageController create() => HomePageController();
}

String _$homePageControllerHash() =>
    r'cf020488b4e5eaf26f55761d21ecc3cf677f4dc4';

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
