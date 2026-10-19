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

    expect(cli.commands, [
      ['raw', 'ws', 'config/area_registry/list'],
    ]);
  });
}

class _FakeRemoteHassCli extends RemoteHassCli {
  final List<CommandResult> _results;
  final commands = <List<String>>[];

  _FakeRemoteHassCli(this._results)
    : super(
        fixtureControlUrl: Uri.parse('http://localhost'),
        managementToken: 'test',
      );

  @override
  Future<Either<CommandError, CommandResult>> execute(
    List<String> command,
  ) async {
    commands.add(command);
    return Right(_results.removeAt(0));
  }
}
