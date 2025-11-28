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
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homePageControllerHash();

  @$internal
  @override
  HomePageController create() => HomePageController();
}

String _$homePageControllerHash() =>
    r'bbdf9eac152a8bae85fd5a6c3c4c9020514ae769';

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
