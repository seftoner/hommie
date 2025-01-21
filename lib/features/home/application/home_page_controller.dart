import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hommie/features/home/domain/entities/home_view.dart';
import 'package:hommie/features/home/infrastructure/providers/home_view_repository_provider.dart';

part 'home_page_controller.g.dart';

class HomePageState {
  final bool isEditing;
  final bool isReordering;
  final HomeViewConf? homeView;

  const HomePageState({
    this.isEditing = false,
    this.isReordering = false,
    this.homeView,
  });

  HomePageState copyWith({
    bool? isEditing,
    bool? isReordering,
    HomeViewConf? homeView,
  }) =>
      HomePageState(
        isEditing: isEditing ?? this.isEditing,
        isReordering: isReordering ?? this.isReordering,
        homeView: homeView ?? this.homeView,
      );
}

@riverpod
class HomePageController extends _$HomePageController {
  @override
  Future<HomePageState> build() async {
    final repo = await ref.watch(homeViewRepositoryProvider.future);
    // Assuming we're getting the first available HomeView for now
    final homeViews = await repo.getAll();
    final homeView = homeViews.isNotEmpty ? homeViews.first : null;

    return HomePageState(homeView: homeView);
  }

  Future<void> toggleEditMode() async {
    final previousState = await future;
    state =
        AsyncData(previousState.copyWith(isEditing: !previousState.isEditing));
  }

  Future<void> toggleReorderMode() async {
    final previousState = await future;
    state = AsyncData(
        previousState.copyWith(isReordering: !previousState.isReordering));
  }
}

class DeviceItem {
  final String id;
  final String name;
  final bool isBig;

  const DeviceItem({
    required this.id,
    required this.name,
    required this.isBig,
  });
}
