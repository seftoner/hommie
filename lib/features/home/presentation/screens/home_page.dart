import 'package:flutter/material.dart';
import 'package:hommie/features/areas/application/areas_controller.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hommie/ui/styles/spacings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reorderable_staggered_scroll_view/reorderable_staggered_scroll_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Mock data structure with size information
  final Map<String, List<DeviceItem>> roomsWithDevices = {
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
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: K.home.page,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('My home'),
              centerTitle: false,
              actions: [
                MenuAnchor(
                  builder: (context, controller, child) {
                    return IconButton(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      icon: const Icon(Icons.more_vert),
                    );
                  },
                  menuChildren: [
                    MenuItemButton(
                      trailingIcon: const Icon(Icons.settings_outlined),
                      child: const Text('Settings'),
                      onPressed: () {
                        const SettingsRouteData().push(context);
                      },
                    ),
                    MenuItemButton(
                      trailingIcon: const Icon(Icons.dashboard_rounded),
                      child: const Text('Edit Home view'),
                      onPressed: () {},
                    ),
                    MenuItemButton(
                      trailingIcon: const Icon(Icons.low_priority_rounded),
                      child: const Text('Reorder Items'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
              floating: true,
              pinned: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, roomIndex) {
                    final roomName = roomsWithDevices.keys.elementAt(roomIndex);
                    final devices = roomsWithDevices[roomName]!;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RoomGroup(roomName: roomName),
                          ReorderableStaggeredScrollView.grid(
                            crossAxisCount: 4,
                            isLongPressDraggable: false,
                            onDragEnd: (details, item) {
                              print('onDragEnd: $details ${item.key}');
                            },
                            children: [
                              for (final device in devices)
                                ReorderableStaggeredScrollViewGridCountItem(
                                  key: ValueKey(device.id),
                                  mainAxisCellCount: device.isBig ? 2 : 1,
                                  crossAxisCellCount: 2,
                                  widget: Card(
                                    child: Center(
                                        child: Text('Item ${device.name}')),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: roomsWithDevices.length,
                ),
              ),
            ),
          ],
        ));
  }
}

// New DeviceItem model
class DeviceItem {
  final String id;
  final String name;
  final bool isBig;

  DeviceItem({
    required this.id,
    required this.name,
    required this.isBig,
  });
}

class RoomGroup extends StatelessWidget {
  const RoomGroup({
    super.key,
    required this.roomName,
  });

  final String roomName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Navigate to $roomName');
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 0, 4),
        child: Row(
          children: [
            Text(
              roomName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
