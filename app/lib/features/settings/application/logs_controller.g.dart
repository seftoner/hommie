// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LogsController)
const logsControllerProvider = LogsControllerProvider._();

final class LogsControllerProvider
    extends $AsyncNotifierProvider<LogsController, void> {
  const LogsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logsControllerHash();

  @$internal
  @override
  LogsController create() => LogsController();
}

String _$logsControllerHash() => r'66191d58f214e4b320b5e18c41e223775f363081';

abstract class _$LogsController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
