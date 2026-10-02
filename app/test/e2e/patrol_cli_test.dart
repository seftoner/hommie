import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../scripts/e2e/patrol_cli.dart';
import '../../../scripts/e2e/process_runner.dart';

void main() {
  test('activation may give the CLI a versionless root URI', () async {
    final root = Directory.systemTemp.createTempSync('e2e cli ');
    addTearDown(() => root.deleteSync(recursive: true));
    final activation = Directory(
      '${root.path}/.dart_tool/e2e/pub-cache/global_packages/patrol_cli',
    );
    Directory('${activation.path}/.dart_tool').createSync(recursive: true);
    File('${activation.path}/pubspec.yaml')
        .writeAsStringSync('name: patrol_cli\nversion: 4.8.0\n');
    File('${activation.path}/.dart_tool/package_config.json').writeAsStringSync(
      jsonEncode({
        'packages': [
          {'name': 'patrol_cli', 'rootUri': '../', 'packageUri': 'lib/'},
        ],
      }),
    );
    final processes = _Processes();
    final result = await PatrolCli(root, processes).run(['--version']);
    expect(result.exitCode, 0);
    expect(processes.arguments.last, '--version');
    expect(processes.arguments, contains('${activation.path}/bin/main.dart'));
  });
}

class _Processes extends ProcessRunner {
  List<String> arguments = [];
  @override
  Future<ProcessResult> run(
    String executable,
    List<String> args, {
    required Directory cwd,
    required Duration timeout,
    Map<String, String>? environment,
    Stream<List<int>>? input,
  }) async {
    arguments = args;
    return ProcessResult(1, 0, 'patrol_cli 4.8.0', '');
  }
}
