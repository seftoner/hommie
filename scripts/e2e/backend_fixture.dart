import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'config.dart';
import 'process_runner.dart';

class BackendFixture {
  static const project = 'homeassistant-test';
  static const volume = 'homeassistant-test_ha_config';
  final E2eConfig config;
  final ProcessRunner processes;
  final Duration readinessTimeout;
  final Uri directHaUrl, bridgeUrl;
  final HttpClient _http = HttpClient();
  Map<String, String>? _credentials;
  bool _cancelled = false;
  BackendFixture(
    this.config,
    this.processes, {
    this.readinessTimeout = const Duration(seconds: 180),
    Uri? directHaUrl,
    Uri? bridgeUrl,
  }) : directHaUrl =
           directHaUrl ?? Uri.parse('http://127.0.0.1:${config.haPort}'),
       bridgeUrl = bridgeUrl ?? config.fixtureControlUrl;
  Map<String, String> get credentials =>
      Map.unmodifiable(_credentials ?? _loadCredentials());
  Map<String, String> get _environment => {
    'E2E_HA_PORT': '${config.haPort}',
    'E2E_BRIDGE_PORT': '${config.bridgePort}',
    'E2E_PROXY_PORT': '${config.proxyPort}',
    'E2E_CONTROL_PORT': '${config.controlPort}',
  };
  Future<ProcessResult> _docker(List<String> args) => processes.run(
    'docker',
    args,
    cwd: config.repoRoot,
    timeout: const Duration(minutes: 5),
    environment: _environment,
  );
  Future<void> _compose(List<String> args) async {
    final r = await _docker([
      'compose',
      '-f',
      '${config.repoRoot.path}/docker/docker-compose.yml',
      '-p',
      project,
      ...args,
    ]);
    if (r.exitCode != 0)
      throw StateError(
        'Compose ${args.first} failed; inspect service diagnostics',
      );
  }

  Future<Map<String, dynamic>?> _configMount() async {
    final r = await _docker([
      'inspect',
      '--format',
      '{{json .Mounts}}',
      'homeassistant-test',
    ]);
    if (r.exitCode != 0) return null;
    return (jsonDecode(r.stdout as String) as List)
            .cast<Map<String, dynamic>>()
            .where((m) => m['Destination'] == '/config')
            .firstOrNull ??
        {'Type': 'container', 'Name': 'container-writable-config'};
  }

  Future<void> start() async {
    final mount = await _configMount();
    if (mount != null && mount['Name'] != volume) {
      throw StateError(
        'Existing HA /config requires backend migrate-config; no data was reset',
      );
    }
    final r = await _docker([
      'compose',
      '-f',
      '${config.repoRoot.path}/docker/docker-compose.yml',
      '-p',
      project,
      'ps',
      '--status',
      'running',
      '--format',
      '{{.Service}}',
    ]);
    final running = (r.stdout as String)
        .split('\n')
        .map((s) => s.trim())
        .toSet();
    final missing = [
      'homeassistant',
      'hass-cli-web',
      'toxiproxy',
    ].where((s) => !running.contains(s)).toList();
    if (missing.isNotEmpty)
      await _compose(['up', '-d', '--no-deps', ...missing]);
    await waitUntilReady();
    await reconcileProxy();
  }

  Future<void> stop() => _compose(['stop']);
  Future<void> reset({required bool confirmed}) async {
    if (!confirmed)
      throw StateError('Reset requires --confirm-test-data-reset');
    final lock = File('${config.repoRoot.path}/.dart_tool/e2e/run.lock');
    if (lock.existsSync()) {
      final state = jsonDecode(await lock.readAsString()) as Map;
      if (state['status'] == 'active' && state['pid'] != pid)
        throw StateError('Cannot reset during an E2E run');
    }
    await _compose(['down']);
    final r = await _docker(['volume', 'rm', volume]);
    if (r.exitCode != 0)
      throw StateError(
        'Named test volume was not removed; retained credentials',
      );
    for (final path in [
      'app/.patrol.env',
      'docker/hass_init_conf/.env',
      'docker/hass_init_conf/.initialized',
    ]) {
      final f = File('${config.repoRoot.path}/$path');
      if (f.existsSync()) await f.delete();
    }
  }

