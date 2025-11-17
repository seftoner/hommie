import 'package:device_info_plus/device_info_plus.dart';
import 'package:hommie/features/settings/domain/repository/i_device_info_repository.dart';

class DeviceInfoRepository implements IDeviceInfoRepository {
  DeviceInfoRepository() : _deviceInfoPlugin = DeviceInfoPlugin();

  final DeviceInfoPlugin _deviceInfoPlugin;

  @override
  Future<String> getDeviceName() async {
    final deviceInfo = await _deviceInfoPlugin.deviceInfo;

    return switch (deviceInfo) {
      final IosDeviceInfo iosInfo => iosInfo.name,
      final MacOsDeviceInfo macInfo => macInfo.computerName,
      final LinuxDeviceInfo linuxInfo => linuxInfo.prettyName,
      final WindowsDeviceInfo windowsInfo => windowsInfo.computerName,
      final AndroidDeviceInfo androidInfo => androidInfo.name,
      final WebBrowserInfo webInfo => webInfo.userAgent ?? 'This device',
      _ => 'This device',
    };
  }
}
