import 'dart:io';

import 'e2e/config.dart';
import 'e2e/backend_fixture.dart';
import 'e2e/process_runner.dart';
import 'e2e/local_runner.dart';
import 'e2e/lifecycle.dart';
import 'e2e/watch.dart';
import 'e2e/artifacts.dart';
import 'e2e/ownership_journal.dart';

Future<void> main(List<String> args) async {
  RunLock? lock;
  try {
    final root = File.fromUri(Platform.script).parent.parent;
    final config = E2eConfig.parse(args, Platform.environment, root);
    if (config.help) {
      stdout.writeln(
        'Local iOS E2E: e2e.sh [test|smoke|backend start|stop|migrate-config|reset]\n'
        '--device ID_OR_NAME --target authorization|areas|offline_banner|cold_start\n'
        '--tags TAG --repeat N --watch --develop --timeout-seconds N',
      );
      return;
    }
    lock = await RunLock.acquire(File('${root.path}/.dart_tool/e2e/run.lock'));
    if (lock.stale) {
      stdout.writeln(
        'Recovering stale runner ownership; readiness restores the route and reconciles journals',
      );
      final recovery = BackendFixture(config, ProcessRunner());
      try {
        await recovery.start();
        final journals = Directory('${root.path}/.dart_tool/e2e/ownership');
        if (journals.existsSync()) {
          for (final file in journals.listSync().whereType<File>().where(
            (file) => file.path.endsWith('.json'),
          )) {
            await OwnershipJournal.read(file).reconcile(recovery);
          }
        }
      } finally {
        recovery.close();
      }
    }
    if (config.command == 'backend') {
      final backend = BackendFixture(config, ProcessRunner());
      try {
        switch (config.backendCommand) {
          case 'start':
            await backend.start();
          case 'stop':
            await backend.stop();
          case 'migrate-config':
            await backend.migrateConfigVolume();
          case 'reset':
            await backend.reset(confirmed: config.confirmReset);
        }
      } finally {
        backend.close();
      }
      stdout.writeln('Backend ${config.backendCommand} complete');
      return;
    }
    if (config.command == 'smoke') {
      final backend = BackendFixture(config, ProcessRunner());
      try {
        await backend.start();
        await backend.smokeConnectionLoss();
      } finally {
        backend.close();
      }
      stdout.writeln(
        'Real WebSocket outage, independent CLI access, and recovery passed',
      );
      return;
    }
    exitCode = config.watch
        ? await watchRuns(root, () => runOrdinary(config, lock: lock))
        : await repeatRuns(
            config.repeat,
            () => runOrdinary(config, lock: lock),
          );
  } catch (error) {
    stderr.writeln(redact('$error', []));
    exitCode = 1;
  } finally {
    await lock?.release();
  }
}
