import 'package:hommie/features/auth/domain/repository/i_ha_servers_repository.dart';
import 'package:hommie/features/common/domain/entities/ha_server.dart';

/// Controls discovery input while the app keeps its real UI, cache and login.
class DiscoveryFixture implements IHAServersRepository {
  List<HaServer> _servers = const [];

  void setServers(List<HaServer> servers) {
    _servers = List.unmodifiable(servers);
  }

  void clear() => _servers = const [];

  @override
  Future<List<HaServer>> getAvailableServers() async => _servers;
}
