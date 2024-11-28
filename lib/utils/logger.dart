import 'package:logger/logger.dart';

class LoggerFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return [
      Level.debug,
      Level.error,
      Level.info,
      Level.fatal,
      Level.warning,
      Level.trace
    ].contains(event.level);
  }
}

late final Logger logger;

class HLogfmtPrinter extends LogPrinter {
  final logfmtPrinter = LogfmtPrinter();
  @override
  List<String> log(LogEvent event) {
    final timestamp = DateTime.now().toIso8601String();
    var realLogs = logfmtPrinter.log(event);
    return realLogs.map((line) => "time=$timestamp $line").toList();
  }
}

Logger createLogger(String logsPath) {
  return Logger(
    printer: HLogfmtPrinter(),
    output: MultiOutput([
      ConsoleOutput(),
      AdvancedFileOutput(
        path: logsPath,
        maxFileSizeKB: -1,
      )
    ]),
  );
}
