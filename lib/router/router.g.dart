// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(goRouter)
const goRouterProvider = GoRouterProvider._();

final class GoRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  const GoRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goRouterProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          bootStatusControllerProvider,
          activeServerProvider,
          serverAuthControllerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          GoRouterProvider.$allTransitiveDependencies0,
          GoRouterProvider.$allTransitiveDependencies1,
          GoRouterProvider.$allTransitiveDependencies2,
          GoRouterProvider.$allTransitiveDependencies3,
          GoRouterProvider.$allTransitiveDependencies4,
          GoRouterProvider.$allTransitiveDependencies5,
          GoRouterProvider.$allTransitiveDependencies6,
          GoRouterProvider.$allTransitiveDependencies7,
          GoRouterProvider.$allTransitiveDependencies8,
        },
      );

  static const $allTransitiveDependencies0 = bootStatusControllerProvider;
  static const $allTransitiveDependencies1 =
      BootStatusControllerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      BootStatusControllerProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 = serverAuthControllerProvider;
  static const $allTransitiveDependencies4 =
      ServerAuthControllerProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies5 =
      ServerAuthControllerProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies6 =
      ServerAuthControllerProvider.$allTransitiveDependencies4;
  static const $allTransitiveDependencies7 =
      ServerAuthControllerProvider.$allTransitiveDependencies5;
  static const $allTransitiveDependencies8 =
      ServerAuthControllerProvider.$allTransitiveDependencies6;

  @override
  String debugGetCreateSourceHash() => _$goRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return goRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$goRouterHash() => r'061fd3b7ba067f83253e55d9693bc66d0c54fb6a';
