import 'dart:convert';
import 'dart:io';

import 'process_runner.dart';

class SimulatorDevice {
  final String id, name, runtime;
  final bool booted;
  SimulatorDevice(this.id, this.name, this.runtime, this.booted);
}

class IosSimulator {
  final Directory root;
  final ProcessRunner processes;
  IosSimulator(this.root, this.processes);
  Future<ProcessResult> _run(List<String> args) => processes.run(
    'xcrun',
    ['simctl', ...args],
    cwd: root,
    timeout: const Duration(minutes: 3),
  );
  Future<SimulatorDevice> select({String? device}) async {
    final result = await _run(['list', '--json']);
    if (result.exitCode != 0)
      throw StateError('Cannot list iOS Simulators; check Xcode/CoreSimulator');
    final inventory = jsonDecode(result.stdout as String) as Map;
    final runtimes = {
      for (final runtime in inventory['runtimes'] as List)
        if (runtime['isAvailable'] == true)
          runtime['identifier'] as String: runtime['version'] as String,
    };
    final candidates = <SimulatorDevice>[];
    for (final entry in (inventory['devices'] as Map).entries) {
      if (!runtimes.containsKey(entry.key)) continue;
      for (final raw in entry.value as List) {
        if (raw['isAvailable'] == true &&
            (raw['name'] as String).startsWith('iPhone'))
          candidates.add(
            SimulatorDevice(
              raw['udid'],
              raw['name'],
              entry.key,
              raw['state'] == 'Booted',
            ),
          );
      }
    }
    int compareVersion(String a, String b) {
      final av = a.split('.').map(int.parse).toList(),
          bv = b.split('.').map(int.parse).toList();
      for (var i = 0; i < 3; i++) {
        final difference = (i < bv.length ? bv[i] : 0).compareTo(
          i < av.length ? av[i] : 0,
        );
        if (difference != 0) return difference;
      }
      return 0;
    }

    candidates.sort((a, b) {
      if (device == null && a.booted != b.booted) return a.booted ? -1 : 1;
      final runtime = compareVersion(
        runtimes[a.runtime]!,
        runtimes[b.runtime]!,
      );
      if (runtime != 0) return runtime;
      final name = a.name.compareTo(b.name);
      return name != 0 ? name : a.id.compareTo(b.id);
    });
    final matches = candidates
        .where((d) => device == null || d.id == device || d.name == device)
        .toList();
    if (matches.isEmpty)
      throw StateError(
        device == null
            ? 'No available iPhone Simulator; install an iOS runtime'
            : 'Selected iPhone Simulator is unavailable: $device',
      );
    return matches.first;
  }

  Future<void> bootAndWait(SimulatorDevice device) async {
    if (!device.booted && (await _run(['boot', device.id])).exitCode != 0)
      throw StateError('Cannot boot ${device.name}');
    if ((await _run(['bootstatus', device.id, '-b'])).exitCode != 0)
      throw StateError('Simulator ${device.name} did not become ready');
  }
}
