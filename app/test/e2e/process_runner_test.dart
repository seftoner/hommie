import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../scripts/e2e/process_runner.dart';

void main() {
  test(
    'develop input reaches the child while output remains capturable',
    () async {
      final output = <String>[];
      final result = await ProcessRunner(onOutput: output.add).run(
        '/bin/cat',
        [],
        cwd: Directory.systemTemp,
        timeout: const Duration(seconds: 5),
        input: Stream.value([114, 10]),
      );
      expect(result.stdout, 'r\n');
      expect(output.join(), 'r\n');
    },
  );
  test('deadline terminates descendants holding output pipes', () async {
    final dir = Directory.systemTemp.createTempSync('descendant');
    addTearDown(() => dir.deleteSync(recursive: true));
    final file = File('${dir.path}/child.pid');
    final runner = ProcessRunner();
    final elapsed = Stopwatch()..start();
    await expectLater(
      runner.run(
        '/usr/bin/python3',
        [
          '-c',
          'import subprocess,time,pathlib; p=subprocess.Popen(["/bin/sleep","60"]); pathlib.Path("${file.path}").write_text(str(p.pid)); time.sleep(60)',
        ],
        cwd: dir,
        timeout: const Duration(seconds: 1),
      ),
      throwsA(isA<ProcessTimeout>()),
    );
    expect(elapsed.elapsed, lessThan(const Duration(seconds: 5)));
    final child = int.parse(file.readAsStringSync());
    final alive = await Process.run('/bin/kill', ['-0', '$child']);
    expect(alive.exitCode, isNot(0));
  }, timeout: const Timeout(Duration(seconds: 10)));
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
