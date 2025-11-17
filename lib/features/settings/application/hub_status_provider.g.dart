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
        dependencies: const <ProviderOrFamily>[serverConnectionStateProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          HubStatusProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = serverConnectionStateProvider;

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

String _$hubStatusHash() => r'cd19fdae1ed58774de22866b99fa4312d92f3846';
