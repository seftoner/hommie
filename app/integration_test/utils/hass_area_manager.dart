import 'dart:convert';

import 'remote_hass_cli.dart';
import 'test_context.dart';

class HassTestArea {
  final String areaId;
  final String name;

  const HassTestArea({required this.areaId, required this.name});
}

class HassAreaManager {
  final RemoteHassCli _cli;

  static String get initialName => TestContext.instance().initialAreaName;
  static String get renamedName => TestContext.instance().renamedAreaName;

  HassAreaManager({RemoteHassCli? cli})
    : _cli = cli ?? RemoteHassCli.fromEnvironment();

  static List<HassTestArea> parseAreas(String stdout) {
    final response = jsonDecode(stdout);
    if (response is! Map<String, dynamic> ||
        response['success'] != true ||
        response['result'] is! List<dynamic>) {
      throw FormatException(
        'Expected successful area registry list response with result list',
        stdout,
      );
    }

    final result = response['result'] as List<dynamic>;

    return result
        .cast<Map<String, dynamic>>()
        .map(
          (area) => HassTestArea(
            areaId: area['area_id'] as String,
            name: area['name'] as String,
          ),
        )
        .toList();
  }

  static HassTestArea? findByName(List<HassTestArea> areas, String name) {
    for (final area in areas) {
      if (area.name == name) {
        return area;
      }
    }

    return null;
  }

  Future<List<HassTestArea>> list() async {
    final result = await _cli.execute([
      'raw',
      'ws',
      'config/area_registry/list',
    ]);

    return result.fold(
      (error) => throw Exception(
        'Failed to list areas: ${error.message}. ${error.error}',
      ),
      (success) {
        if (!success.isSuccess) {
          throw Exception('Failed to list areas: ${success.stderr}');
        }

        return parseAreas(success.stdout);
      },
    );
  }

  Future<HassTestArea?> findRemoteByName(String name) async {
    final areas = await list();
    return findByName(areas, name);
  }

  Future<bool> deleteByNameIfPresent(String name) async {
    final area = await findRemoteByName(name);
    if (area == null) {
      return false;
    }

    await deleteById(area.areaId);
    return true;
  }

  Future<void> cleanupOwnedAreas({
    required Set<String> ids,
    required Set<String> reservedNames,
  }) async {
    final areas = await list();
    for (final area in areas) {
      if (ids.contains(area.areaId) || reservedNames.contains(area.name)) {
        await deleteById(area.areaId);
      }
    }
  }

  Future<void> deleteById(String areaId) async {
    final command = [
      'raw',
      'ws',
      'config/area_registry/delete',
      '--json={"area_id":"$areaId"}',
    ];

    final result = await _cli.execute(command);

    return result.fold(
      (error) => throw Exception(
        'Failed to delete area $areaId: ${error.message}. ${error.error}',
      ),
      (success) {
        if (!success.isSuccess) {
          throw Exception('Failed to delete area $areaId: ${success.stderr}');
        }
        final response = jsonDecode(success.stdout);
        if (response is! Map || response['success'] != true) {
          throw Exception('Home Assistant rejected deletion of area $areaId');
        }
      },
    );
  }
}
