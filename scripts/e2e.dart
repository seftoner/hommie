import 'dart:io';

import 'e2e/config.dart';

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
    throw StateError('E2E ${config.command} is not implemented yet');
  } catch (error) {
    stderr.writeln(error);
    exitCode = 1;
  }
}
