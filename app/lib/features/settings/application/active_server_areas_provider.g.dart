// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_server_areas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activeServerAreas)
const activeServerAreasProvider = ActiveServerAreasProvider._();

final class ActiveServerAreasProvider
    extends
        $FunctionalProvider<
          AsyncValue<ActiveServerAreasState>,
          ActiveServerAreasState,
          FutureOr<ActiveServerAreasState>
        >
    with
        $FutureModifier<ActiveServerAreasState>,
        $FutureProvider<ActiveServerAreasState> {
  const ActiveServerAreasProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeServerAreasProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          activeServerSessionProvider,
          areasForServerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ActiveServerAreasProvider.$allTransitiveDependencies0,
          ActiveServerAreasProvider.$allTransitiveDependencies1,
          ActiveServerAreasProvider.$allTransitiveDependencies2,
          ActiveServerAreasProvider.$allTransitiveDependencies3,
          ActiveServerAreasProvider.$allTransitiveDependencies4,
          ActiveServerAreasProvider.$allTransitiveDependencies5,
          ActiveServerAreasProvider.$allTransitiveDependencies6,
        },
      );

  static const $allTransitiveDependencies0 = activeServerSessionProvider;
  static const $allTransitiveDependencies1 =
      ActiveServerSessionProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      ActiveServerSessionProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      ActiveServerSessionProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      ActiveServerSessionProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 = areasForServerProvider;
  static const $allTransitiveDependencies6 =
      AreasForServerProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$activeServerAreasHash();

  @$internal
  @override
  $FutureProviderElement<ActiveServerAreasState> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ActiveServerAreasState> create(Ref ref) {
    return activeServerAreas(ref);
  }
}

String _$activeServerAreasHash() => r'40c1ead6c9df1c13682b32d8b497d51a1f97fb04';
