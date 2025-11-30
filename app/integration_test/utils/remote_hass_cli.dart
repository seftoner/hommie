import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class CommandResult {
  final String stdout;
  final String stderr;
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
  String toString() =>
      'CommandError: $message${error != null ? ' ($error)' : ''}';
}

class RemoteHassCli {
  static final RemoteHassCli _instance = RemoteHassCli._internal();
  factory RemoteHassCli() => _instance;
  RemoteHassCli._internal();

  static final _cliServerUrl = Platform.isAndroid
      ? 'http://10.0.2.2:3000/cli'
      : 'http://localhost:3000/cli';
  String? _token;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    _token = const String.fromEnvironment('HASS_TOKEN');
    assert(
      _token?.isNotEmpty == true,
      'HASS_TOKEN environment variable is not set',
    );

    _isInitialized = true;
  }

  void setToken(String token) {
    _token = token;
    _isInitialized = true;
  }

  Future<Either<CommandError, CommandResult>> execute(String command) async {
    try {
      if (!_isInitialized) {
        await initialize();
      }

      final response = await http.post(
        Uri.parse(_cliServerUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'command': command, 'token': _token}),
      );

      final data = jsonDecode(response.body);

      return Right(
        CommandResult(
          stdout: data['stdout'],
          stderr: data['stderr'],
          exitCode: data['exit_code'],
        ),
      );
    } catch (e) {
      return Left(CommandError('Failed to execute command', e));
    }
  }
}
