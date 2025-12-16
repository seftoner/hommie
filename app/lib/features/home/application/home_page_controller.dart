import 'package:hommie/core/infrastructure/networking/connection/server_scope_provider.dart';
import 'package:hommie/features/areas/application/areas_for_home_provider.dart';
import 'package:hommie/features/home/domain/entities/home_view.dart';
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

@Riverpod(dependencies: [homeViewRepository, serverScopeServer, areasForHome])
class HomePageController extends _$HomePageController {
  @override
  Future<HomePageState> build() async {
    final server = ref.watch(serverScopeServerProvider);

    final repo = await ref.watch(homeViewRepositoryProvider.future);
    final homeView = await repo.get();

    var tabs = const <HomeTab>[HomeSummaryTab()];
    try {
      final areas = await ref.watch(areasForHomeProvider.future);
      if (areas.isNotEmpty) {
        tabs = [
          const HomeSummaryTab(),
          for (final area in areas)
            HomeAreaTab(areaId: area.id, title: area.name),
        ];
      }
    } catch (_) {
      // Keep current behaviour: if areas can't be fetched, hide tabs.
      tabs = const <HomeTab>[HomeSummaryTab()];
    }

    return HomePageState(
      serverName: server.name,
      homeView: homeView,
      tabs: tabs,
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

class DeviceItem {
  final String id;
  final String name;
  final bool isBig;

  const DeviceItem({required this.id, required this.name, required this.isBig});
}
