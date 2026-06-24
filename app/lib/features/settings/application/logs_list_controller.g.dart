// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LogsListController)
final logsListControllerProvider = LogsListControllerProvider._();

final class LogsListControllerProvider
    extends $AsyncNotifierProvider<LogsListController, LogsListState> {
  LogsListControllerProvider._()
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
    r'18a42caa8f303b79c56ce4816ec3dd4417189a6d';

abstract class _$LogsListController extends $AsyncNotifier<LogsListState> {
  FutureOr<LogsListState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LogsListState>, LogsListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LogsListState>, LogsListState>,
              AsyncValue<LogsListState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
