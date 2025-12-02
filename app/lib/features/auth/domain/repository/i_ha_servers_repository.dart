import 'package:hommie/features/common/domain/entities/ha_server.dart';

abstract class IHAServersRepository {
  Future<List<HaServer>> getAvailableServers();
}
