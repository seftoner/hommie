import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_controller.g.dart';

class HomePageState {
  final bool isEditing;
  final bool isReordering;
  final Map<String, List<DeviceItem>> rooms;

  const HomePageState({
    this.isEditing = false,
    this.isReordering = false,
    this.rooms = const {},
  });

  HomePageState copyWith({
    bool? isEditing,
    bool? isReordering,
    Map<String, List<DeviceItem>>? rooms,
  }) =>
      HomePageState(
        isEditing: isEditing ?? this.isEditing,
        isReordering: isReordering ?? this.isReordering,
        rooms: rooms ?? this.rooms,
      );
}

@riverpod
class HomePageController extends _$HomePageController {
  @override
  HomePageState build() {
    return const HomePageState(
      rooms: {
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
    );
  }

  void toggleEditMode() {
    state = state.copyWith(isEditing: !state.isEditing);
  }

  void toggleReorderMode() {
    state = state.copyWith(isReordering: !state.isReordering);
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
