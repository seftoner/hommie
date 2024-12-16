import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hommie/features/settings/domain/entities/logs.dart';
import 'package:hommie/features/settings/infrastructure/providers/logs_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logs_list_controller.g.dart';
part 'logs_list_controller.freezed.dart';

@freezed
class LogsListState with _$LogsListState {
  factory LogsListState(
    bool isLoadingMore,
    List<Log> logs,
  ) = _LogsListState;
}

@riverpod
class LogsListController extends _$LogsListController {
  int _offset = 0;
  final int _limit = 1000;

  @override
  Future<LogsListState> build() async {
    final repository = await ref.watch(logsRepositoryProvider.future);

    final logs = await repository.fetchLogs(_offset, _limit);
    _offset += logs.length;

    return LogsListState(false, logs);
  }

  Future<void> loadMoreLogs() async {
    final currentState = await future;

    if (currentState.isLoadingMore) {
      return;
    }

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    try {
      final repository = await ref.watch(logsRepositoryProvider.future);
      final newLogs = await repository.fetchLogs(_offset, _limit);

      if (newLogs.isNotEmpty) {
        // Update the offset for the next batch
        _offset += newLogs.length;

        state = AsyncValue.data(
          currentState.copyWith(
            isLoadingMore: false,
            logs: [...currentState.logs, ...newLogs],
          ),
        );
      } else {
        state = AsyncValue.data(currentState.copyWith(isLoadingMore: false));
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
