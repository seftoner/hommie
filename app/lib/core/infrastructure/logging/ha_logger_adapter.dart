import 'package:home_assistant_websocket/home_assistant_websocket.dart';
import 'package:logger/logger.dart';

/// Adapter that bridges the logger package's Logger with HaLogger interface.
/// This allows the home_assistant_websocket package to use the app's logger
/// configuration including file output, custom formatting, and filtering.
class HaLoggerAdapter implements HaLogger {
  final Logger _logger;

  const HaLoggerAdapter(this._logger);

  @override
  void trace(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  @override
  void debug(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  @override
  void info(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
