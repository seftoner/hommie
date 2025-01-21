import 'package:drag_arrange/drag_arrange.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:hommie/features/home/application/home_page_controller.dart';
import 'package:hommie/features/home/domain/entities/home_view.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hommie/ui/styles/spacings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homePageControllerProvider);

    return Scaffold(
      key: K.home.page,
      body: switch (homeState) {
        AsyncData(value: final state) => state.homeView == null
            ? const Center(child: Text('No home view configured'))
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: state.isEditing
                        ? const Text('Edit home view')
                        : const Text('My home'),
                    centerTitle: false,
                    actions: [
                      if (state.isEditing)
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
                              trailingIcon:
                                  const Icon(Icons.low_priority_rounded),
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
                        (context, areaIndex) {
                          final areaConfig = state.homeView!.areas[areaIndex];
                          final area = areaConfig.area;
                          final devices = areaConfig.devices;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RoomGroup(
                                roomName: area.name,
                                enabled: !state.isEditing,
                              ),
                              HomeDevicesGridView(
                                  state: state, devices: devices),
                              $h24,
                            ],
                          );
                        },
                        childCount: state.homeView?.areas.length ?? 0,
                      ),
                    ),
                  ),
                ],
              ),
        AsyncError(:final error) => Text(error.toString()),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}

class HomeDevicesGridView extends StatelessWidget {
  const HomeDevicesGridView({
    super.key,
    required this.state,
    required this.devices,
  });

  final HomePageState state;
  final List<DeviceWidgetConf> devices;

  int _getMainAxisCellCount(DeviceDisplaySize size) {
    return size == DeviceDisplaySize.big ? 2 : 1;
  }

  @override
  Widget build(BuildContext context) {
    final dragItemDecoration = BoxDecoration(
      color: Colors.transparent,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.02),
          blurRadius: 3,
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 10,
          spreadRadius: 4,
          offset: const Offset(0, 4),
        ),
      ],
    );

    final canBeDraggedOnLongPress = switch (defaultTargetPlatform) {
      TargetPlatform.iOS || TargetPlatform.android => true,
      _ => false,
    };

    return DragGridView(
      enableReordering: state.isEditing,
      enableShakeAnimation: true,
      isLongPressDraggable: canBeDraggedOnLongPress,
      crossAxisCount: 4,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      dragChildBoxDecoration: dragItemDecoration,
      children: [
        for (final deviceConfig in devices)
          DragGridCountItem(
            key: ValueKey(deviceConfig.device.id),
            mainAxisCellCount: _getMainAxisCellCount(deviceConfig.size),
            crossAxisCellCount: 2,
            widget: Card(
              child: Center(
                child: Text(deviceConfig.device.name),
              ),
            ),
          ),
      ],
    );
  }
}

class RoomGroup extends StatelessWidget {
  const RoomGroup({
    super.key,
    required this.roomName,
    required this.enabled,
  });

  final String roomName;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? () {} : null,
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
            if (enabled)
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
