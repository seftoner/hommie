import 'package:logger/logger.dart';

late final Logger logger;

Logger createLogger(String logsPath) {
  return Logger(
    printer: _HLogfmtPrinter(),
    filter: _LoggerFilter(),
    output: MultiOutput([
      ConsoleOutput(),
      AdvancedFileOutput(
        path: logsPath,
        maxFileSizeKB: -1,
      ),
    ]),
  );
}

class _LoggerFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => switch (event.level) {
        Level.debug ||
        // Level.trace ||
        Level.error ||
        Level.info ||
        Level.fatal ||
        Level.warning =>
          true,
        _ => false,
      };
}

class _HLogfmtPrinter extends LogPrinter {
  final logfmtPrinter = LogfmtPrinter();

  @override
  List<String> log(LogEvent event) {
    final timestamp = DateTime.now().toIso8601String();
    var realLogs = logfmtPrinter.log(event);
    return realLogs.map((line) => "time=$timestamp $line").toList();
  }
}
