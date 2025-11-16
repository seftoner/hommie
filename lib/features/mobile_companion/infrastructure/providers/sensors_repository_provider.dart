import 'package:hommie/features/mobile_companion/battery_sensor_provider.dart';
import 'package:hommie/features/mobile_companion/connection_state_provider.dart';
import 'package:hommie/features/mobile_companion/domain/repositories/i_sensors_repository.dart';
import 'package:hommie/features/mobile_companion/infrastructure/repositories/mobile_companion_sensors_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sensors_repository_provider.g.dart';

@Riverpod(keepAlive: true)
ISensorsRepository sensorsRepository(Ref ref) {
  final repository = MobileCompanionSensorsRepository(
    providers: [BatterySensorProvider(), ConnectionStateProvider()],
  );
  ref.onDispose(repository.dispose);
  return repository;
}
