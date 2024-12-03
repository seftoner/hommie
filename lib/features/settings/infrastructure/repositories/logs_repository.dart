import 'dart:convert';
import 'dart:io';

import 'package:hommie/core/infrastructure/base_repository.dart';
import 'package:hommie/core/infrastructure/parallelism/i_parallel_executor.dart';
import 'package:hommie/features/settings/domain/entities/logs.dart';
import 'package:hommie/features/settings/domain/repository/i_logs_repository.dart';
import 'package:hommie/core/utils/logger.dart';

class FetchLogsParams {
  final int offset;
  final int limit;
  final String filePath;

  FetchLogsParams(this.offset, this.limit, this.filePath);
}

class LogsRepository extends BaseRepository implements ILogsRepository {
  final String _logsPath;

  LogsRepository(this._logsPath, IParallelExecutor executor) : super(executor);

  @override
  Stream<Log> streamLogs() async* {
    final stream = await executor.executeStreamNoArgs<Log>(_streamLogsTask);
    yield* stream;
  }

  @override
  Future<List<Log>> fetchLogs(int offset, int limit) {
    // The fetchLogsTask method should ideally be executed using Computer to run
    // in a separate thread. However, it must be a top-level or static method,
    // which is currently not the case. For now, this logic remains within the
    // repository. In the future, consider restructuring to enable multi-threaded
    // log fetching for better performance.
    return fetchLogsTask(FetchLogsParams(offset, limit, _logsPath));
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

  Future<List<Log>> fetchLogsTask(FetchLogsParams params) async {
    final file = File(params.filePath);
    final result = <Log>[];

    if (!await file.exists()) {
      throw Exception("Log file does not exist: ${params.filePath}");
    }

    int currentLineIndex = 0;

    final stream =
        file.openRead().transform(utf8.decoder).transform(LineSplitter());

    await for (final line in stream) {
      if (currentLineIndex >= params.offset &&
          currentLineIndex < params.offset + params.limit) {
        final log = _parseLog(line);
        if (log != null) result.add(log);
      }

      if (currentLineIndex >= params.offset + params.limit) {
        break; // Stop reading once we've collected enough lines
      }

      currentLineIndex++;
    }

    return result;
  }
}
