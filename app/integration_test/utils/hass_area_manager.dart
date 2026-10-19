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

  HassAreaManager({required this._cli});

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
      (success) => parseAreas(success.stdout),
    );
  }

  Future<HassTestArea?> findRemoteByName(String name) async {
    final areas = await list();
    return findByName(areas, name);
  }
}
