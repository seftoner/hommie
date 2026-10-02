import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../scripts/e2e/process_runner.dart';
import '../../../scripts/e2e/simulator.dart';
import '../../../scripts/e2e/patrol_cli.dart';
import '../../../scripts/e2e/patrol_runner.dart';

void main() {
  test('selects booted iPhone then newest runtime deterministically; explicit ID wins', () async {
    final processes = _Processes();
    final simulator = IosSimulator(Directory('/tmp'), processes);
    expect((await simulator.select()).id, 'booted');
    expect((await simulator.select(device: 'new')).id, 'new');
    await expectLater(simulator.select(device: 'missing'), throwsStateError);
    processes.booted = false;
    final selected = await simulator.select();
    expect(selected.id, 'new');
    await simulator.bootAndWait(selected);
    expect(processes.calls.skip(processes.calls.length - 2).map((a) => a[1]), [
      'boot',
      'bootstatus',
    ]);
  });
  test(
    'runner forwards targets, tags, device, private defines and exit code',
    () async {
      final cli = _Cli();
      final code = await PatrolRunner(cli).runTargets(
        ['authorization', 'areas'],
        device: SimulatorDevice('id', 'iPhone', 'runtime', false),
        defines: File('/tmp/private defines.json'),
        tags: 'quick',
        preserveApp: true,
      );
      expect(code, 7);
      expect(
        cli.args,
        containsAll([
          '--device',
          'id',
          '--tags',
          'quick',
          '--dart-define-from-file',
          '/tmp/private defines.json',
          '--no-uninstall',
          'integration_test/authorization_test.dart',
          'integration_test/areas_test.dart',
        ]),
      );
    },
  );
}

class _Processes extends ProcessRunner {
  bool booted = true;
  final calls = <List<String>>[];
  @override
  Future<ProcessResult> run(
    String executable,
    List<String> args, {
    required Directory cwd,
    required Duration timeout,
    Map<String, String>? environment,
    Stream<List<int>>? input,
  }) async {
    calls.add(args);
    return ProcessResult(
      1,
      0,
      jsonEncode({
        'runtimes': [
          {'identifier': 'old', 'version': '18.6', 'isAvailable': true},
          {'identifier': 'new', 'version': '26.0', 'isAvailable': true},
        ],
        'devices': {
          'old': [
            {
              'udid': 'booted',
              'name': 'iPhone 16',
              'isAvailable': true,
              'state': booted ? 'Booted' : 'Shutdown',
            },
          ],
          'new': [
            {
              'udid': 'new',
              'name': 'iPhone 17',
              'isAvailable': true,
              'state': 'Shutdown',
            },
          ],
        },
      }),
      '',
    );
  }
}

class _Cli extends PatrolCli {
  List<String> args = [];
  _Cli() : super(Directory('/tmp'), ProcessRunner());
  @override
  Future<ProcessResult> run(
    List<String> args, {
    Duration timeout = const Duration(minutes: 30),
    bool interactive = false,
  }) async {
    this.args = args;
    return ProcessResult(1, 7, '', '');
  }
}
