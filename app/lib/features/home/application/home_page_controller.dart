import 'package:hommie/application/session/session_status_projections.dart';
import 'package:hommie/application/session/server_sync_coordinator.dart';
import 'package:hommie/application/session/server_sync_state.dart';
import 'package:hommie/core/domain/entities/area.dart';
import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/entities/application/cached_entities_provider.dart';
import 'package:hommie/features/home/application/cached_areas_provider.dart';
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
  final String serverName;
  final List<HomeTab> tabs;
  final List<AreaSection> sections; // all areas + trailing unassigned
  final bool isInitialSyncing;
  final bool isOffline;
  final Object? syncFailure;

  const HomePageState({
    this.isEditing = false,
    this.serverName = '',
    this.tabs = const [HomeSummaryTab()],
    this.sections = const [],
    this.isInitialSyncing = false,
    this.isOffline = false,
    this.syncFailure,
  });

  HomePageState copyWith({
    bool? isEditing,
    String? serverName,
    List<HomeTab>? tabs,
    List<AreaSection>? sections,
    bool? isInitialSyncing,
    bool? isOffline,
    Object? syncFailure,
  }) => HomePageState(
    isEditing: isEditing ?? this.isEditing,
    serverName: serverName ?? this.serverName,
    tabs: tabs ?? this.tabs,
    sections: sections ?? this.sections,
    isInitialSyncing: isInitialSyncing ?? this.isInitialSyncing,
    isOffline: isOffline ?? this.isOffline,
    syncFailure: syncFailure ?? this.syncFailure,
  );

  /// Sections for a specific area tab (area sections only, never unassigned).
  List<AreaSection> sectionsForArea(String areaId) =>
      sections.where((s) => s.areaId == areaId).toList();
}

@Riverpod(
  dependencies: [
    serverScopeServer,
    cachedAreas,
    cachedEntities,
    homeConnectionLoading,
    ServerSyncCoordinator,
  ],
)
class HomePageController extends _$HomePageController {
  bool _isEditing = false;

  @override
  HomePageState build() {
    final server = ref.watch(serverScopeServerProvider);
    final connectionLoading = ref.watch(homeConnectionLoadingProvider);
    final syncState = ref.watch(serverSyncCoordinatorProvider);
    final areas =
        ref.watch(cachedAreasProvider).asData?.value ?? const <Area>[];
    final entities =
        ref.watch(cachedEntitiesProvider).asData?.value ?? const [];

    final sections = groupEntitiesByArea(areas, entities);
    final isInitialSyncing =
        entities.isEmpty &&
        (syncState is InitialSyncRunning || connectionLoading);
    final isOffline = syncState is SyncOfflineWithCache;
    final syncFailure = syncState is SyncFailed ? syncState.error : null;

    return HomePageState(
      isEditing: _isEditing,
      serverName: server.name,
      tabs: _tabsFromAreas(areas),
      sections: sections,
      isInitialSyncing: isInitialSyncing,
      isOffline: isOffline,
      syncFailure: syncFailure,
    );
  }

  static List<HomeTab> _tabsFromAreas(List<Area> areas) {
    if (areas.isEmpty) {
      return const [HomeSummaryTab()];
    }
    final sorted = [...areas]..sort((a, b) => a.name.compareTo(b.name));
    return [
      const HomeSummaryTab(),
      for (final area in sorted) HomeAreaTab(areaId: area.id, title: area.name),
    ];
  }

  void toggleEditMode() {
    _isEditing = !_isEditing;
    state = state.copyWith(isEditing: _isEditing);
  }
}
