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
        dependencies: null,
        $allTransitiveDependencies: null,
      );

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

String _$hubStatusHash() => r'84b686da23f61e78b1b613375b6b08556b680f1e';
