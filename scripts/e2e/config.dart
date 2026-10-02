import 'dart:io';

import 'package:boolean_selector/boolean_selector.dart';

class E2eConfig {
  final Directory repoRoot;
  final String command;
  final String? backendCommand, device, target, tags;
  final int repeat, haPort, bridgePort, proxyPort, controlPort;
  final Duration timeout;
  final bool watch, develop, help, confirmReset;
  String get platform => 'ios';
  Uri get appServerUrl => Uri.parse('http://127.0.0.1:$proxyPort');
  Uri get fixtureControlUrl => Uri.parse('http://127.0.0.1:$bridgePort');
  Uri get faultControlUrl => Uri.parse('http://127.0.0.1:$controlPort');
  E2eConfig._(
    this.repoRoot,
    this.command,
    this.backendCommand,
    this.device,
    this.target,
    this.tags,
    this.repeat,
    this.timeout,
    this.watch,
    this.develop,
    this.help,
    this.confirmReset,
    this.haPort,
    this.bridgePort,
    this.proxyPort,
    this.controlPort,
  );

  factory E2eConfig.parse(
    List<String> args,
    Map<String, String> env,
    Directory repoRoot,
  ) {
    var command = 'test';
    String? backend, device, target, tags;
    var repeat = 1, seconds = 1800;
    var watch = false, develop = false, help = false, confirm = false;
    var i = 0;
    if (args.isNotEmpty && !args.first.startsWith('-')) {
      command = args[i++];
      if (!['test', 'backend', 'smoke'].contains(command))
        throw const FormatException('Unknown E2E command');
      if (command == 'backend' && i < args.length) backend = args[i++];
    }
    String value(String flag) {
      if (i >= args.length) throw FormatException('$flag requires a value');
      return args[i++];
    }

    int positive(String text, String label, [int? max]) {
      final n = int.tryParse(text);
      if (n == null || n < 1 || (max != null && n > max))
        throw FormatException('Invalid $label');
      return n;
    }

    while (i < args.length) {
      final flag = args[i++];
      switch (flag) {
        case '--device':
          device = value(flag);
        case '--target':
          target = value(flag);
        case '--tags':
          tags = value(flag);
        case '--repeat':
          repeat = positive(value(flag), 'repeat count');
        case '--timeout-seconds':
          seconds = positive(value(flag), 'timeout');
        case '--watch':
          watch = true;
        case '--develop':
          develop = true;
        case '--help':
        case '-h':
          help = true;
        case '--confirm-test-data-reset':
          confirm = true;
        default:
          throw FormatException('Unknown option: $flag');
      }
    }
    if (target != null &&
        !RegExp(r'^(authorization|areas|offline_banner|cold_start)$')
            .hasMatch(target)) {
      throw const FormatException(
        'Target must be authorization, areas, offline_banner, or cold_start',
      );
    }
    if (tags != null) {
      final selector = BooleanSelector.parse(tags);
      if (selector.variables.any(
        (tag) =>
            tag == 'cold_seed' ||
            tag == 'cold_verify' ||
            tag == 'internal_cleanup',
      )) {
        throw const FormatException(
          'Select the logical cold_start pair; phase tags are internal',
        );
      }
    }
    if (develop &&
        (target == null || target == 'cold_start' || watch || repeat != 1)) {
      throw const FormatException(
        '--develop requires one ordinary target and cannot combine with watch/repeat',
      );
    }
    if (watch && repeat != 1)
      throw const FormatException('watch and repeat cannot be combined');
    if (command == 'backend' &&
        !help &&
        !['start', 'stop', 'reset', 'migrate-config'].contains(backend)) {
      throw const FormatException(
        'backend requires start, stop, migrate-config, or reset',
      );
    }
    int port(String key, int fallback) =>
        positive(env[key] ?? '$fallback', key, 65535);
    final ports = [
      port('E2E_HA_PORT', 8123),
      port('E2E_BRIDGE_PORT', 3000),
      port('E2E_PROXY_PORT', 18124),
      port('E2E_CONTROL_PORT', 18474),
    ];
    if (ports.toSet().length != 4)
      throw const FormatException('E2E ports must be distinct');
    return E2eConfig._(
      repoRoot,
      command,
      backend,
      device,
      target,
      tags,
      repeat,
      Duration(seconds: seconds),
      watch,
      develop,
      help,
      confirm,
      ports[0],
      ports[1],
      ports[2],
      ports[3],
    );
  }
}
