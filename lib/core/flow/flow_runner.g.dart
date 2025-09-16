// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_runner.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FlowRunnerNotifier)
const flowRunnerProvider = FlowRunnerNotifierProvider._();

final class FlowRunnerNotifierProvider
    extends $NotifierProvider<FlowRunnerNotifier, FlowState> {
  const FlowRunnerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flowRunnerProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          activeServerProvider,
          toastServiceProvider,
          serverAuthControllerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          FlowRunnerNotifierProvider.$allTransitiveDependencies0,
          FlowRunnerNotifierProvider.$allTransitiveDependencies1,
          FlowRunnerNotifierProvider.$allTransitiveDependencies2,
          FlowRunnerNotifierProvider.$allTransitiveDependencies3,
          FlowRunnerNotifierProvider.$allTransitiveDependencies4,
          FlowRunnerNotifierProvider.$allTransitiveDependencies5,
          FlowRunnerNotifierProvider.$allTransitiveDependencies6,
          FlowRunnerNotifierProvider.$allTransitiveDependencies7,
          FlowRunnerNotifierProvider.$allTransitiveDependencies8,
        },
      );

  static const $allTransitiveDependencies0 = activeServerProvider;
  static const $allTransitiveDependencies1 =
      ActiveServerProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = toastServiceProvider;
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
  String debugGetCreateSourceHash() => _$flowRunnerNotifierHash();

  @$internal
  @override
  FlowRunnerNotifier create() => FlowRunnerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlowState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlowState>(value),
    );
  }
}

String _$flowRunnerNotifierHash() =>
    r'ecea86cf2e17378441e541865b5be2f6d3e2dd87';

abstract class _$FlowRunnerNotifier extends $Notifier<FlowState> {
  FlowState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FlowState, FlowState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FlowState, FlowState>,
              FlowState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
