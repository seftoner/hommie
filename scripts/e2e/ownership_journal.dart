import 'dart:convert';
import 'dart:io';

import 'backend_fixture.dart';

class OwnershipJournal {
  final File file;
  final String runId, userId;
  final Set<String> baselineTokenIds;
  static const clientId = 'https://seftoner.github.io';
  String get namespace => 'Hommie E2E $runId ';
  OwnershipJournal._(this.file, this.runId, this.userId, this.baselineTokenIds);
  static Future<OwnershipJournal> create(
    BackendFixture fixture,
    Directory directory,
    String runId,
  ) async {
    if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(runId))
      throw ArgumentError('Invalid run ID');
    await directory.create(recursive: true);
    final tokens = await fixture.cliWs('auth/refresh_tokens') as List;
    final user = await fixture.cliWs('auth/current_user') as Map;
    final file = File('${directory.path}/$runId.json');
    if (file.existsSync())
      throw StateError('Ownership journal already exists; reconcile it first');
    final journal = OwnershipJournal._(
      file,
      runId,
      user['id'] as String,
      tokens.map((t) => t['id'] as String).toSet(),
    );
    final temporary = File('${file.path}.tmp');
    await temporary.writeAsString(
      jsonEncode({
        'runId': runId,
        'namespace': journal.namespace,
        'userId': journal.userId,
        'clientId': clientId,
        'baselineTokenIds': journal.baselineTokenIds.toList(),
        'startedAt': DateTime.now().toUtc().toIso8601String(),
      }),
      flush: true,
    );
    await temporary.rename(file.path);
    return journal;
  }

  factory OwnershipJournal.read(File file) {
    final data = jsonDecode(file.readAsStringSync()) as Map;
    final runId = data['runId'] as String;
    if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(runId) ||
        data['namespace'] != 'Hommie E2E $runId ' ||
        data['clientId'] != clientId)
      throw StateError('Invalid ownership journal');
    return OwnershipJournal._(
      file,
      runId,
      data['userId'] as String,
      (data['baselineTokenIds'] as List).cast<String>().toSet(),
    );
  }
  Future<void> reconcile(BackendFixture fixture) async {
    final user = await fixture.cliWs('auth/current_user') as Map;
    if (user['id'] != userId)
      throw StateError('Ownership user differs; repair required');
    final tokens = await fixture.cliWs('auth/refresh_tokens') as List;
    final oauth = tokens
        .where(
          (t) =>
              !baselineTokenIds.contains(t['id']) && t['client_id'] == clientId,
        )
        .toList();
    final areas = await fixture.cliWs('config/area_registry/list') as List;
    final failures = <String>[];
    if (oauth.length > 1) failures.add('ambiguous OAuth session');
    final ownedTokens = tokens
        .where(
          (t) =>
              !baselineTokenIds.contains(t['id']) &&
              t['client_name'] is String &&
              (t['client_name'] as String).startsWith(namespace),
        )
        .toList();
    if (oauth.length == 1) ownedTokens.add(oauth.single);
    for (final token in ownedTokens) {
      try {
        await fixture.cliWs(
          'auth/delete_refresh_token',
          payload: {'refresh_token_id': token['id']},
        );
      } catch (_) {
        failures.add('owned token cleanup');
      }
    }
    for (final area in areas.where(
      (a) => a['name'] is String && (a['name'] as String).startsWith(namespace),
    )) {
      try {
        await fixture.cliWs(
          'config/area_registry/delete',
          payload: {'area_id': area['area_id']},
        );
      } catch (_) {
        failures.add('owned area cleanup');
      }
    }
    if (failures.isNotEmpty)
      throw StateError(
        'Ownership repair required: ${failures.join(', ')}; journal retained',
      );
    if (file.existsSync()) await file.delete();
  }
}
