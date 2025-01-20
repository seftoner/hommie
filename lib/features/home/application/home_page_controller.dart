import 'package:hommie/features/home/domain/entities/area.dart';
import 'package:hommie/features/home/infrastructure/providers/area_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_controller.g.dart';

class HomePageState {
  final bool isEditing;
  final bool isReordering;
  final List<Area> areas;

  const HomePageState(
      {this.isEditing = false,
      this.isReordering = false,
      this.areas = const []});

  HomePageState copyWith({
    bool? isEditing,
    bool? isReordering,
    List<Area>? areas,
  }) =>
      HomePageState(
        isEditing: isEditing ?? this.isEditing,
        isReordering: isReordering ?? this.isReordering,
        areas: areas ?? this.areas,
      );
}

@riverpod
class HomePageController extends _$HomePageController {
  @override
  Future<HomePageState> build() async {
    /*  return const HomePageState(
      areas: {
        'Living Room': [
          DeviceItem(id: '1', name: 'Light', isBig: true),
          DeviceItem(id: '2', name: 'TV', isBig: false),
          DeviceItem(id: '3', name: 'AC', isBig: false),
        ],
        'Kitchen': [
          DeviceItem(id: '4', name: 'Fridge', isBig: true),
          DeviceItem(id: '5', name: 'Microwave', isBig: false),
        ],
        'Bedroom': [
          DeviceItem(id: '6', name: 'Light', isBig: false),
          DeviceItem(id: '7', name: 'Fan', isBig: false),
          DeviceItem(id: '8', name: 'AC', isBig: true),
        ],
        'Bathroom': [
          DeviceItem(id: '9', name: 'Light', isBig: false),
          DeviceItem(id: '10', name: 'Heater', isBig: true),
        ],
        'Office': [
          DeviceItem(id: '11', name: 'Computer', isBig: true),
          DeviceItem(id: '12', name: 'Printer', isBig: false),
          DeviceItem(id: '13', name: 'Desk Lamp', isBig: false),
        ],
      },
    ); */

    final repo = await ref.watch(areaRepositoryProvider.future);
    final homeAreas = await repo.getAll();

    return Future.value(HomePageState(areas: homeAreas));
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
