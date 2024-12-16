import 'dart:convert';
import 'dart:io';

import 'package:hommie/core/infrastructure/tasks/base_task.dart';
import 'package:hommie/features/settings/domain/entities/logs.dart';

class FetchLogsParams {
  /// offset: The starting line number in the log file to read.
  final int offset;

  /// limit: The maximum number of lines to read from the log file.
  final int limit;

  /// filePath: The absolute path to the log file.
  final String filePath;

  FetchLogsParams(this.offset, this.limit, this.filePath);
}

/// The FetchLogsTask is responsible for reading and processing log entries from a
/// file in a structured and efficient manner. It works with
/// the FetchLogsParams to define the scope and location of the logs to be fetched.
class FetchLogsTask extends BaseTask<FetchLogsParams, List<Log>> {
  FetchLogsTask(super.params);

  @override
  Future<List<Log>> run() async {
    final file = File(params.filePath);
    final result = <Log>[];

    if (!await file.exists()) {
      throw Exception('Log file does not exist: ${params.filePath}');
    }

    int currentLineIndex = 0;

    final stream =
        file.openRead().transform(utf8.decoder).transform(const LineSplitter());

    await for (final line in stream) {
      if (currentLineIndex >= params.offset &&
          currentLineIndex < params.offset + params.limit) {
        final log = _parseLog(line);
        if (log != null) {
          result.add(log);
        }
      }

      if (currentLineIndex >= params.offset + params.limit) {
        break; // Stop reading once we've collected enough lines
      }

      currentLineIndex++;
    }

    return result;
  }

  Log? _parseLog(String line) {
    final regex = RegExp(r'(\w+)=(".*?(?<!\\)"|\S+)');
    final matches = regex.allMatches(line);

    final Map<String, String> logData = {};
    for (final match in matches) {
      final key = match.group(1);
      var value = match.group(2);
      if (value != null && value.startsWith('"') && value.endsWith('"')) {
        value = value.substring(1, value.length - 1);
      }
      if (key != null && value != null) {
        logData[key] = value;
      }
    }

    final timeStr = logData.remove('time');
    final levelStr = logData.remove('level');
    final msg = logData.remove('msg');

    if (timeStr == null || levelStr == null || msg == null) {
      return null; // Required fields are missing
    }

    final details = logData.entries.map((e) => '${e.key}=${e.value}').join(' ');

    return Log(
      time: DateTime.parse(timeStr),
      msg: msg,
      level: _parseLogLevel(levelStr),
      details: details.isNotEmpty ? details : null,
    );
  }

  LogLevel _parseLogLevel(String level) => switch (level.toLowerCase()) {
        'trace' => LogLevel.trace,
        'debug' => LogLevel.debug,
        'info' => LogLevel.info,
        'warning' => LogLevel.warning,
        'error' => LogLevel.error,
        'fatal' => LogLevel.fatal,
        _ => throw Exception('Unknown log level: $level'),
      };
}
