// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
        dependencies: const <ProviderOrFamily>[homeViewRepositoryProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          HomePageControllerProvider.$allTransitiveDependencies0,
          HomePageControllerProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = homeViewRepositoryProvider;
  static const $allTransitiveDependencies1 =
      HomeViewRepositoryProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$homePageControllerHash();

  @$internal
  @override
  HomePageController create() => HomePageController();
}

String _$homePageControllerHash() =>
    r'b9759dfcfe71e6d358acc4df5bff4e421695c408';

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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
