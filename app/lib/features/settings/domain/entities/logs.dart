import 'package:freezed_annotation/freezed_annotation.dart';

part 'logs.freezed.dart';

enum LogLevel { trace, debug, info, error, fatal, warning }

@freezed
sealed class Log with _$Log {
  factory Log({
    required DateTime time,
    required String msg,
    required LogLevel level,
    String? details,
  }) = _Log;
}