  Future<void> migrateConfigVolume() async {
    final mount = await _configMount();
    if (mount == null || mount['Name'] == volume) {
      await start();
      final record = File(
        '${config.repoRoot.path}/.dart_tool/e2e/volume-migration.json',
      );
      if (record.existsSync()) {
        final data =
            jsonDecode(await record.readAsString()) as Map<String, dynamic>;
        await record.writeAsString(jsonEncode({...data, 'verified': true}));
      }
      return;
    }
    if (!['volume', 'container'].contains(mount['Type']))
      throw StateError('Unsupported HA config storage; migrate explicitly');
    final source = mount['Name'] as String;
    if (!RegExp(r'^[a-zA-Z0-9_.-]+$').hasMatch(source))
      throw StateError('Invalid source volume name');
    // Prove credentials against the original instance before any maintenance.
    _credentials = _loadCredentials();
    await _request(
      'GET',
      directHaUrl.resolve('/api/'),
      headers: {'Authorization': 'Bearer ${_credentials!['HASS_TOKEN']}'},
    );
    final image = await _docker([
      'inspect',
      '--format',
      '{{.Image}}',
      'homeassistant-test',
    ]);
    if (image.exitCode != 0)
      throw StateError('Cannot identify existing HA image');
    await _compose(['stop']);
    String copySource = source;
    String? backupImage;
    if (mount['Type'] == 'container') {
      final stamp = DateTime.now().millisecondsSinceEpoch;
      final backup = Directory(
        '${config.repoRoot.path}/.dart_tool/e2e/config-backup-$stamp',
      );
      await backup.create(recursive: true);
      await processes.run(
        'chmod',
        ['700', backup.path],
        cwd: config.repoRoot,
        timeout: const Duration(seconds: 5),
      );
      final snapshot = await _docker([
        'commit',
        'homeassistant-test',
        'hommie-e2e-ha-rollback:$stamp',
      ]);
      if (snapshot.exitCode != 0)
        throw StateError(
          'Could not preserve original HA container; stopped instance retained',
        );
      backupImage = (snapshot.stdout as String).trim();
      final exported = await _docker([
        'cp',
        'homeassistant-test:/config/.',
        backup.path,
      ]);
      if (exported.exitCode != 0)
        throw StateError('Could not export config; rollback snapshot retained');
      copySource = backup.path;
    }
    final created = await _docker(['volume', 'create', volume]);
    if (created.exitCode != 0)
      throw StateError('Could not create named test volume');
    final copied = await _docker([
      'run',
      '--rm',
      '--network',
      'none',
      '--entrypoint',
      'sh',
      '-v',
      '$copySource:/source:ro',
      '-v',
      '$volume:/target',
      (image.stdout as String).trim(),
      '-c',
      'test -z "\$(ls -A /target)" && cp -a /source/. /target/ && cmp /source/.storage/auth /target/.storage/auth && touch /target/.hommie-e2e-initialized',
    ]);
    if (copied.exitCode != 0)
      throw StateError(
        'Migration copy failed; original volume retained, do not reset',
      );
    final record = File(
      '${config.repoRoot.path}/.dart_tool/e2e/volume-migration.json',
    );
    await record.parent.create(recursive: true);
    final rollback = {
      'source': source,
      'backupPath': copySource,
      'rollbackImage': backupImage,
      'target': volume,
      'verified': false,
    };
    await record.writeAsString(jsonEncode(rollback));
    await _writeCredentials();
    await _compose(['up', '-d']);
    await waitUntilReady();
    await reconcileProxy();
    await record.writeAsString(jsonEncode({...rollback, 'verified': true}));
  }

  Map<String, String> _loadCredentials() {
    final values = <String, String>{
      'HASS_USERNAME': 'admin',
      'HASS_PASSWORD': 'yourpassword',
    };
    for (final path in ['app/.patrol.env', 'docker/hass_init_conf/.env']) {
      final f = File('${config.repoRoot.path}/$path');
      if (!f.existsSync()) continue;
      for (final line in f.readAsLinesSync()) {
        final i = line.indexOf('=');
        if (i < 1) continue;
        final key = line.substring(0, i);
        if (['HASS_TOKEN', 'HASS_USERNAME', 'HASS_PASSWORD'].contains(key))
          values[key] = line.substring(i + 1).trim();
      }
    }
    if (values['HASS_TOKEN']?.isNotEmpty != true)
      throw StateError(
        'Missing management credentials for existing fixture; repair credentials without resetting HA',
      );
    return values;
  }

  Future<void> _writeCredentials() async {
    for (final path in ['app/.patrol.env', 'docker/hass_init_conf/.env']) {
      final f = File('${config.repoRoot.path}/$path');
      await f.parent.create(recursive: true);
      final tmp = File('${f.path}.tmp');
      await tmp.writeAsString(
        credentials.entries.map((e) => '${e.key}=${e.value}').join('\n') + '\n',
      );
      final permissions = await Process.run('chmod', ['600', tmp.path]);
      if (permissions.exitCode != 0)
        throw StateError('Cannot protect fixture credential file');
      await tmp.rename(f.path);
    }
  }

  Future<Object?> _request(
    String method,
    Uri url, {
    Object? body,
    Map<String, String> headers = const {},
  }) async {
    if (_cancelled) throw StateError('Fixture operation was interrupted');
    final req = await _http
        .openUrl(method, url)
        .timeout(const Duration(seconds: 5));
    headers.forEach(req.headers.set);
    if (body != null) {
      req.headers.contentType = ContentType.json;
      req.write(jsonEncode(body));
    }
    final res = await req.close().timeout(const Duration(seconds: 25));
    final text = await utf8.decoder
        .bind(res)
        .join()
        .timeout(const Duration(seconds: 5));
    if (res.statusCode < 200 || res.statusCode >= 300)
      throw StateError('HTTP ${res.statusCode} at ${url.path}');
    return text.isEmpty ? null : jsonDecode(text);
  }

