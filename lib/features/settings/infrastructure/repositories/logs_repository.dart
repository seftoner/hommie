import 'dart:convert';
import 'dart:io';

import 'package:hommie/core/infrastructure/base_repository.dart';
import 'package:hommie/core/infrastructure/parallelism/i_parallel_executor.dart';
import 'package:hommie/features/settings/domain/entities/logs.dart';
import 'package:hommie/features/settings/domain/repository/i_logs_repository.dart';
import 'package:hommie/core/utils/logger.dart';

class LogsRepository extends BaseRepository implements ILogsRepository {
  final String _logsPath;

  LogsRepository(this._logsPath, IParallelExecutor executor) : super(executor);

  @override
  Stream<Log> streamLogs() async* {
    final stream = await executor.executeStreamNoArgs<Log>(_streamLogsTask);
    yield* stream;
  }

  Stream<Log> _streamLogsTask() async* {
    final file = File(_logsPath);

    if (!await file.exists()) {
      throw Exception("Log file does not exist: $_logsPath");
    }

    // Open the file as a stream
    final lines =
        file.openRead().transform(utf8.decoder).transform(LineSplitter());

    await for (final line in lines) {
      try {
        final log = _parseLog(line);
        if (log != null) yield log;
      } catch (e) {
        logger.d('Failed to parse log line: $line\nError: $e');
      }
    }
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
