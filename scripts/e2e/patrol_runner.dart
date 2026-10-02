import 'dart:io';

import 'patrol_cli.dart';
import 'simulator.dart';

class PatrolRunner {
  final PatrolCli cli;
  final Duration timeout;
  PatrolRunner(this.cli, {this.timeout = const Duration(minutes: 30)});
  Future<int> runTargets(
    List<String> targets, {
    required SimulatorDevice device,
    required File defines,
    String? tags,
    bool preserveApp = false,
  }) async {
    final result = await cli.run([
      'test',
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
    ], timeout: timeout);
    return result.exitCode;
  }
}
