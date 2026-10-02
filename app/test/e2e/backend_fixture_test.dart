import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../scripts/e2e/backend_fixture.dart';
import '../../../scripts/e2e/config.dart';
import '../../../scripts/e2e/process_runner.dart';

void main() {
  for (final failure in ['credentials', 'authentication', 'bridge']) {
    test(
      '$failure failure preserves populated fixture and redacts secrets',
      () async {
        final root = Directory.systemTemp.createTempSync('fixture failure');
        addTearDown(() => root.deleteSync(recursive: true));
        if (failure != 'credentials') {
          File('${root.path}/app/.patrol.env')
            ..createSync(recursive: true)
            ..writeAsStringSync('HASS_TOKEN=sentinel-secret');
        }
        final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        addTearDown(() => server.close(force: true));
        server.listen((request) async {
          request.response.statusCode = failure == 'authentication'
              ? 401
              : request.uri.path == '/health'
              ? 503
              : 200;
          request.response.write('{}');
          await request.response.close();
        });
        final processes = _Processes([]);
        final backend = BackendFixture(
          E2eConfig.parse([], {}, root),
          processes,
          directHaUrl: Uri.parse('http://127.0.0.1:${server.port}'),
          bridgeUrl: Uri.parse('http://127.0.0.1:${server.port}'),
          readinessTimeout: const Duration(milliseconds: 50),
        );
        addTearDown(backend.close);
        await expectLater(
          backend.waitUntilReady(),
          throwsA(
            predicate(
              (e) =>
                  e.toString().contains('not reset') &&
                  !e.toString().contains('sentinel-secret'),
            ),
          ),
        );
        expect(processes.calls, isEmpty);
      },
    );
  }
  for (final state in ['absent', 'disabled', 'misconfigured']) {
    test('proxy preflight repairs a $state route', () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close(force: true));
      final mutations = <Map<String, dynamic>>[];
      server.listen((request) async {
        if (request.method == 'GET') {
          request.response.write(
            jsonEncode(
              state == 'absent'
                  ? {}
                  : {
                      'hommie_ha': {'enabled': false, 'upstream': 'wrong:8123'},
                    },
            ),
          );
        } else {
          expect(
            request.uri.path,
            state == 'absent' ? '/proxies' : '/proxies/hommie_ha',
          );
          mutations.add(jsonDecode(await utf8.decoder.bind(request).join()));
          request.response.write(jsonEncode(mutations.last));
        }
        await request.response.close();
      });
      final backend = BackendFixture(
        E2eConfig.parse([], {
          'E2E_CONTROL_PORT': '${server.port}',
        }, Directory('/tmp')),
        _Processes([]),
      );
      addTearDown(backend.close);
      await backend.reconcileProxy();
      expect(mutations.single, {
        'name': 'hommie_ha',
        'listen': '0.0.0.0:18124',
        'upstream': 'homeassistant:8123',
        'enabled': true,
      });
    });
  }
  test(
    'readiness seeds missing fixture areas while preserving existing areas',
    () async {
      final root = Directory.systemTemp.createTempSync('fixture seed');
      addTearDown(() => root.deleteSync(recursive: true));
      File('${root.path}/app/.patrol.env')
        ..createSync(recursive: true)
        ..writeAsStringSync('HASS_TOKEN=sentinel');
      final areas = <Map<String, Object>>[
        {'area_id': 'custom', 'name': 'Existing room'},
      ];
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close(force: true));
      server.listen((request) async {
        if (request.uri.path == '/cli') {
          final body = jsonDecode(await utf8.decoder.bind(request).join());
          final args = (body['args'] as List).cast<String>();
          Object? result;
          if (args[2] == 'config/area_registry/list')
            result = areas;
          else if (args[2] == 'config/area_registry/create') {
            final payload = jsonDecode(args[3].substring(7));
            final name = payload['name'] as String;
            final area = {
              'area_id': name.toLowerCase().replaceAll(' ', '_'),
              'name': name,
            };
            areas.add(area);
            result = area;
          } else {
            fail('Unexpected fixture mutation');
          }
          request.response.write(
            jsonEncode({
              'exit_code': 0,
              'stdout': jsonEncode({'success': true, 'result': result}),
              'stderr': '',
            }),
          );
        } else {
          request.response.write('{}');
        }
        await request.response.close();
      });
      final url = Uri.parse('http://127.0.0.1:${server.port}');
      final backend = BackendFixture(
        E2eConfig.parse([], {}, root),
        _Processes([]),
        directHaUrl: url,
        bridgeUrl: url,
        readinessTimeout: const Duration(milliseconds: 100),
      );
      await backend.waitUntilReady();
      expect(areas.first, {'area_id': 'custom', 'name': 'Existing room'});
      expect(
        areas.map((a) => a['name']),
        containsAll(['Kitchen', 'Living Room', 'Bedroom']),
      );
      await backend.waitUntilReady();
      expect(areas.length, 4);
    },
  );
  test(
    'container-writable config refuses routine start until safely migrated',
    () async {
      final processes = _Processes([ProcessResult(1, 0, '[]', '')]);
      await expectLater(
        BackendFixture(
          E2eConfig.parse([], {}, Directory('/tmp')),
          processes,
        ).start(),
        throwsA(predicate((e) => e.toString().contains('migrate-config'))),
      );
      expect(processes.calls.length, 1);
    },
  );
  test(
    'populated anonymous volume refuses routine start without resetting data',
    () async {
      final root = Directory.systemTemp.createTempSync('backend test');
      addTearDown(() => root.deleteSync(recursive: true));
      final processes = _Processes([
        ProcessResult(
          1,
          0,
          jsonEncode([
            {
              'Type': 'volume',
              'Destination': '/config',
              'Name': 'old-anonymous-volume',
            },
          ]),
          '',
        ),
      ]);
      final backend = BackendFixture(E2eConfig.parse([], {}, root), processes);
      await expectLater(
        backend.start(),
        throwsA(predicate((e) => e.toString().contains('migrate-config'))),
      );
      expect(processes.calls.any((args) => args.contains('down')), isFalse);
      expect(processes.calls.any((args) => args.contains('up')), isFalse);
    },
  );
  test('normal stop preserves data, credentials and markers', () async {
    final root = Directory.systemTemp.createTempSync('backend test');
    addTearDown(() => root.deleteSync(recursive: true));
    final env = File('${root.path}/app/.patrol.env')
      ..createSync(recursive: true)
      ..writeAsStringSync('HASS_TOKEN=sentinel');
    final processes = _Processes([ProcessResult(1, 0, '', '')]);
    await BackendFixture(E2eConfig.parse([], {}, root), processes).stop();
    expect(env.existsSync(), isTrue);
    expect(processes.calls.single, contains('stop'));
    expect(processes.calls.single, isNot(contains('--volumes')));
  });
  test('reset requires explicit confirmation before any command', () async {
    final processes = _Processes([]);
    await expectLater(
      BackendFixture(
        E2eConfig.parse([], {}, Directory('/tmp')),
        processes,
      ).reset(confirmed: false),
      throwsStateError,
    );
    expect(processes.calls, isEmpty);
  });
  test(
    'readiness checks authenticated services and missing light fails boundedly',
    () async {
      final root = Directory.systemTemp.createTempSync('backend test');
      addTearDown(() => root.deleteSync(recursive: true));
      File('${root.path}/app/.patrol.env')
        ..createSync(recursive: true)
        ..writeAsStringSync('HASS_TOKEN=sentinel');
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close(force: true));
      server.listen((request) async {
        if (request.uri.path == '/api/') {
          expect(request.headers.value('Authorization'), 'Bearer sentinel');
          request.response.write('{}');
        } else if (request.uri.path == '/health') {
          request.response.write('{"status":"ok"}');
        } else if (request.uri.path == '/cli') {
          request.response.write(
            jsonEncode({
              'exit_code': 0,
              'stdout': '{"success":true,"result":[{"area_id":"kitchen"}]}',
              'stderr': '',
            }),
          );
        } else {
          request.response.statusCode = 404;
        }
        await request.response.close();
      });
      final config = E2eConfig.parse([], {
        'E2E_HA_PORT': '${server.port}',
        'E2E_BRIDGE_PORT': '${server.port + 1}',
      }, root);
      final backend = BackendFixture(
        config,
        _Processes([]),
        readinessTimeout: const Duration(milliseconds: 80),
        directHaUrl: Uri.parse('http://127.0.0.1:${server.port}'),
        bridgeUrl: Uri.parse('http://127.0.0.1:${server.port}'),
      );
      await expectLater(
        backend.waitUntilReady(),
        throwsA(
          predicate(
            (e) =>
                e.toString().contains('light.kitchen_light') &&
                !e.toString().contains('sentinel'),
          ),
        ),
      );
    },
  );
}

class _Processes extends ProcessRunner {
  final List<ProcessResult> results;
  final List<List<String>> calls = [];
  _Processes(this.results);
  @override
  Future<ProcessResult> run(
    String executable,
    List<String> args, {
    required Directory cwd,
    required Duration timeout,
    Map<String, String>? environment,
    Stream<List<int>>? input,
  }) async {
    calls.add(args);
    return results.removeAt(0);
  }
}
