import 'dart:convert';
import 'dart:io';

import 'backend_fixture.dart';
import 'config.dart';
import 'ownership_journal.dart';
import 'patrol_cli.dart';
import 'patrol_runner.dart';
import 'process_runner.dart';
import 'simulator.dart';

Future<int> runOrdinary(E2eConfig config) async {
  if (config.target == null || config.target == 'cold_start')
    throw StateError(
      'Cold-start/default suite orchestration is not implemented yet; select an ordinary target',
    );
  if (config.watch || config.develop || config.repeat != 1)
    throw StateError('Repeat/watch/develop rails are not implemented yet');
  final backend = BackendFixture(config, ProcessRunner());
  OwnershipJournal? journal;
  File? defines;
  var code = 1;
  try {
    await backend.start();
    final secretValues = backend.credentials.values
        .where((v) => v.isNotEmpty)
        .toList();
    final processes = ProcessRunner(
      onOutput: (text) {
        for (final secret in secretValues) {
          text = text.replaceAll(secret, '[REDACTED]');
        }
        text = text.replaceAll(
          RegExp(r'eyJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+'),
          '[REDACTED_TOKEN]',
        );
        stdout.write(text);
      },
    );
    final simulator = IosSimulator(config.repoRoot, ProcessRunner());
    final device = await simulator.select(device: config.device);
    stdout.writeln('iOS Simulator: ${device.name} (${device.id})');
    await simulator.bootAndWait(device);
    final generation = await processes.run(
      'dart',
      ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
      cwd: Directory('${config.repoRoot.path}/app'),
      timeout: const Duration(minutes: 5),
    );
    if (generation.exitCode != 0) throw StateError('BDD generation failed');
    final directory = Directory(
      '${config.repoRoot.path}/.dart_tool/e2e/ownership',
    );
    if (directory.existsSync()) {
      for (final file in directory.listSync().whereType<File>().where(
        (f) => f.path.endsWith('.json'),
      )) {
        await OwnershipJournal.read(file).reconcile(backend);
      }
    }
    final runId = 'run_${DateTime.now().microsecondsSinceEpoch}';
    journal = await OwnershipJournal.create(backend, directory, runId);
    defines = File(
      '${config.repoRoot.path}/.dart_tool/e2e/defines-$runId.json',
    );
    await defines.writeAsString(
      jsonEncode({
        ...backend.credentials,
        'E2E_APP_SERVER_URL': config.appServerUrl.toString(),
        'E2E_FIXTURE_CONTROL_URL': config.fixtureControlUrl.toString(),
        'E2E_FAULT_CONTROL_URL': config.faultControlUrl.toString(),
        'E2E_RUN_ID': runId,
        'E2E_COLD_PHASE': 'none',
      }),
      flush: true,
    );
    await Process.run('chmod', ['600', defines.path]);
    code =
        await PatrolRunner(
          PatrolCli(config.repoRoot, processes),
          timeout: config.timeout,
        ).runTargets(
          [config.target!],
          device: device,
          defines: defines,
          tags: config.tags,
        );
  } finally {
    try {
      await backend.setRouteEnabled(true);
    } catch (_) {
      stderr.writeln('Proxy restoration failed');
      code = code == 0 ? 1 : code;
    }
    if (journal != null) {
      try {
        await journal.reconcile(backend);
      } catch (_) {
        stderr.writeln('Ownership cleanup requires repair; journal retained');
        code = code == 0 ? 1 : code;
      }
    }
    if (defines?.existsSync() == true) await defines!.delete();
    backend.close();
  }
  return code;
}
