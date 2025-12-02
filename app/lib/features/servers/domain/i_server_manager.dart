import 'package:hommie/features/servers/domain/entities/server.dart';

abstract interface class IServerManager {
  Future<Server> addServer(Server config);
  Future<void> removeServer(int id, {bool allowRemovingLast = false});
  Future<List<Server>> getServers();
  Future<Server?> getActiveServer();
  Stream<Server?> watchActiveServer();
  Future<Server?> activateServer(int id);
  Future<Server?> activateNextServer({int? excludingId});
}
