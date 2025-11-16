// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LogsControler)
const logsControlerProvider = LogsControlerProvider._();

final class LogsControlerProvider
    extends $AsyncNotifierProvider<LogsControler, void> {
  const LogsControlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logsControlerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logsControlerHash();

  @$internal
  @override
  LogsControler create() => LogsControler();
}

String _$logsControlerHash() => r'ed776663a0c849eef49a022cd9d1773179a9660d';

abstract class _$LogsControler extends $AsyncNotifier<void> {
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
