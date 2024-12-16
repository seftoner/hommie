import 'package:logger/logger.dart';

class TestsLoggerFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return [
      Level.error,
      Level.fatal,
      // Level.trace,
    ].contains(event.level);
  }
}

//Use this logger only for tests.
//Reason: If the test fails, VS Code will show the latest log from
//the console near the test method. The last message might not be the error,
//so I need to search for the error in the terminal instead of seeing
//it right above the method name in the code.
Logger testLogger = Logger(
  filter: TestsLoggerFilter(),
  printer: PrettyPrinter(
    colors: false,
    dateTimeFormat: DateTimeFormat.none,
    noBoxingByDefault: true,
    printEmojis: false,
  ),
  output: null,
);
