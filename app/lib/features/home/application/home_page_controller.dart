import 'dart:async';

import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/home/application/cached_areas_provider.dart';
import 'package:hommie/features/home/domain/entities/home_view.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:hommie/features/home/infrastructure/providers/home_view_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_controller.g.dart';

sealed class HomeTab {
  const HomeTab();
}

final class HomeSummaryTab extends HomeTab {
  const HomeSummaryTab();
}

final class HomeAreaTab extends HomeTab {
  final String areaId;
  final String title;

  const HomeAreaTab({required this.areaId, required this.title});
}

class HomePageState {
  final bool isEditing;
  final bool isReordering;
  final HomeViewConf? homeView;
  final String serverName;
  final List<HomeTab> tabs;

  const HomePageState({
    this.isEditing = false,
    this.isReordering = false,
    this.homeView,
    this.serverName = '',
    this.tabs = const [HomeSummaryTab()],
  });

  HomePageState copyWith({
    bool? isEditing,
    bool? isReordering,
    HomeViewConf? homeView,
    String? serverName,
    List<HomeTab>? tabs,
  }) => HomePageState(
    isEditing: isEditing ?? this.isEditing,
    isReordering: isReordering ?? this.isReordering,
    homeView: homeView ?? this.homeView,
    serverName: serverName ?? this.serverName,
    tabs: tabs ?? this.tabs,
  );
}

@Riverpod(dependencies: [serverScopeServer, cachedAreas, homeViewRepository])
class HomePageController extends _$HomePageController {
  @override
  Future<HomePageState> build() async {
    final server = ref.watch(serverScopeServerProvider);
    final serverId = server.id!;

    // Keep tabs + home view in sync with cached areas.
    ref.listen<AsyncValue<List<Area>>>(cachedAreasProvider, (previous, next) {
      next.whenData((areas) {
        unawaited(_refreshFromAreas(areas));
      });
    });

    final repo = await ref.watch(homeViewRepositoryProvider.future);
    final homeView = await repo.get();

    // Build tabs from cached local areas so Home can render offline.
    final cachedAreas = await ref
        .watch(areaRepositoryProvider)
        .getByServer(serverId);
    final tabs = _tabsFromAreas(cachedAreas);

    return HomePageState(
      serverName: server.name,
      homeView: homeView,
      tabs: tabs,
    );
  }

  static List<HomeTab> _tabsFromAreas(List<Area> areas) {
    if (areas.isEmpty) {
      return const <HomeTab>[HomeSummaryTab()];
    }

    final sorted = [...areas]..sort((a, b) => a.name.compareTo(b.name));
    return [
      const HomeSummaryTab(),
      for (final area in sorted) HomeAreaTab(areaId: area.id, title: area.name),
    ];
  }

  Future<void> _refreshFromAreas(List<Area> areas) async {
    final current = state.asData?.value;
    if (current == null) {
      return;
    }

    // Refresh home view too so area names stay in sync.
    final repo = await ref.read(homeViewRepositoryProvider.future);
    final homeView = await repo.get();

    state = AsyncData(
      current.copyWith(tabs: _tabsFromAreas(areas), homeView: homeView),
    );
  }

  Future<void> toggleEditMode() async {
    final previousState = await future;
    state = AsyncData(
      previousState.copyWith(isEditing: !previousState.isEditing),
    );
  }

  Future<void> toggleReorderMode() async {
    final previousState = await future;
    state = AsyncData(
      previousState.copyWith(isReordering: !previousState.isReordering),
    );
  }
}
