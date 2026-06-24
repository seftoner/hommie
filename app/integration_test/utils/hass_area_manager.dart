import 'dart:convert';

import 'remote_hass_cli.dart';

class HassTestArea {
  final String areaId;
  final String name;

  const HassTestArea({required this.areaId, required this.name});
}

class HassAreaManager {
  final RemoteHassCli _cli;

  static const initialName = 'E2E_Area_Initial';
  static const renamedName = 'E2E_Area_Renamed';
  static const _initialAreaId = 'e2e_area_initial';
  static const _renamedAreaId = 'e2e_area_renamed';

  HassAreaManager({RemoteHassCli? cli}) : _cli = cli ?? RemoteHassCli();

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
    final result = await _cli.execute('raw ws config/area_registry/list');

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

  Future<void> cleanupDeterministicAreas() async {
    final areas = await list();
    for (final area in areas) {
      if (_isDeterministicArea(area)) {
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
    ].join(' ');

    final result = await _cli.execute(command);

    return result.fold(
      (error) => throw Exception(
        'Failed to delete area $areaId: ${error.message}. ${error.error}',
      ),
      (success) {
        if (!success.isSuccess) {
          throw Exception('Failed to delete area $areaId: ${success.stderr}');
        }
      },
    );
  }

  static bool _isDeterministicArea(HassTestArea area) {
    return area.areaId == _initialAreaId ||
        area.areaId == _renamedAreaId ||
        area.name == initialName ||
        area.name == renamedName;
  }
}
