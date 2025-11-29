import 'package:hommie/features/home/domain/repositories/i_device_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/drift_device_repository.dart';
import 'package:hommie/core/infrastructure/database/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_repository_provider.g.dart';

@riverpod
IDeviceRepository deviceRepository(Ref ref) {
  final database = ref.read(databaseConnectionProvider);
  return DriftDeviceRepository(database);
}
