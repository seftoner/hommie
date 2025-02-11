import 'package:hommie/features/server_manager/domain/models/server.dart';

abstract interface class IServerRepository {
  Future<List<Server>> getAll();
  Future<Server?> getById(int id);
  Future<Server> save(Server config);
  Future<void> delete(int id);
  Future<Server?> getActiveServer();
  Stream<Server?> watchActiveServer();
  Future<void> setActiveServer(int id);
}
