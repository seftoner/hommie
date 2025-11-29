import 'package:hommie/features/settings/domain/repository/i_device_info_repository.dart';
import 'package:hommie/features/settings/infrastructure/repositories/device_info_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_info_repository_provider.g.dart';

@riverpod
IDeviceInfoRepository deviceInfoRepository(Ref ref) {
  return DeviceInfoRepository();
}
