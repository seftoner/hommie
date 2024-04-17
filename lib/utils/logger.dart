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

var logger = Logger(
  filter:
      LoggerFilter(), // Use the default LogFilter (-> only log in debug mode)
  printer: PrettyPrinter(
      methodCount: 1,
      colors: false,
      printEmojis: true), // Use the PrettyPrinter to format and print log
  // output: null, // Use the default LogOutput (-> send everything to console)
);
