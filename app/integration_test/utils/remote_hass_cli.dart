import 'dart:async';
import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import 'e2e_config.dart';

class CommandResult {
  final String stdout, stderr;
  final int exitCode;
  const CommandResult({
    required this.stdout,
    required this.stderr,
    required this.exitCode,
  });
  bool get isSuccess => exitCode == 0;
}

class CommandError {
  final String message;
  final Object? error;
  const CommandError(this.message, [this.error]);
  @override
  String toString() => 'CommandError: $message';
}

class RemoteHassCli {
  final Uri _url;
  final String _token;
  final http.Client _client;
  final Duration _timeout;
  RemoteHassCli({
    required Uri fixtureControlUrl,
    required String managementToken,
    http.Client? client,
    Duration timeout = const Duration(seconds: 25),
  }) : _url = fixtureControlUrl.resolve('/cli'),
       _token = managementToken,
       _client = client ?? http.Client(),
       _timeout = timeout {
    if (_token.isEmpty) {
      throw const FormatException('Management token is required');
    }
  }
  factory RemoteHassCli.fromEnvironment() {
    final config = E2eTestConfig.fromEnvironment();
    return RemoteHassCli(
      fixtureControlUrl: config.fixtureControlUrl,
      managementToken: config.managementToken,
    );
  }
  void close() => _client.close();

  String _redact(String text) => text.replaceAll(_token, '[REDACTED]');
  Future<Either<CommandError, CommandResult>> execute(List<String> args) async {
    try {
      final response = await _client
          .post(
            _url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'args': args, 'token': _token}),
          )
          .timeout(_timeout);
      if (response.statusCode != 200) {
        return Left(CommandError('CLI HTTP failure (${response.statusCode})'));
      }
      final data = jsonDecode(response.body);
      if (data is! Map<String, dynamic> ||
          data['stdout'] is! String ||
          data['stderr'] is! String ||
          data['exit_code'] is! int) {
        return const Left(CommandError('Invalid CLI response'));
      }
      final result = CommandResult(
        stdout: data['stdout'] as String,
        stderr: _redact(data['stderr'] as String),
        exitCode: data['exit_code'] as int,
      );
      if (!result.isSuccess) {
        return Left(
          CommandError('CLI failure (${result.exitCode}): ${result.stderr}'),
        );
      }
      return Right(result);
    } on TimeoutException {
      return const Left(
        CommandError(
          'CLI request timed out; mutation completion unknown, reconcile before retrying',
        ),
      );
    } on FormatException {
      return const Left(CommandError('Invalid CLI JSON response'));
    } catch (_) {
      return const Left(CommandError('CLI transport failure'));
    }
  }

  Future<Object?> executeWs(
    String type, {
    Map<String, Object?>? payload,
  }) async {
    final result = await execute([
      'raw',
      'ws',
      type,
      if (payload != null) '--json=${jsonEncode(payload)}',
    ]);
    return result.fold((error) => throw StateError(error.message), (success) {
      final Object? response;
      try {
        response = jsonDecode(success.stdout);
      } on FormatException {
        throw StateError('Invalid HA JSON for $type');
      }
      if (response is! Map<String, dynamic> || response['success'] != true) {
        final detail = response is Map ? response['error'] : 'invalid result';
        throw StateError(_redact('HA operation $type failed: $detail'));
      }
      return response['result'];
    });
  }
}
