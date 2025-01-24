import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hommie/features/home/domain/repositories/i_device_repository.dart';
import 'package:hommie/features/home/infrastructure/repositories/isar_device_repository.dart';
import 'package:hommie/services/database/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_repository_provider.g.dart';

@riverpod
IDeviceRepository deviceRepository(Ref ref) {
  final isar = ref.read(databaseConnectionProvider);
  return IsarDeviceRepository(isar);
}
