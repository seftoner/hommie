import 'dart:convert';
import 'dart:io';

String redact(String text, Iterable<String> secrets) {
  for (final secret
      in secrets.where((s) => s.isNotEmpty).toList()
        ..sort((a, b) => b.length.compareTo(a.length))) {
    text = text.replaceAll(secret, '[REDACTED]');
  }
  text = text.replaceAll(
    RegExp(r'eyJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+'),
    '[REDACTED_TOKEN]',
  );
  text = text.replaceAllMapped(
    RegExp(
      r'''("(?:access_token|refresh_token|password|authorization|client_secret)"\s*:\s*")[^"]*(")''',
      caseSensitive: false,
    ),
    (m) => '${m[1]}[REDACTED]${m[2]}',
  );
  text = text.replaceAll(
    RegExp(r'Bearer\s+[^\s"\x27]+', caseSensitive: false),
    'Bearer [REDACTED]',
  );
  text = text.replaceAll(
    RegExp(r'([?&](?:code|access_token|refresh_token)=)[^&\s]+'),
    '[REDACTED_QUERY]',
  );
  return text;
}

/// Buffer full lines so chunk boundaries cannot split a credential into a leak.
class LogRedactor {
  final Iterable<String> secrets;
  String _pending = '';
  LogRedactor(this.secrets);
  String add(String chunk) {
    _pending += chunk;
    final last = _pending.lastIndexOf('\n');
    if (last < 0) return '';
    final output = _pending.substring(0, last + 1);
    _pending = _pending.substring(last + 1);
    return redact(output, secrets);
  }

  String finish() {
    final output = redact(_pending, secrets);
    _pending = '';
    return output;
  }
}

class RunArtifacts {
  final Directory directory;
  final Iterable<String> secrets;
  final Future<ProcessResult> Function(String, List<String>)? exporter;
  RunArtifacts(this.directory, this.secrets, {this.exporter});
  Future<void> write(String name, String value) async {
    await directory.create(recursive: true);
    await File('${directory.path}/$name')
        .writeAsString(redact(value, secrets), flush: true);
  }

  Future<void> capture({
    required String runId,
    required int exitCode,
    required List<FileSystemEntity> nativeResults,
    required Map<String, Object?> metadata,
  }) async {
    await write(
      'metadata.json',
      const JsonEncoder.withIndent('  ').convert({
        ...metadata,
        'runId': runId,
        'exitCode': exitCode,
        'privateNativeResults': nativeResults.map((r) => r.path).toList(),
      }),
    );
    if (exporter == null) return;
    for (var i = 0; i < nativeResults.length; i++) {
      final result = nativeResults[i];
      await Process.run('chmod', ['700', result.path]);
      final issues = await exporter!('xcrun', [
        'xcresulttool',
        'get',
        'test-results',
        'summary',
        '--path',
        result.path,
      ]);
      if (issues.exitCode != 0)
        throw StateError('Native result summary export failed');
      await write('native-$i-summary.json', issues.stdout as String);
      final temp = await Directory.systemTemp.createTemp(
        'hommie-private-diagnostics',
      );
      await Process.run('chmod', ['700', temp.path]);
      try {
        final diagnostics = await exporter!('xcrun', [
          'xcresulttool',
          'export',
          'diagnostics',
          '--path',
          result.path,
          '--output-path',
          temp.path,
        ]);
        if (diagnostics.exitCode != 0)
          throw StateError('Native diagnostics export failed');
        var n = 0;
        for (final file in temp.listSync(recursive: true).whereType<File>()) {
          // Export text only. Native screenshots/attachments may contain typed credentials.
          if (!['.txt', '.log', '.json'].any(file.path.endsWith)) continue;
          final text = utf8.decode(
            await file.readAsBytes(),
            allowMalformed: true,
          );
          await write('native-$i-diagnostic-${n++}.txt', text);
        }
      } finally {
        await temp.delete(recursive: true);
      }
    }
  }
}
