import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/home/application/home_tile_rebind_controller.dart';
import 'package:hommie/features/home/domain/entities/device.dart';
import 'package:hommie/features/home/domain/entities/home_tile.dart';
import 'package:hommie/features/home/domain/repositories/i_device_repository.dart';
import 'package:hommie/features/home/domain/repositories/i_home_tile_override_repository.dart';
import 'package:hommie/features/home/infrastructure/providers/device_repository_provider.dart';
import 'package:hommie/features/home/infrastructure/providers/home_tile_override_repository_provider.dart';

class _FakeHomeTileOverrideRepository implements IHomeTileOverrideRepository {
  final List<HomeTileOverride> overrides;
  final upserts = <({int serverId, HomeTileOverride override})>[];
  final removes = <({int serverId, HomeTileKind kind, String targetId})>[];

  _FakeHomeTileOverrideRepository(this.overrides);

  @override
  Stream<List<HomeTileOverride>> watchByServer(int serverId) {
    return Stream.value(overrides);
  }

  @override
  Future<List<HomeTileOverride>> getByServer(int serverId) async {
    return overrides;
  }

  @override
  Future<void> upsert({
    required int serverId,
    required HomeTileOverride override,
  }) async {
    upserts.add((serverId: serverId, override: override));
  }

  @override
  Future<void> remove({
    required int serverId,
    required HomeTileKind kind,
    required String targetId,
  }) async {
    removes.add((serverId: serverId, kind: kind, targetId: targetId));
  }
}

class _FakeDeviceRepository implements IDeviceRepository {
  final List<Device> devices;

  _FakeDeviceRepository(this.devices);

  @override
  Stream<List<Device>> watchByServer(int serverId) {
    return Stream.value(devices);
  }

  @override
  Future<List<Device>> getByServer(int serverId) async {
    return devices;
  }

  @override
  Future<Device?> getByHaId({
    required int serverId,
    required String haId,
  }) async {
    for (final device in devices) {
      if (device.id == haId) {
        return device;
      }
    }
    return null;
  }

  @override
  Future<List<Device>> getAll() async => devices;

  @override
  Future<Device?> getById(int id) async => null;

  @override
  Future<List<Device>> getByArea(int areaId) async => const [];

  @override
  Future<void> syncRegistry({
    required int serverId,
    required List<Device> devices,
  }) async {}

  @override
  Future<void> save(Device device) async {}

  @override
  Future<void> delete(int id) async {}
}

void main() {
  ProviderContainer makeContainer({
    required _FakeHomeTileOverrideRepository overrideRepository,
    required _FakeDeviceRepository deviceRepository,
  }) {
    return ProviderContainer(
      overrides: [
        serverScopeIdProvider.overrideWithValue(7),
        homeTileOverrideRepositoryProvider.overrideWithValue(
          overrideRepository,
        ),
        deviceRepositoryProvider.overrideWithValue(deviceRepository),
      ],
    );
  }

  test(
    'rebinds a missing device tile to a current device at area end',
    () async {
      final overrideRepository = _FakeHomeTileOverrideRepository(const [
        HomeTileOverride(
          kind: HomeTileKind.device,
          targetId: 'dev-missing',
          areaId: 'office',
          size: HomeTileSize.large,
          order: 1,
          lastKnownName: 'Old lamp',
          lastKnownAreaId: 'office',
        ),
        HomeTileOverride(
          kind: HomeTileKind.device,
          targetId: 'dev-existing',
          areaId: 'kitchen',
          size: HomeTileSize.small,
          order: 3,
        ),
      ]);
      final deviceRepository = _FakeDeviceRepository(const [
        Device(id: 'dev-existing', name: 'Existing lamp', areaId: 'kitchen'),
        Device(
          id: 'dev-replacement',
          name: 'Raw replacement',
          nameByUser: 'Counter lamp',
          areaId: 'kitchen',
        ),
      ]);
      final container = makeContainer(
        overrideRepository: overrideRepository,
        deviceRepository: deviceRepository,
      );
      addTearDown(container.dispose);

      await container
          .read(homeTileRebindControllerProvider.notifier)
          .rebindDevice(
            missingTargetId: 'dev-missing',
            replacementDeviceId: 'dev-replacement',
          );

      expect(overrideRepository.upserts, hasLength(1));
      final upsert = overrideRepository.upserts.single;
      expect(upsert.serverId, 7);
      expect(upsert.override.targetId, 'dev-replacement');
      expect(upsert.override.areaId, 'kitchen');
      expect(upsert.override.size, HomeTileSize.large);
      expect(upsert.override.order, 4);
      expect(upsert.override.lastKnownName, 'Counter lamp');
      expect(upsert.override.lastKnownAreaId, 'kitchen');

      expect(overrideRepository.removes, hasLength(1));
      final remove = overrideRepository.removes.single;
      expect(remove.serverId, 7);
      expect(remove.kind, HomeTileKind.device);
      expect(remove.targetId, 'dev-missing');
    },
  );

  test('removeTile deletes only the requested local override', () async {
    final overrideRepository = _FakeHomeTileOverrideRepository(const []);
    final deviceRepository = _FakeDeviceRepository(const []);
    final container = makeContainer(
      overrideRepository: overrideRepository,
      deviceRepository: deviceRepository,
    );
    addTearDown(container.dispose);

    await container
        .read(homeTileRebindControllerProvider.notifier)
        .removeTile(kind: HomeTileKind.device, targetId: 'dev-missing');

    expect(overrideRepository.upserts, isEmpty);
    expect(overrideRepository.removes, [
      (serverId: 7, kind: HomeTileKind.device, targetId: 'dev-missing'),
    ]);
  });
}
