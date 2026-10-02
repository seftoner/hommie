import 'dart:io';

import 'patrol_cli.dart';
import 'simulator.dart';

class PatrolRunner {
  final PatrolCli cli;
  final Duration timeout;
  final nativeResults = <Directory>[];
  PatrolRunner(this.cli, {this.timeout = const Duration(minutes: 30)});
  Future<int> runTargets(
    List<String> targets, {
    required SimulatorDevice device,
    required File defines,
    String? tags,
    bool preserveApp = false,
    bool develop = false,
  }) async {
    final result = await cli.run(
      [
        develop ? 'develop' : 'test',
        '--device',
        device.id,
        for (final target in targets) ...[
          '--target',
          'integration_test/${target}_test.dart',
        ],
        '--dart-define-from-file',
        defines.path,
        if (tags != null) ...['--tags', tags],
        if (preserveApp) '--no-uninstall',
        '--hide-test-steps',
        '--no-clear-test-steps',
      ],
      timeout: timeout,
      interactive: develop,
    );
    for (final match in RegExp(
      r'Report:\s*(.+?\.xcresult)',
    ).allMatches(result.stdout as String)) {
      final directory = Directory(match[1]!.trim());
      if (directory.existsSync()) nativeResults.add(directory);
    }
    return result.exitCode;
  }
}
