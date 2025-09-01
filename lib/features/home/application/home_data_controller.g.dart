// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// Example controller that demonstrates server-specific data.
///
/// This controller automatically refreshes when the active server changes thanks to
/// the ProviderScope approach. No manual invalidation needed!
///
/// To add new server-dependent providers:
/// 1. Depend on serverScopeConnectionProvider and/or serverScopeIdProvider
/// 2. Add the dependencies annotation: @Riverpod(dependencies: [serverScopeConnection, serverScopeId])
/// 3. That's it! The provider will automatically update when servers switch
@ProviderFor(HomeDataController)
const homeDataControllerProvider = HomeDataControllerProvider._();

/// Example controller that demonstrates server-specific data.
///
/// This controller automatically refreshes when the active server changes thanks to
/// the ProviderScope approach. No manual invalidation needed!
///
/// To add new server-dependent providers:
/// 1. Depend on serverScopeConnectionProvider and/or serverScopeIdProvider
/// 2. Add the dependencies annotation: @Riverpod(dependencies: [serverScopeConnection, serverScopeId])
/// 3. That's it! The provider will automatically update when servers switch
final class HomeDataControllerProvider
    extends $AsyncNotifierProvider<HomeDataController, Map<String, dynamic>> {
  /// Example controller that demonstrates server-specific data.
  ///
  /// This controller automatically refreshes when the active server changes thanks to
  /// the ProviderScope approach. No manual invalidation needed!
  ///
  /// To add new server-dependent providers:
  /// 1. Depend on serverScopeConnectionProvider and/or serverScopeIdProvider
  /// 2. Add the dependencies annotation: @Riverpod(dependencies: [serverScopeConnection, serverScopeId])
  /// 3. That's it! The provider will automatically update when servers switch
  const HomeDataControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeDataControllerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          serverScopeConnectionProvider,
          serverScopeIdProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          HomeDataControllerProvider.$allTransitiveDependencies0,
          HomeDataControllerProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = serverScopeConnectionProvider;
  static const $allTransitiveDependencies1 = serverScopeIdProvider;

  @override
  String debugGetCreateSourceHash() => _$homeDataControllerHash();

  @$internal
  @override
  HomeDataController create() => HomeDataController();
}

String _$homeDataControllerHash() =>
    r'fd396eedbb2c6d3b475a6829c0d34a9b059294c7';

abstract class _$HomeDataController
    extends $AsyncNotifier<Map<String, dynamic>> {
  FutureOr<Map<String, dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<Map<String, dynamic>>, Map<String, dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, dynamic>>,
                Map<String, dynamic>
              >,
              AsyncValue<Map<String, dynamic>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
