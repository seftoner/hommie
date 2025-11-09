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
          activeAuthStateProvider,
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
        },
      );

  static const $allTransitiveDependencies0 = bootStatusControllerProvider;
  static const $allTransitiveDependencies1 =
      BootStatusControllerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      BootStatusControllerProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 = activeAuthStateProvider;
  static const $allTransitiveDependencies4 =
      ActiveAuthStateProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies5 =
      ActiveAuthStateProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies6 =
      ActiveAuthStateProvider.$allTransitiveDependencies4;
  static const $allTransitiveDependencies7 =
      ActiveAuthStateProvider.$allTransitiveDependencies5;

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

String _$goRouterHash() => r'3786113eed96e65748ccdf9871b4f6908ac1abf3';
