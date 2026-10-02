import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../scripts/e2e/process_runner.dart';

void main() {
  test(
    'arguments containing spaces are passed without shell interpretation',
    () async {
      final result = await ProcessRunner().run(
        '/bin/echo',
        ['a b', r'$(false)'],
        cwd: Directory.systemTemp,
        timeout: const Duration(seconds: 5),
      );
      expect(result.stdout, 'a b \$(false)\n');
    },
  );
  test('a hanging process is terminated at its deadline', () async {
    final runner = ProcessRunner();
    final timer = Stopwatch()..start();
    await expectLater(
      runner.run(
        '/bin/sleep',
        ['60'],
        cwd: Directory.systemTemp,
        timeout: const Duration(milliseconds: 100),
      ),
      throwsA(isA<ProcessTimeout>()),
    );
    expect(timer.elapsed, lessThan(const Duration(seconds: 5)));
    expect(runner.activeCount, 0);
  });
  test('child failure propagates its actual exit code', () async {
    final result = await ProcessRunner().run(
      '/bin/sh',
      ['-c', 'exit 7'],
      cwd: Directory.systemTemp,
      timeout: const Duration(seconds: 5),
    );
    expect(result.exitCode, 7);
  });
}
