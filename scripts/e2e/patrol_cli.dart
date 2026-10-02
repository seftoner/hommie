import 'dart:convert';
import 'dart:io';

import 'process_runner.dart';

/// A pinned CLI in a private cache, without changing Flutter's normal PUB_CACHE.
class PatrolCli {
  final Directory root;
  final ProcessRunner processes;
  PatrolCli(this.root, this.processes);
  Future<ProcessResult> run(
    List<String> args, {
    Duration timeout = const Duration(minutes: 30),
  }) async {
    final cache = Directory('${root.path}/.dart_tool/e2e/pub-cache');
    final packageConfig = File(
      '${cache.path}/global_packages/patrol_cli/.dart_tool/package_config.json',
    );
    if (!packageConfig.existsSync()) {
      final result = await processes.run(
        'dart',
        ['pub', 'global', 'activate', 'patrol_cli', '4.8.0'],
        cwd: root,
        timeout: const Duration(minutes: 5),
        environment: {'PUB_CACHE': cache.path},
      );
      if (result.exitCode != 0)
        throw StateError('Cannot resolve Patrol CLI 4.8.0: ${result.stderr}');
    }
    final config =
        jsonDecode(await packageConfig.readAsString()) as Map<String, dynamic>;
    final entry = (config['packages'] as List)
        .cast<Map<String, dynamic>>()
        .singleWhere((p) => p['name'] == 'patrol_cli');
    final packageRoot = Directory.fromUri(
      packageConfig.uri.resolve(entry['rootUri'] as String),
    ).uri;
    final manifest = await File.fromUri(packageRoot.resolve('pubspec.yaml'))
        .readAsString();
    if (!RegExp(
      r'^version:\s*4\.8\.0(?:\s|$)',
      multiLine: true,
    ).hasMatch(manifest))
      throw StateError('Private Patrol cache has an unexpected version');
    return processes.run(
      'dart',
      [
        '--packages=${packageConfig.path}',
        File.fromUri(packageRoot.resolve('bin/main.dart')).path,
        ...args,
      ],
      cwd: Directory('${root.path}/app'),
      timeout: timeout,
    );
  }
}
