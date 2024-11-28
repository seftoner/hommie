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

class HLoggerOutput extends LogOutput {
  final LogOutput _consoleOutput;
  final LogOutput _fileOutput;

  HLoggerOutput(String filePath)
      : _consoleOutput = ConsoleOutput(),
        _fileOutput = AdvancedFileOutput(path: filePath, maxFileSizeKB: 10240);

  @override
  void output(OutputEvent event) {
    // Print to console
    _consoleOutput.output(event);

    // Save to file
    _fileOutput.output(event);
  }
}

var logger = Logger(
  filter:
      LoggerFilter(), // Use the default LogFilter (-> only log in debug mode)
  printer: PrettyPrinter(
      methodCount: 1,
      colors: false,
      noBoxingByDefault: true,
      printEmojis: true), // Use the PrettyPrinter to format and print log
  output: HLoggerOutput("./"),
);
