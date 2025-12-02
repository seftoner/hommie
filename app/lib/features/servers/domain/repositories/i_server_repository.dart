import 'package:hommie/features/servers/domain/entities/server.dart';

abstract interface class IServerRepository {
  Future<List<Server>> getAll();
  Future<Server?> getById(int id);
  Future<Server> save(Server config);
  Future<void> delete(int id);
  Future<Server?> getActiveServer();
  Future<Server?> setActiveServer(int? id);
}
