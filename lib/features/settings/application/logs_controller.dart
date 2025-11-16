import 'dart:ui';

import 'package:hommie/core/utils/log_file.dart';
import 'package:hommie/core/utils/logger.dart';
import 'package:hommie/features/settings/infrastructure/providers/logs_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'logs_controller.g.dart';

@riverpod
class LogsControler extends _$LogsControler {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> shareLogs(Rect sharePositionOrigin) async {
    try {
      final logFile = await getLogsPath(); // Your existing method
      if (await logFile.exists()) {
        final sharingResult = await Share.shareXFiles(
          [XFile(logFile.path)],
          text: 'Share logs',
          sharePositionOrigin: sharePositionOrigin,
        );

        switch (sharingResult.status) {
          case ShareResultStatus.success:
            logger.i('Logs shared successfully');
            break;
          case ShareResultStatus.dismissed:
            logger.w('Logs sharing was dismissed by the user');
            break;
          default:
            logger.w('Unhandled sharing result: $sharingResult');
        }
      } else {
        throw Exception('Log file not found');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteLogs() async {
    state = const AsyncLoading();
    try {
      final repository = await ref.read(logsRepositoryProvider.future);
      await repository.deleteLogs();
      logger.i('Logs deleted successfully');
      if (ref.mounted) {
        state = const AsyncData(null);
      }
    } catch (error, stackTrace) {
      logger.e('Failed to delete logs', error: error, stackTrace: stackTrace);
      if (ref.mounted) {
        state = AsyncError(error, stackTrace);
      }
    }
  }
}
