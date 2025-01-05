import 'dart:ui';

import 'package:hommie/core/utils/log_file.dart';
import 'package:hommie/core/utils/logger.dart';
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
}
