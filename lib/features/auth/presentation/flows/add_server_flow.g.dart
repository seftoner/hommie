// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_server_flow.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_AddServerFlowController)
const _addServerFlowControllerProvider = _AddServerFlowControllerProvider._();

final class _AddServerFlowControllerProvider
    extends $NotifierProvider<_AddServerFlowController, _AddServerFlowStep> {
  const _AddServerFlowControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_addServerFlowControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_addServerFlowControllerHash();

  @$internal
  @override
  _AddServerFlowController create() => _AddServerFlowController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(_AddServerFlowStep value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<_AddServerFlowStep>(value),
    );
  }
}

String _$_addServerFlowControllerHash() =>
    r'3e65207d3641591a631dae523009edfd65396e03';

abstract class _$AddServerFlowController extends $Notifier<_AddServerFlowStep> {
  _AddServerFlowStep build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<_AddServerFlowStep, _AddServerFlowStep>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<_AddServerFlowStep, _AddServerFlowStep>,
              _AddServerFlowStep,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
