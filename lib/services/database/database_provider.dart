import 'package:hommie/services/database/models/models.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
class DatabaseConnection extends _$DatabaseConnection {
  @override
  Future<Isar> build() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        AreaSchema,
        DeviceSchema,
        HaServerSchema,
        AreaHomeConfigSchema,
        HomeViewConfigSchema,
        DeviceHomeConfigSchema,
      ],
      directory: dir.path,
    );

    // Populate test data if database is empty
    if ((await isar.haServers.count()) == 0) {
      await _populateTestData(isar);
    }

    return isar;
  }

  Future<void> _populateTestData(Isar isar) async {
    await isar.writeTxn(() async {
      // Create server
      final server =
          HaServer(name: 'Test Server', uri: 'http://localhost:8123');
      await isar.haServers.put(server);

      // Create areas with proper links
      final testAreas = [
        Area(haId: 'living_room', name: 'Living Room'),
        Area(haId: 'kitchen', name: 'Kitchen'),
        Area(haId: 'bedroom', name: 'Bedroom')
      ];
      await isar.areas.putAll(testAreas);

      // Set up server-area links
      for (final area in testAreas) {
        area.haServer.value = server;
        await area.haServer.save();
      }

      // Create devices with proper links
      final devices = [
        Device(name: 'Main Light', haId: 'light.main', type: 'light')
          ..area.value = testAreas[0],
        Device(name: 'TV', haId: 'media_player.tv', type: 'media_player')
          ..area.value = testAreas[0],
        Device(name: 'Floor Lamp', haId: 'light.floor', type: 'light')
          ..area.value = testAreas[0],
        Device(
            name: 'Smart Speaker',
            haId: 'media_player.speaker',
            type: 'media_player')
          ..area.value = testAreas[0],
        Device(name: 'Kitchen Light', haId: 'light.kitchen', type: 'light')
          ..area.value = testAreas[1],
        Device(name: 'Coffee Maker', haId: 'switch.coffee', type: 'switch')
          ..area.value = testAreas[1],
        Device(name: 'Dishwasher', haId: 'switch.dishwasher', type: 'switch')
          ..area.value = testAreas[1],
        Device(name: 'Kitchen Fan', haId: 'fan.kitchen', type: 'fan')
          ..area.value = testAreas[1],
        Device(name: 'Bedroom Light', haId: 'light.bedroom', type: 'light')
          ..area.value = testAreas[2],
        Device(name: 'AC', haId: 'climate.bedroom', type: 'climate')
          ..area.value = testAreas[2],
        Device(name: 'Bedside Lamp', haId: 'light.bedside', type: 'light')
          ..area.value = testAreas[2],
        Device(name: 'Air Purifier', haId: 'fan.purifier', type: 'fan')
          ..area.value = testAreas[2],
      ];
      await isar.devices.putAll(devices);

      for (final device in devices) {
        await device.area.save();
      }

      // Create home view config with proper links
      final homeConfig = HomeViewConfig()..haServer.value = server;
      await isar.homeViewConfigs.put(homeConfig);
      await homeConfig.haServer.save();

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
