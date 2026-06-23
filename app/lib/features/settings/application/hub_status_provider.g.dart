// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hubStatus)
const hubStatusProvider = HubStatusProvider._();

final class HubStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<HubStatusState>,
          HubStatusState,
          FutureOr<HubStatusState>
        >
    with $FutureModifier<HubStatusState>, $FutureProvider<HubStatusState> {
  const HubStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hubStatusProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          activeServerSessionProvider,
          authStateProvider,
          deviceInfoRepositoryProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          HubStatusProvider.$allTransitiveDependencies0,
          HubStatusProvider.$allTransitiveDependencies1,
          HubStatusProvider.$allTransitiveDependencies2,
          HubStatusProvider.$allTransitiveDependencies3,
          HubStatusProvider.$allTransitiveDependencies4,
          HubStatusProvider.$allTransitiveDependencies5,
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
  static const $allTransitiveDependencies5 = deviceInfoRepositoryProvider;

  @override
  String debugGetCreateSourceHash() => _$hubStatusHash();

  @$internal
  @override
  $FutureProviderElement<HubStatusState> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HubStatusState> create(Ref ref) {
    return hubStatus(ref);
  }
}

String _$hubStatusHash() => r'34d87d184d3823cc56a20ea98988516feee2b4eb';
