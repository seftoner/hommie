// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(parallelismExecutor)
const parallelismExecutorProvider = ParallelismExecutorProvider._();

final class ParallelismExecutorProvider
    extends
        $FunctionalProvider<
          IParallelExecutor,
          IParallelExecutor,
          IParallelExecutor
        >
    with $Provider<IParallelExecutor> {
  const ParallelismExecutorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parallelismExecutorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parallelismExecutorHash();

  @$internal
  @override
  $ProviderElement<IParallelExecutor> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IParallelExecutor create(Ref ref) {
    return parallelismExecutor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IParallelExecutor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IParallelExecutor>(value),
    );
  }
}

String _$parallelismExecutorHash() =>
    r'dce85279051fdccfd4f2bf722b3ec2fddf1173e1';
