import 'package:drag_arrange/drag_arrange.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:hommie/features/home/application/home_page_controller.dart';
import 'package:hommie/features/home/domain/entities/home_view.dart';
import 'package:hommie/features/server_management/presentation/widgets/server_switching_demo.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hommie/ui/styles/spacings.dart';
import 'package:hommie/ui/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homePageControllerProvider);

    return Scaffold(
      key: K.home.page,
      body: switch (homeState) {
        AsyncData(value: final state) => CustomScrollView(
            slivers: [
              SliverAppBar(
                title: state.isEditing
                    ? const Text('Edit home view')
                    : const Text('My home'),
                centerTitle: false,
                actions: [
                  if (state.isEditing && state.homeView != null)
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
                        if (state.homeView != null) ...[
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
                      ],
                    ),
                ],
                floating: true,
                pinned: true,
              ),
              // Demo widget to show server switching functionality
              const SliverToBoxAdapter(
                child: ServerSwitchingDemo(),
              ),
              if (state.homeView == null)
                const SliverFillRemaining(
                  child: Center(
                    child: Text('No home view configured'),
                  ),
                )
              else
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
                            HomeDevicesGridView(state: state, devices: devices),
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
        AsyncError(:final error) => Scaffold(
            appBar: AppBar(
              title: const Text('My home'),
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
                  ],
                ),
              ],
            ),
            body: Center(child: Text(error.toString())),
          ),
        _ => Scaffold(
            appBar: AppBar(
              title: const Text('My home'),
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
                  ],
                ),
              ],
            ),
            body: const Center(child: CircularProgressIndicator()),
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
            widget: DeviceWidget(deviceConfig: deviceConfig),
          ),
      ],
    );
  }
}

class OnOffToggleButton extends StatelessWidget {
  const OnOffToggleButton({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onChanged(!value),
      style: IconButton.styleFrom(
        backgroundColor: value
            ? context.colors.secondaryContainer
            : context.colors.onSecondaryFixed,
        padding: EdgeInsets.zero,
        minimumSize: const Size(32, 32),
        maximumSize: const Size(32, 32),
        shape: const CircleBorder(),
      ),
      icon: Icon(
        Icons.power_settings_new_rounded,
        size: 24,
        color: value ? context.colors.onSecondaryContainer : Colors.grey[600],
      ),
    );
  }
}

class DeviceWidget extends StatelessWidget {
  const DeviceWidget({
    super.key,
    required this.deviceConfig,
  });

  final DeviceWidgetConf deviceConfig;

  Widget _buildSmall(BuildContext context) {
    context.fonts.labelSmall?.copyWith(color: context.colors.onSurfaceVariant);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lightbulb_circle,
                size: 32.0,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      deviceConfig.device.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: context.fonts.labelLarge
                          ?.copyWith(color: context.colors.onSurface),
                    ),
                    Text(
                      'On',
                      style: context.fonts.labelSmall
                          ?.copyWith(color: context.colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: OnOffToggleButton(
            value: true,
            onChanged: (value) {
              // Handle toggle state change
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBig(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.lightbulb_circle,
              size: 32.0,
            ),
            OnOffToggleButton(
              value: true,
              onChanged: (value) {
                // Handle toggle state change
              },
            ),
          ],
        ),
        const Spacer(),
        Text(
          deviceConfig.device.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: context.fonts.titleMedium,
        ),
        const SizedBox(height: 4),
        const Text('On'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      elevation: 0,
      color: context.colors.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: context.colors.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: switch (deviceConfig.size) {
          DeviceDisplaySize.big => _buildBig(context),
          DeviceDisplaySize.small => _buildSmall(context),
        },
      ),
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
              style: context.fonts.titleMedium
                  ?.copyWith(color: context.colors.onSurfaceVariant),
            ),
            const Spacer(),
            if (enabled)
              Icon(
                Icons.chevron_right,
                color: context.colors.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }
}
