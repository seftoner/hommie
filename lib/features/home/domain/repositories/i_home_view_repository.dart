import 'package:hommie/features/home/domain/entities/home_view.dart';

abstract interface class IHomeViewRepository {
  Future<HomeViewConf?> getByServerId(String serverId);
  Future<HomeViewConf> save(HomeViewConf conf);
  Future<void> delete(String serverId);
  Future<List<HomeViewConf>> getAll();
}
