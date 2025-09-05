// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_runner.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(FlowRunnerNotifier)
const flowRunnerNotifierProvider = FlowRunnerNotifierFamily._();

final class FlowRunnerNotifierProvider
    extends $NotifierProvider<FlowRunnerNotifier, FlowState> {
  const FlowRunnerNotifierProvider._({
    required FlowRunnerNotifierFamily super.from,
    required GoRouter super.argument,
  }) : super(
         retry: null,
         name: r'flowRunnerNotifierProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$flowRunnerNotifierHash();

  @override
  String toString() {
    return r'flowRunnerNotifierProvider'
        ''
        '($argument)';
  }

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

  @override
  bool operator ==(Object other) {
    return other is FlowRunnerNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$flowRunnerNotifierHash() =>
    r'1c3e91593cf7628b91fc35b0c0e39f7245515fc4';

final class FlowRunnerNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          FlowRunnerNotifier,
          FlowState,
          FlowState,
          FlowState,
          GoRouter
        > {
  const FlowRunnerNotifierFamily._()
    : super(
        retry: null,
        name: r'flowRunnerNotifierProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  FlowRunnerNotifierProvider call(GoRouter router) =>
      FlowRunnerNotifierProvider._(argument: router, from: this);

  @override
  String toString() => r'flowRunnerNotifierProvider';
}

abstract class _$FlowRunnerNotifier extends $Notifier<FlowState> {
  late final _$args = ref.$arg as GoRouter;
  GoRouter get router => _$args;

  FlowState build(GoRouter router);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
