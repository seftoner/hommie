import 'package:hommie/features/home/domain/entities/home_view.dart';

abstract interface class IHomeViewRepository {
  Future<HomeViewConf?> get();
  Future<HomeViewConf> save(HomeViewConf conf);
  Future<void> delete();
}
