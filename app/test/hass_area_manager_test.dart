import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../integration_test/utils/hass_area_manager.dart';
import '../integration_test/utils/remote_hass_cli.dart';

void main() {
  test('parses Home Assistant area registry list response', () {
    final areas = HassAreaManager.parseAreas('''
{
  "id": 1,
  "type": "result",
  "success": true,
  "result": [
    {"area_id": "kitchen", "name": "Kitchen"},
    {"area_id": "office", "name": "Office"}
  ]
}
''');

    expect(areas.map((area) => area.areaId), ['kitchen', 'office']);
    expect(areas.map((area) => area.name), ['Kitchen', 'Office']);
  });

  test('finds an area by name', () {
    const area = HassTestArea(
      areaId: 'e2e_area_initial',
      name: 'E2E_Area_Initial',
    );

    expect(HassAreaManager.findByName([area], 'E2E_Area_Initial'), area);
    expect(HassAreaManager.findByName([area], 'Missing'), isNull);
  });

  test(
    'throws contextual error when area registry response is not successful',
    () {
      expect(
        () => HassAreaManager.parseAreas('''
{
  "id": 1,
  "type": "result",
  "success": false,
  "error": {"code": "unknown_error", "message": "boom"}
}
'''),
        throwsA(
          isA<FormatException>().having(
            (error) => error.message,
            'message',
            contains('successful area registry list response'),
          ),
        ),
      );
    },
  );

  test('list sends area registry list command', () async {
    final cli = _FakeRemoteHassCli([
      const CommandResult(
        stdout: '{"id":1,"type":"result","success":true,"result":[]}',
        stderr: '',
        exitCode: 0,
      ),
    ]);
    final manager = HassAreaManager(cli: cli);

    await manager.list();

    expect(cli.commands, ['raw ws config/area_registry/list']);
  });

  test('deleteById sends compact area registry delete command', () async {
    final cli = _FakeRemoteHassCli([
      const CommandResult(stdout: '{"success":true}', stderr: '', exitCode: 0),
    ]);
    final manager = HassAreaManager(cli: cli);

    await manager.deleteById('e2e_area_initial');

    expect(cli.commands, [
      'raw ws config/area_registry/delete --json={"area_id":"e2e_area_initial"}',
    ]);
  });

  test('delete failure includes area id in thrown message', () async {
    final cli = _FakeRemoteHassCli([
      const CommandResult(stdout: '', stderr: 'area not found', exitCode: 1),
    ]);
    final manager = HassAreaManager(cli: cli);

    expect(
      () => manager.deleteById('e2e_area_initial'),
      throwsA(
        isA<Exception>().having(
          (error) => error.toString(),
          'message',
          contains('e2e_area_initial'),
        ),
      ),
    );
  });

  test('cleanup deletes every deterministic area by name or area id', () async {
    final cli = _FakeRemoteHassCli([
      const CommandResult(
        stdout: '''
{
  "id": 1,
  "type": "result",
  "success": true,
  "result": [
    {"area_id": "e2e_area_initial", "name": "Interrupted Old Name"},
    {"area_id": "generated_1", "name": "E2E_Area_Initial"},
    {"area_id": "generated_2", "name": "E2E_Area_Renamed"},
    {"area_id": "living_room", "name": "Living Room"}
  ]
}
''',
        stderr: '',
        exitCode: 0,
      ),
      const CommandResult(stdout: '{"success":true}', stderr: '', exitCode: 0),
      const CommandResult(stdout: '{"success":true}', stderr: '', exitCode: 0),
      const CommandResult(stdout: '{"success":true}', stderr: '', exitCode: 0),
    ]);
    final manager = HassAreaManager(cli: cli);

    await manager.cleanupDeterministicAreas();

    expect(cli.commands, [
      'raw ws config/area_registry/list',
      'raw ws config/area_registry/delete --json={"area_id":"e2e_area_initial"}',
      'raw ws config/area_registry/delete --json={"area_id":"generated_1"}',
      'raw ws config/area_registry/delete --json={"area_id":"generated_2"}',
    ]);
  });
}

class _FakeRemoteHassCli implements RemoteHassCli {
  final List<CommandResult> _results;
  final commands = <String>[];

  _FakeRemoteHassCli(this._results);

  @override
  Future<Either<CommandError, CommandResult>> execute(String command) async {
    commands.add(command);
    return Right(_results.removeAt(0));
  }

  @override
  Future<void> initialize() async {}

  @override
  void setToken(String token) {}
}
