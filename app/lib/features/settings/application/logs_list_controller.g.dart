// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LogsListController)
const logsListControllerProvider = LogsListControllerProvider._();

final class LogsListControllerProvider
    extends $AsyncNotifierProvider<LogsListController, LogsListState> {
  const LogsListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logsListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logsListControllerHash();

  @$internal
  @override
  LogsListController create() => LogsListController();
}

String _$logsListControllerHash() =>
    r'704ee7d6de609b5fef8eeabedcc6f2f2b1ba8485';

abstract class _$LogsListController extends $AsyncNotifier<LogsListState> {
  FutureOr<LogsListState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<LogsListState>, LogsListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LogsListState>, LogsListState>,
              AsyncValue<LogsListState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
