import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../scripts/e2e/backend_fixture.dart';
import '../../../scripts/e2e/config.dart';
import '../../../scripts/e2e/process_runner.dart';
import '../../../scripts/e2e/ownership_journal.dart';

void main() {
  test(
    'crash reconciliation retains baseline and unrelated resources',
    () async {
      final fixture = _Fixture();
      final root = Directory.systemTemp.createTempSync('ownership');
      addTearDown(() => root.deleteSync(recursive: true));
      final journal = await OwnershipJournal.create(fixture, root, 'run1');
      fixture.tokens.addAll([
        {'id': 'owned', 'client_name': 'Hommie E2E run1 scenario1'},
        {'id': 'foreign', 'client_name': 'Other client'},
      ]);
      fixture.areas.addAll([
        {'area_id': 'owned-area', 'name': 'Hommie E2E run1 scenario1 Initial'},
        {'area_id': 'keep-area', 'name': 'Kitchen'},
      ]);
      final restored = OwnershipJournal.read(journal.file);
      await restored.reconcile(fixture);
      expect(fixture.deletedTokens, ['owned']);
      expect(fixture.deletedAreas, ['owned-area']);
      expect(journal.file.existsSync(), isFalse);
    },
  );
  test('ambiguous OAuth difference is retained for repair', () async {
    final fixture = _Fixture();
    final root = Directory.systemTemp.createTempSync('ownership');
    addTearDown(() => root.deleteSync(recursive: true));
    final journal = await OwnershipJournal.create(fixture, root, 'run2');
    fixture.tokens.addAll([
      for (final id in ['one', 'two'])
        {'id': id, 'client_id': 'https://seftoner.github.io'},
    ]);
    await expectLater(journal.reconcile(fixture), throwsStateError);
    expect(fixture.deletedTokens, isEmpty);
    expect(journal.file.existsSync(), isTrue);
  });
}

class _Fixture extends BackendFixture {
  final tokens = <Map<String, Object?>>[
    {'id': 'management', 'client_name': 'Admin'},
  ];
  final areas = <Map<String, Object?>>[];
  final deletedTokens = <String>[], deletedAreas = <String>[];
  _Fixture()
    : super(E2eConfig.parse([], {}, Directory('/tmp')), ProcessRunner());
  @override
  Future<Object?> cliWs(String type, {Map<String, Object?>? payload}) async {
    switch (type) {
      case 'auth/current_user':
        return {'id': 'test-user'};
      case 'auth/refresh_tokens':
        return tokens;
      case 'config/area_registry/list':
        return areas;
      case 'auth/delete_refresh_token':
        deletedTokens.add(payload!['refresh_token_id'] as String);
        return null;
      case 'config/area_registry/delete':
        deletedAreas.add(payload!['area_id'] as String);
        return null;
      default:
        throw StateError('Unexpected mutation');
    }
  }
}
