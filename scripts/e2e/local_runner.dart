import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:boolean_selector/boolean_selector.dart';

import 'artifacts.dart';
import 'backend_fixture.dart';
import 'cold_start.dart';
import 'config.dart';
import 'ownership_journal.dart';
import 'patrol_cli.dart';
import 'patrol_runner.dart';
import 'process_runner.dart';
import 'simulator.dart';
import 'lifecycle.dart';

Future<int> runOrdinary(E2eConfig config, {RunLock? lock}) async {
  final runId = 'run_${DateTime.now().microsecondsSinceEpoch}';
  await lock?.recordRun(runId);
  final duration = Stopwatch()..start();
  final stageDurations = <String, int>{};
  final console = StringBuffer();
  final secrets = <String>[];
  final nativeResults = <Directory>[];
  final nativeDirectory = Directory('${config.repoRoot.path}/app/build');
  Set<String> nativePaths() => nativeDirectory.existsSync()
      ? nativeDirectory
            .listSync()
            .whereType<Directory>()
            .where(
              (directory) =>
                  RegExp(r'/ios_results_\d+\.xcresult$')
                      .hasMatch(directory.path),
            )
            .map((directory) => directory.path)
            .toSet()
      : {};
  final nativeBeforeRun = nativePaths();
  final metadata = <String, Object?>{
    'target': config.target ?? 'all',
    'tags': config.tags,
    'patrolPackage': '4.10.0',
    'patrolCli': '4.8.0',
    'platform': 'ios',
  };
  final errors = <String>[];
  final artifacts = RunArtifacts(
    Directory('${config.repoRoot.path}/artifacts/e2e/$runId'),
    secrets,
    exporter: (exe, args) => ProcessRunner().run(
      exe,
      args,
      cwd: config.repoRoot,
      timeout: const Duration(minutes: 2),
    ),
  );
  void output(String raw) {
    final safe = redact(raw, secrets);
    console.write(safe);
    stdout.write(safe);
    for (final match in RegExp(r'Report:\s*(.+?\.xcresult)').allMatches(raw)) {
      final result = Directory(match[1]!.trim());
      if (result.existsSync() &&
          !nativeResults.any((d) => d.path == result.path))
        nativeResults.add(result);
    }
  }

  final processes = ProcessRunner(onOutput: output);
  final quietProcesses = ProcessRunner();
  final backendProcesses = ProcessRunner();
  final backend = BackendFixture(config, backendProcesses);
  final simulator = IosSimulator(config.repoRoot, quietProcesses);
  OwnershipJournal? journal;
  File? defines;
  SimulatorDevice? device;
  var code = 1;
  var interrupted = 0;
  var patrolStarted = false;
  Future<void>? cancellation;
  Future<void> interrupt(int value) {
    interrupted = interrupted == 0 ? value : interrupted;
    return cancellation ??= () async {
      if (device != null) {
        try {
          final image = await IosSimulator(
            config.repoRoot,
            ProcessRunner(),
          ).captureNativeImage(device, runId);
          metadata['privateInterruptionScreenshot'] = image.path;
        } catch (e) {
          errors.add('Interruption image: $e');
        }
      }
      await Future.wait([
        processes.cancel(),
        quietProcesses.cancel(),
        backend.cancel(),
      ]);
    }();
  }

  void check() {
    if (interrupted != 0)
      throw StateError('E2E run interrupted ($interrupted)');
  }

  final signalSubscriptions = [
    ProcessSignal.sigint.watch().listen((_) {
      unawaited(interrupt(130));
    }),
    ProcessSignal.sigterm.watch().listen((_) {
      unawaited(interrupt(143));
    }),
  ];
  final deadline = Timer(config.timeout, () {
    stderr.writeln('E2E whole-run deadline exceeded');
    unawaited(interrupt(124));
  });
  Future<T> stage<T>(String name, Future<T> Function() action) async {
    check();
    final elapsed = Stopwatch()..start();
    try {
      final result = await action();
      check();
      return result;
    } finally {
      stageDurations[name] = elapsed.elapsedMilliseconds;
    }
  }

  try {
    await stage('backend', backend.start);
    secrets.addAll(backend.credentials.values.where((v) => v.isNotEmpty));
    final selectedDevice = await stage(
      'simulator selection',
      () => simulator.select(device: config.device),
    );
    device = selectedDevice;
    metadata['device'] = {
      'id': selectedDevice.id,
      'name': selectedDevice.name,
      'runtime': selectedDevice.runtime,
    };
    output('iOS Simulator: ${selectedDevice.name} (${selectedDevice.id})\n');
    await stage('simulator boot', () => simulator.bootAndWait(device!));
    final tools = await stage(
      'toolchain',
      () => quietProcesses.run(
        'flutter',
        ['--version', '--machine'],
        cwd: config.repoRoot,
        timeout: const Duration(minutes: 1),
      ),
    );
    if (tools.exitCode != 0) throw StateError('Flutter toolchain check failed');
    metadata['flutter'] = jsonDecode(tools.stdout as String);
    final directory = Directory(
      '${config.repoRoot.path}/.dart_tool/e2e/ownership',
    );
    await stage('ownership reconciliation', () async {
      if (directory.existsSync()) {
        for (final file in directory.listSync().whereType<File>().where(
          (f) => f.path.endsWith('.json'),
        )) {
          await OwnershipJournal.read(file).reconcile(backend);
        }
      }
    });
    final generation = await stage(
      'BDD generation',
      () => processes.run(
        'dart',
        ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
        cwd: Directory('${config.repoRoot.path}/app'),
        timeout: const Duration(minutes: 5),
      ),
    );
    if (generation.exitCode != 0) throw StateError('BDD generation failed');
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
    final patrol = PatrolRunner(
      PatrolCli(config.repoRoot, processes),
      timeout: config.timeout,
    );
    final ordinary = config.target == null
        ? ['authorization', 'areas', 'offline_banner']
        : config.target == 'cold_start'
        ? <String>[]
        : [config.target!];
    code = 0;
    if (ordinary.isNotEmpty) {
      patrolStarted = true;
      code = await stage(
        'ordinary tests',
        () => patrol.runTargets(
          ordinary,
          device: device!,
          defines: defines!,
          tags: config.tags,
          develop: config.develop,
          preserveApp: true,
        ),
      );
    }
    final coldSelected =
        (config.target == null || config.target == 'cold_start') &&
        (config.tags == null ||
            BooleanSelector.parse(config.tags!)
                .evaluate((tag) => tag == 'cold_start'));
    if (code == 0 && coldSelected) {
      patrolStarted = true;
      code = await stage(
        'cold pair',
        () => ColdStartRunner(
          phase: (phase, file) => patrol.runTargets(
            ['cold_start_$phase'],
            device: device!,
            defines: file,
            preserveApp: true,
          ),
          checkpoint: () async {
            final file = await simulator.checkpointFile(device!);
            final value = jsonDecode(await file.readAsString()) as Map;
            if (value['runId'] != runId || value['pid'] is! int)
              throw StateError('Invalid cold seed checkpoint');
            metadata['coldSeed'] = value;
            output(
              'Cold seed persisted: PID ${value['pid']}, entity ${value['entityId']}\n',
            );
          },
          terminate: () async {
            await simulator.terminateAndVerify(device!);
            metadata['terminatedAt'] = DateTime.now().toUtc().toIso8601String();
          },
          route: backend.setRouteEnabled,
          // Outer cleanup uses a fresh client even after cancellation closes preflight requests.
          cleanup: () async {},
        ).run(defines: defines!),
      );
      if (code == 0) {
        final file = await simulator.checkpointFile(device);
        final value = jsonDecode(await file.readAsString()) as Map;
        if (value['runId'] != runId ||
            value['verifyPid'] is! int ||
            value['verifyPid'] == value['pid']) {
          throw StateError('Cold verify process proof is missing');
        }
        metadata['coldProof'] = value;
        output('Cold process proof: ${value['pid']} → ${value['verifyPid']}\n');
        await file.delete();
      }
    }
  } catch (error, stack) {
    code = interrupted != 0 ? interrupted : 1;
    metadata['primaryError'] = redact('$error\n$stack', secrets);
    stderr.writeln(redact('$error', secrets));
  } finally {
    deadline.cancel();
    for (final subscription in signalSubscriptions) {
      await subscription.cancel();
    }
    if (cancellation != null) {
      try {
        await cancellation;
      } catch (e) {
        errors.add('Child cancellation: $e');
      }
    }
    if (interrupted != 0) code = interrupted;
    final cleanupBackend = BackendFixture(config, ProcessRunner());
    try {
      await cleanupBackend.setRouteEnabled(true);
    } catch (e) {
      errors.add('Proxy restoration: $e');
    }
    // A killed native runner cannot execute Dart teardown. Reset actual SQLite/Keychain in an internal recovery process.
    if (code != 0 &&
        patrolStarted &&
        defines != null &&
        device != null &&
        defines.existsSync()) {
      output(
        'Cleaning persisted app state after interrupted/failed native execution\n',
      );
      try {
        final values = jsonDecode(await defines.readAsString()) as Map;
        values['E2E_COLD_PHASE'] = 'cleanup';
        await defines.writeAsString(jsonEncode(values), flush: true);
        final recovery = PatrolRunner(
          PatrolCli(config.repoRoot, ProcessRunner(onOutput: output)),
          timeout: const Duration(minutes: 4),
        );
        final result = await recovery.runTargets(
          ['cleanup'],
          device: device,
          defines: defines,
          preserveApp: true,
        );
        if (result != 0)
          throw StateError(
            'Native persisted-state cleanup failed; next run must repair',
          );
        try {
          final checkpoint = await IosSimulator(
            config.repoRoot,
            ProcessRunner(),
          ).checkpointFile(device);
          await checkpoint.delete();
        } catch (_) {}
      } catch (e) {
        errors.add('App state recovery: $e');
      }
    }
    if (device != null) {
      try {
        final images = await IosSimulator(
          config.repoRoot,
          ProcessRunner(),
        ).retainFailureImages(device, runId);
        metadata['privateFailureScreenshots'] = images
            .map((file) => file.path)
            .toList();
      } catch (e) {
        errors.add('Failure image capture: $e');
      }
    }
    if (journal != null) {
      try {
        await journal.reconcile(cleanupBackend);
      } catch (e) {
        errors.add('Ownership cleanup: $e; journal retained');
      }
    }
    if (defines?.existsSync() == true) {
      try {
        await defines!.delete();
      } catch (e) {
        errors.add('Private defines cleanup: $e');
      }
    }
    cleanupBackend.close();
    backend.close();
    // A killed CLI may never print its report path. With exclusive ownership,
    // newly created bundles are this invocation's results, not a newest stale report.
    for (final path in nativePaths().difference(nativeBeforeRun)) {
      if (!nativeResults.any((result) => result.path == path))
        nativeResults.add(Directory(path));
    }
    // Capture exact bundles from this invocation; originals remain private in ignored build storage.
    try {
      final logs = await ProcessRunner().run(
        'docker',
        [
          'compose',
          '-f',
          '${config.repoRoot.path}/docker/docker-compose.yml',
          '-p',
          BackendFixture.project,
          'logs',
          '--no-color',
          '--tail',
          '300',
        ],
        cwd: config.repoRoot,
        timeout: const Duration(seconds: 30),
      );
      await artifacts.write('backend.log', '${logs.stdout}\n${logs.stderr}');
      if (logs.exitCode != 0) errors.add('Backend log capture failed');
    } catch (e) {
      errors.add('Backend log capture: $e');
    }
    if (errors.isNotEmpty && code == 0) code = 1;
    metadata['cleanupErrors'] = errors;
    metadata['stageDurationsMs'] = stageDurations;
    metadata['totalDurationMs'] = duration.elapsedMilliseconds;
    try {
      await artifacts.write('runner.log', console.toString());
      await artifacts.capture(
        runId: runId,
        exitCode: code,
        nativeResults: nativeResults,
        metadata: metadata,
      );
    } catch (e) {
      errors.add('Artifact capture: $e');
      if (code == 0) code = 1;
      stderr.writeln(redact('Artifact capture failed: $e', secrets));
      try {
        await artifacts.write(
          'metadata.json',
          jsonEncode({
            ...metadata,
            'runId': runId,
            'exitCode': code,
            'cleanupErrors': errors,
            'privateNativeResults': nativeResults
                .map((result) => result.path)
                .toList(),
          }),
        );
      } catch (_) {
        stderr.writeln('Artifact metadata could not be saved');
      }
    }
    for (final error in errors) {
      stderr.writeln(redact(error, secrets));
    }
    stdout.writeln('E2E evidence: ${artifacts.directory.path} (exit $code)');
  }
  return code;
}
