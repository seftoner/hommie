import 'dart:io';

import 'e2e/config.dart';
import 'e2e/backend_fixture.dart';
import 'e2e/process_runner.dart';

Future<void> main(List<String> args) async {
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
    throw StateError('E2E ${config.command} is not implemented yet');
  } catch (error) {
    stderr.writeln(error);
    exitCode = 1;
  }
}
