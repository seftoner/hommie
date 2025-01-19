import 'package:drag_arrange/drag_arrange.dart';
import 'package:flutter/material.dart';
import 'package:hommie/features/home/application/home_page_controller.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homePageControllerProvider);

    return Scaffold(
        key: K.home.page,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: homeState.isEditing
                  ? const Text('Edit home view')
                  : const Text('My home'),
              centerTitle: false,
              actions: [
                if (homeState.isEditing)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: FilledButton(
                      onPressed: () {
                        ref
                            .read(homePageControllerProvider.notifier)
                            .toggleEditMode();
                      },
                      child: const Text('Done'),
                    ),
                  )
                else
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
                        onPressed: () {
                          ref
                              .read(homePageControllerProvider.notifier)
                              .toggleEditMode();
                        },
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
                    final roomName = homeState.rooms.keys.elementAt(roomIndex);
                    final devices = homeState.rooms[roomName]!;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RoomGroup(roomName: roomName),
                          DragGridView(
                            enableReordering: homeState.isEditing,
                            enableShakeAnimation: homeState.isEditing,
                            isLongPressDraggable: homeState.isEditing,
                            crossAxisCount: 4,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            dragChildBoxDecoration: BoxDecoration(
                              color: Colors.transparent,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.25),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            children: [
                              for (final device in devices)
                                DragGridCountItem(
                                  key: UniqueKey(),
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
                  childCount: homeState.rooms.length,
                ),
              ),
            ),
          ],
        ));
  }
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
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
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
