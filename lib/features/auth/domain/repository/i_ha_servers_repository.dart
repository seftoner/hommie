import 'package:hommie/features/auth/domain/entities/ha_server.dart';

abstract class IHAServersRepository {
  Future<List<HaServer>> getAvailableServers();
}
