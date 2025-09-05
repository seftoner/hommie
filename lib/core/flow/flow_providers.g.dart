// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(flowRunner)
const flowRunnerProvider = FlowRunnerProvider._();

final class FlowRunnerProvider
    extends $FunctionalProvider<FlowRunner, FlowRunner, FlowRunner>
    with $Provider<FlowRunner> {
  const FlowRunnerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flowRunnerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flowRunnerHash();

  @$internal
  @override
  $ProviderElement<FlowRunner> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FlowRunner create(Ref ref) {
    return flowRunner(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlowRunner value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlowRunner>(value),
    );
  }
}

String _$flowRunnerHash() => r'e482b75b715b1eab11e407b5d4fb0466e88aba83';

@ProviderFor(flowState)
const flowStateProvider = FlowStateProvider._();

final class FlowStateProvider
    extends $FunctionalProvider<FlowState, FlowState, FlowState>
    with $Provider<FlowState> {
  const FlowStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flowStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flowStateHash();

  @$internal
  @override
  $ProviderElement<FlowState> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FlowState create(Ref ref) {
    return flowState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlowState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlowState>(value),
    );
  }
}

String _$flowStateHash() => r'e3982a1253e1aed8f632a435308a3596ba174fca';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
