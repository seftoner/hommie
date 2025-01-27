import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/services/database/models/models.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

@riverpod
Isar databaseConnection(Ref ref) {
  throw UnimplementedError('You forgor to override it');
}

class DatabaseInitializer {
  static Future<Isar> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        AreaEntitySchema,
        DeviceEntitySchema,
        ServerEntitySchema,
        AreaHomeConfigSchema,
        HomeViewConfigSchema,
        DeviceHomeConfigSchema,
      ],
      directory: dir.path,
    );

    await isar.writeTxn(() async => isar.clear());

    // Populate test data if database is empty
    if ((await isar.serverEntitys.count()) == 0) {
      await _populateTestData(isar);
    }

    return isar;
  }

  static Future<void> _populateTestData(Isar isar) async {
    await isar.writeTxn(() async {
      // Create server
      final server =
          ServerEntity(name: 'Test Server', url: 'http://localhost:8123');
      await isar.serverEntitys.put(server);

      // Create areas with proper links
      final testAreas = [
        AreaEntity(haId: 'living_room', name: 'Living Room'),
        AreaEntity(haId: 'kitchen', name: 'Kitchen'),
        AreaEntity(haId: 'bedroom', name: 'Bedroom')
      ];
      await isar.areaEntitys.putAll(testAreas);

      // Set up server-area links
      for (final area in testAreas) {
        area.server.value = server;
        await area.server.save();
      }

      // Create devices with proper links
      final devices = [
        DeviceEntity(name: 'Main Light', haId: 'light.main', type: 'light')
          ..area.value = testAreas[0],
        DeviceEntity(name: 'TV', haId: 'media_player.tv', type: 'media_player')
          ..area.value = testAreas[0],
        DeviceEntity(name: 'Floor Lamp', haId: 'light.floor', type: 'light')
          ..area.value = testAreas[0],
        DeviceEntity(
            name: 'Smart Speaker',
            haId: 'media_player.speaker',
            type: 'media_player')
          ..area.value = testAreas[0],
        DeviceEntity(
            name: 'Kitchen Light', haId: 'light.kitchen', type: 'light')
          ..area.value = testAreas[1],
        DeviceEntity(
            name: 'Coffee Maker', haId: 'switch.coffee', type: 'switch')
          ..area.value = testAreas[1],
        DeviceEntity(
            name: 'Dishwasher', haId: 'switch.dishwasher', type: 'switch')
          ..area.value = testAreas[1],
        DeviceEntity(name: 'Kitchen Fan', haId: 'fan.kitchen', type: 'fan')
          ..area.value = testAreas[1],
        DeviceEntity(
            name: 'Bedroom Light', haId: 'light.bedroom', type: 'light')
          ..area.value = testAreas[2],
        DeviceEntity(name: 'AC', haId: 'climate.bedroom', type: 'climate')
          ..area.value = testAreas[2],
        DeviceEntity(name: 'Bedside Lamp', haId: 'light.bedside', type: 'light')
          ..area.value = testAreas[2],
        DeviceEntity(name: 'Air Purifier', haId: 'fan.purifier', type: 'fan')
          ..area.value = testAreas[2],
      ];
      await isar.deviceEntitys.putAll(devices);

      for (final device in devices) {
        await device.area.save();
      }

      // Create home view config with proper links
      final homeConfig = HomeViewConfig()..server.value = server;
      await isar.homeViewConfigs.put(homeConfig);
      await homeConfig.server.save();

      // Create area configs with proper links
      final areaConfigs = [
        AreaHomeConfig(position: 0)
          ..area.value = testAreas[0]
          ..homeConfig.value = homeConfig,
        AreaHomeConfig(position: 1)
          ..area.value = testAreas[1]
          ..homeConfig.value = homeConfig,
        AreaHomeConfig(position: 2)
          ..area.value = testAreas[2]
          ..homeConfig.value = homeConfig,
      ];
      await isar.areaHomeConfigs.putAll(areaConfigs);

      for (final areaConf in areaConfigs) {
        await areaConf.area.save();
        await areaConf.homeConfig.save();
      }

      // Create device configs
      final deviceConfigs = [
        DeviceHomeConfig(position: 0, size: DeviceDisplaySize.big)
          ..device.value = devices[0]
          ..areaConfig.value = areaConfigs[0],
        DeviceHomeConfig(position: 1)
          ..device.value = devices[1]
          ..areaConfig.value = areaConfigs[0],
        DeviceHomeConfig(position: 2)
          ..device.value = devices[2]
          ..areaConfig.value = areaConfigs[0],
        DeviceHomeConfig(position: 3)
          ..device.value = devices[3]
          ..areaConfig.value = areaConfigs[0],
        DeviceHomeConfig(position: 0)
          ..device.value = devices[4]
          ..areaConfig.value = areaConfigs[1],
        DeviceHomeConfig(position: 1, size: DeviceDisplaySize.big)
          ..device.value = devices[5]
          ..areaConfig.value = areaConfigs[1],
        DeviceHomeConfig(position: 2)
          ..device.value = devices[6]
          ..areaConfig.value = areaConfigs[1],
        DeviceHomeConfig(position: 3)
          ..device.value = devices[7]
          ..areaConfig.value = areaConfigs[1],
        DeviceHomeConfig(position: 0)
          ..device.value = devices[8]
          ..areaConfig.value = areaConfigs[2],
        DeviceHomeConfig(position: 1, size: DeviceDisplaySize.big)
          ..device.value = devices[9]
          ..areaConfig.value = areaConfigs[2],
        DeviceHomeConfig(position: 2)
          ..device.value = devices[10]
          ..areaConfig.value = areaConfigs[2],
        DeviceHomeConfig(position: 3)
          ..device.value = devices[11]
          ..areaConfig.value = areaConfigs[2],
      ];
      await isar.deviceHomeConfigs.putAll(deviceConfigs);

      for (final deviceConf in deviceConfigs) {
        await deviceConf.device.save();
        await deviceConf.areaConfig.save();
      }
    });
  }
}
