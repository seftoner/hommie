import 'package:drag_arrange/drag_arrange.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:hommie/features/home/application/home_page_controller.dart';
import 'package:hommie/features/home/domain/entities/home_view.dart';
import 'package:hommie/router/routes.dart';
import 'package:hommie/ui/keys.dart';
import 'package:hommie/ui/styles/spacings.dart';
import 'package:hommie/ui/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([HomePageController])
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homePageControllerProvider);
    final fallbackTitle = homeState.asData?.value.serverName;

    return Scaffold(
      key: K.home.page,
      body: switch (homeState) {
        AsyncData(value: final state) => () {
          final showTabs = state.tabs.length > 1;

          if (!showTabs) {
            return CustomScrollView(
              slivers: [
                _buildSliverAppBar(context, ref, state, state.serverName),
                ..._buildHomeViewSlivers(state, state.homeView?.areas),
              ],
            );
          }

          return DefaultTabController(
            length: state.tabs.length,
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    ),
                    sliver: _buildSliverAppBar(
                      context,
                      ref,
                      state,
                      state.serverName,
                      bottom: TabBar(
                        isScrollable: true,
                        tabs: [
                          for (final tab in state.tabs)
                            switch (tab) {
                              HomeSummaryTab() => const Tab(text: 'Summary'),
                              HomeAreaTab(:final title) => Tab(text: title),
                            },
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  for (final tab in state.tabs)
                    switch (tab) {
                      HomeSummaryTab() => _HomeTabBody(
                        key: const PageStorageKey('home.summary'),
                        slivers: _buildHomeViewSlivers(
                          state,
                          state.homeView?.areas,
                        ),
                      ),
                      HomeAreaTab(:final areaId) => _HomeTabBody(
                        key: PageStorageKey('home.area.$areaId'),
                        slivers: _buildHomeViewSlivers(
                          state,
                          state.homeView?.areas
                              .where((a) => a.area.id == areaId)
                              .toList(growable: false),
                        ),
                      ),
                    },
                ],
              ),
            ),
          );
        }(),
        AsyncError(:final error) => Scaffold(
          appBar: AppBar(
            title: Text(fallbackTitle ?? 'Home'),
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
                    key: K.appScaffold.settingsButton,
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
            title: Text(fallbackTitle ?? 'Home'),
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
                    icon: const Icon(Symbols.more_vert_rounded),
                  );
                },
                menuChildren: [
                  MenuItemButton(
                    key: K.appScaffold.settingsButton,
                    trailingIcon: const Icon(Symbols.settings_rounded),
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

@Dependencies([HomePageController])
SliverAppBar _buildSliverAppBar(
  BuildContext context,
  WidgetRef ref,
  HomePageState state,
  String serverName, {
  PreferredSizeWidget? bottom,
}) {
  return SliverAppBar(
    title: Text(serverName),
    centerTitle: false,
    actions: [
      if (state.isEditing && state.homeView != null)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FilledButton(
            onPressed: () {
              ref.read(homePageControllerProvider.notifier).toggleEditMode();
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
              icon: const Icon(Symbols.more_vert_rounded),
            );
          },
          menuChildren: [
            MenuItemButton(
              key: K.appScaffold.settingsButton,
              trailingIcon: const Icon(Symbols.settings_rounded),
              child: const Text('Settings'),
              onPressed: () {
                const SettingsRouteData().push(context);
              },
            ),
            if (state.homeView != null) ...[
              MenuItemButton(
                trailingIcon: const Icon(Symbols.dashboard_rounded),
                child: const Text('Edit Home view'),
                onPressed: () {
                  ref
                      .read(homePageControllerProvider.notifier)
                      .toggleEditMode();
                },
              ),
              MenuItemButton(
                trailingIcon: const Icon(Symbols.low_priority_rounded),
                child: const Text('Reorder Items'),
                onPressed: () {},
              ),
            ],
          ],
        ),
    ],
    floating: true,
    pinned: true,
    bottom: bottom,
  );
}

List<Widget> _buildHomeViewSlivers(
  HomePageState state,
  List<AreaHomeConf>? areas,
) {
  if (state.homeView == null) {
    return const [
      SliverFillRemaining(
        child: Center(child: Text('No home view configured')),
      ),
    ];
  }

  final resolvedAreas = areas ?? const <AreaHomeConf>[];

  return [
    SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, areaIndex) {
          final areaConfig = resolvedAreas[areaIndex];
          final area = areaConfig.area;
          final devices = areaConfig.devices;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoomGroup(roomName: area.name, enabled: !state.isEditing),
              HomeDevicesGridView(state: state, devices: devices),
              $h24,
            ],
          );
        }, childCount: resolvedAreas.length),
      ),
    ),
  ];
}

class _HomeTabBody extends StatelessWidget {
  const _HomeTabBody({super.key, required this.slivers});

  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    final handle = NestedScrollView.sliverOverlapAbsorberHandleFor(context);

    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(handle: handle),
        ...slivers.where((s) => s is! SliverOverlapInjector),
      ],
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
        BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 3),
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
        Symbols.power_settings_new_rounded,
        size: 24,
        color: value ? context.colors.onSecondaryContainer : Colors.grey[600],
      ),
    );
  }
}

class DeviceWidget extends StatelessWidget {
  const DeviceWidget({super.key, required this.deviceConfig});

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
              const Icon(Symbols.lightbulb_rounded, size: 32.0),
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
                      style: context.fonts.labelLarge?.copyWith(
                        color: context.colors.onSurface,
                      ),
                    ),
                    Text(
                      'On',
                      style: context.fonts.labelSmall?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
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
            const Icon(Symbols.lightbulb_rounded, size: 32.0),
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
        side: BorderSide(color: context.colors.outlineVariant),
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
  const RoomGroup({super.key, required this.roomName, required this.enabled});

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
              style: context.fonts.titleMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            if (enabled)
              Icon(
                Symbols.chevron_right_rounded,
                color: context.colors.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }
}
