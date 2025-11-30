/// Abstract interface for logging in the Home Assistant WebSocket package.
/// Allows users to inject custom logger implementations or use the default print-based logger.
abstract class HaLogger {
  /// Logs a trace-level message. Most verbose logging level.
  void trace(String message, {Object? error, StackTrace? stackTrace});

  /// Logs a debug-level message for detailed diagnostic information.
  void debug(String message, {Object? error, StackTrace? stackTrace});

  /// Logs an info-level message for general informational messages.
  void info(String message, {Object? error, StackTrace? stackTrace});

  /// Logs a warning-level message for potentially harmful situations.
  void warning(String message, {Object? error, StackTrace? stackTrace});

  /// Logs an error-level message for error events.
  void error(String message, {Object? error, StackTrace? stackTrace});
}

/// Default logger implementation that uses Dart's print() with level prefixes.
/// Outputs messages in the format: [LEVEL] message
class PrintLogger implements HaLogger {
  const PrintLogger();

  @override
  void trace(String message, {Object? error, StackTrace? stackTrace}) {
    print('[TRACE] $message${_formatError(error, stackTrace)}');
  }

  @override
  void debug(String message, {Object? error, StackTrace? stackTrace}) {
    print('[DEBUG] $message${_formatError(error, stackTrace)}');
  }

  @override
  void info(String message, {Object? error, StackTrace? stackTrace}) {
    print('[INFO] $message${_formatError(error, stackTrace)}');
  }

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    print('[WARNING] $message${_formatError(error, stackTrace)}');
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    print('[ERROR] $message${_formatError(error, stackTrace)}');
  }

  String _formatError(Object? error, StackTrace? stackTrace) {
    if (error == null && stackTrace == null) return '';
    final buffer = StringBuffer();
    if (error != null) buffer.write('\n  Error: $error');
    if (stackTrace != null) buffer.write('\n  Stack trace:\n$stackTrace');
    return buffer.toString();
  }
}

/// No-op logger that silently discards all log messages.
/// Useful for testing or when logging should be completely disabled.
class NoOpLogger implements HaLogger {
  const NoOpLogger();

  @override
  void trace(String message, {Object? error, StackTrace? stackTrace}) {}

  @override
  void debug(String message, {Object? error, StackTrace? stackTrace}) {}

  @override
  void info(String message, {Object? error, StackTrace? stackTrace}) {}

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) {}

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {}
}

/// Adapter for wrapping custom logger implementations.
/// Use this to integrate with external logging libraries by mapping their methods
/// to the HaLogger interface.
///
/// Example:
/// ```dart
/// class MyLoggerAdapter implements HaLogger {
///   final MyCustomLogger _logger;
///
///   MyLoggerAdapter(this._logger);
///
///   @override
///   void info(String message, {Object? error, StackTrace? stackTrace}) {
///     _logger.logInfo(message);
///     if (error != null) _logger.logError(error.toString());
///   }
///   // ... implement other methods
/// }
/// ```