  Future<Object?> cliWs(String type, {Map<String, Object?>? payload}) async {
    final response = await _request(
      'POST',
      bridgeUrl.resolve('/cli'),
      body: {
        'args': [
          'raw',
          'ws',
          type,
          if (payload != null) '--json=${jsonEncode(payload)}',
        ],
        'token': credentials['HASS_TOKEN'],
      },
    );
    if (response is! Map || response['exit_code'] != 0)
      throw StateError('Fixture CLI failed for $type');
    final result = jsonDecode(response['stdout'] as String);
    if (result is! Map || result['success'] != true)
      throw StateError('HA rejected $type');
    return result['result'];
  }

  Future<void> waitUntilReady() async {
    final end = DateTime.now().add(readinessTimeout);
    String stage = 'credentials';
    while (true) {
      try {
        _credentials = _loadCredentials();
        final headers = {
          'Authorization': 'Bearer ${credentials['HASS_TOKEN']}',
        };
        stage = 'HA authentication';
        await _request('GET', directHaUrl.resolve('/api/'), headers: headers);
        stage = 'bridge health';
        await _request('GET', bridgeUrl.resolve('/health'));
        stage = 'area registry WebSocket';
        final areas = await cliWs('config/area_registry/list');
        if (areas is! List) throw StateError('Invalid area registry response');
        for (final fixture in {
          'kitchen': 'Kitchen',
          'living_room': 'Living Room',
          'bedroom': 'Bedroom',
        }.entries) {
          if (!areas.any(
            (a) =>
                a is Map &&
                (a['area_id'] == fixture.key || a['name'] == fixture.value),
          )) {
            await cliWs(
              'config/area_registry/create',
              payload: {'name': fixture.value},
            );
          }
        }
        stage = 'light.kitchen_light';
        await _request(
          'GET',
          directHaUrl.resolve('/api/states/light.kitchen_light'),
          headers: headers,
        );
        await _writeCredentials();
        return;
      } catch (_) {
        if (_cancelled) rethrow;
        if (DateTime.now().isAfter(end))
          throw StateError(
            'Fixture readiness timed out at $stage; credentials retained, HA not reset',
          );
        await Future<void>.delayed(const Duration(milliseconds: 100));
      }
    }
  }

  Future<void> cancel() async {
    _cancelled = true;
    _http.close(force: true);
    await processes.cancel();
  }

  Future<void> reconcileProxy() async {
    final routes = await _request(
      'GET',
      config.faultControlUrl.resolve('/proxies'),
    );
    final body = {
      'name': 'hommie_ha',
      'listen': '0.0.0.0:18124',
      'upstream': 'homeassistant:8123',
      'enabled': true,
    };
    final exists = routes is Map && routes.containsKey('hommie_ha');
    await _request(
      'POST',
      config.faultControlUrl.resolve(
        exists ? '/proxies/hommie_ha' : '/proxies',
      ),
      body: body,
    );
  }

  Future<void> setRouteEnabled(bool enabled) => _request(
    'POST',
    config.faultControlUrl.resolve('/proxies/hommie_ha'),
    body: {'enabled': enabled},
  );
  void close() => _http.close(force: true);
  Future<void> smokeConnectionLoss() async {
    WebSocket? socket;
    StreamIterator<dynamic>? events;
    Future<WebSocket> connect() => WebSocket.connect(
      config.appServerUrl
          .replace(scheme: 'ws', path: '/api/websocket')
          .toString(),
    ).timeout(const Duration(seconds: 5));
    Future<void> authenticate(WebSocket ws, StreamIterator<dynamic> it) async {
      if (!await it.moveNext().timeout(const Duration(seconds: 5)))
        throw StateError('Missing WS auth challenge');
      ws.add(
        jsonEncode({'type': 'auth', 'access_token': credentials['HASS_TOKEN']}),
      );
      if (!await it.moveNext().timeout(const Duration(seconds: 5)) ||
          jsonDecode(it.current as String)['type'] != 'auth_ok')
        throw StateError('Proxy WebSocket auth failed');
    }

    await reconcileProxy();
    try {
      socket = await connect();
      events = StreamIterator(socket);
      await authenticate(socket, events);
      await setRouteEnabled(false);
      if (await events.moveNext().timeout(const Duration(seconds: 5)))
        throw StateError('Established socket did not terminate');
      var rejected = false;
      try {
        final unexpected = await connect();
        await unexpected.close();
      } catch (_) {
        rejected = true;
      }
      if (!rejected)
        throw StateError('Disabled route accepted a new connection');
      await cliWs('config/area_registry/list');
      await setRouteEnabled(true);
      final restored = await connect();
      final restoredEvents = StreamIterator(restored);
      try {
        await authenticate(restored, restoredEvents);
      } finally {
        await restoredEvents.cancel();
        await restored.close();
      }
    } finally {
      await setRouteEnabled(true);
      await events?.cancel();
      await socket?.close();
    }
  }
}
