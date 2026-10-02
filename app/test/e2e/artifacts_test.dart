import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../scripts/e2e/artifacts.dart';

void main() {
  test(
    'native text export is scrubbed and binary attachments excluded',
    () async {
      final dir = Directory.systemTemp.createTempSync('native-export');
      addTearDown(() => dir.deleteSync(recursive: true));
      final bundle = Directory('${dir.path}/private/report.xcresult')
        ..createSync(recursive: true);
      final artifact = RunArtifacts(
        Directory('${dir.path}/share'),
        ['native-password'],
        exporter: (exe, args) async {
          if (args.contains('diagnostics')) {
            final output = args[args.indexOf('--output-path') + 1];
            File('$output/native.log').writeAsStringSync(
              'Typed native-password; {"refresh_token":"new-token"}',
            );
            File('$output/credential-screen.png')
                .writeAsStringSync('native-password');
          }
          return ProcessResult(0, 0, '{"failure":"native-password"}', '');
        },
      );
      await artifact.capture(
        runId: 'run',
        exitCode: 7,
        nativeResults: [bundle],
        metadata: {},
      );
      final files = artifact.directory.listSync().whereType<File>().toList();
      expect(files.any((file) => file.path.endsWith('.png')), isFalse);
      for (final file in files) {
        expect(file.readAsStringSync(), isNot(contains('native-password')));
        expect(file.readAsStringSync(), isNot(contains('new-token')));
      }
    },
  );
  test('failed native export reports a capture failure', () async {
    final dir = Directory.systemTemp.createTempSync('failed-export');
    addTearDown(() => dir.deleteSync(recursive: true));
    final bundle = Directory('${dir.path}/report.xcresult')..createSync();
    final artifact = RunArtifacts(
      Directory('${dir.path}/share'),
      [],
      exporter: (exe, args) async => ProcessResult(0, 7, '', 'failed'),
    );
    await expectLater(
      artifact.capture(
        runId: 'run',
        exitCode: 7,
        nativeResults: [bundle],
        metadata: {},
      ),
      throwsStateError,
    );
  });
  test('redacts credentials in output and errors including split streams', () {
    final redactor = LogRedactor(['sentinel-password', 'sentinel-token']);
    final parts = <String>[];
    parts.add(redactor.add('text sentinel-pass'));
    parts.add(redactor.add('word\nAuthorization: Bearer sentinel-token\n'));
    parts.add(redactor.finish());
    expect(parts.join(), isNot(contains('sentinel')));
    expect(
      redact('{"access_token":"unknown-sensitive-value"}', []),
      isNot(contains('unknown-sensitive-value')),
    );
  });
  test('original native bundles remain private; metadata and exported text scrubbed', () async {
    final dir = Directory.systemTemp.createTempSync('artifacts');
    addTearDown(() => dir.deleteSync(recursive: true));
    final bundle = Directory('${dir.path}/private/report.xcresult')
      ..createSync(recursive: true);
    final artifacts = RunArtifacts(Directory('${dir.path}/shareable'), [
      'secret-pass',
    ]);
    await artifacts.capture(
      runId: 'run',
      exitCode: 7,
      nativeResults: [bundle],
      metadata: {'error': 'secret-pass'},
    );
    expect(
      Directory('${dir.path}/shareable/report.xcresult').existsSync(),
      isFalse,
    );
    expect(
      File('${dir.path}/shareable/metadata.json').readAsStringSync(),
      isNot(contains('secret-pass')),
    );
    expect(
      File('${dir.path}/shareable/metadata.json').readAsStringSync(),
      contains(bundle.path),
    );
  });
}
