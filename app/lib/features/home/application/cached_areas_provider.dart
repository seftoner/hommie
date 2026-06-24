import 'dart:async';

import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/home/application/areas_for_server_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cached_areas_provider.g.dart';

@Riverpod(dependencies: [serverScopeId, areasForServer])
Stream<List<Area>> cachedAreas(Ref ref) {
  final serverId = ref.watch(serverScopeIdProvider);
  final controller = StreamController<List<Area>>();

  final subscription = ref.listen(areasForServerProvider(serverId), (_, next) {
    next.when(data: controller.add, error: controller.addError, loading: () {});
  }, fireImmediately: true);

  ref.onDispose(() {
    subscription.close();
    controller.close();
  });

  return controller.stream;
}
