import 'dart:math';

import 'package:example/models/models.dart';
import 'package:flutter/material.dart';
import 'package:drag_arrange/drag_arrange.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool _dragEnabled = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('drag_arrange example'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _dragEnabled = !_dragEnabled;
              });
            },
            icon: Icon(
              _dragEnabled ? Icons.stop_circle : Icons.move_down_rounded,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'List'),
            Tab(text: 'Grid count'),
            Tab(text: 'Grid extent'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListTab(
            dragEnabled: _dragEnabled,
          ),
          GridCountTab(
            dragEnabled: _dragEnabled,
          ),
          GridExtentTab(
            dragEnabled: _dragEnabled,
          ),
        ],
      ),
    );
  }
}

class ListTab extends StatefulWidget {
  final bool dragEnabled;
  const ListTab({super.key, required this.dragEnabled});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  List<DeviceWidget> devices = List.generate(
      25,
      (index) => DeviceWidget(
            name: "Device ${index + 1}",
            id: "device$index",
          ));

  @override
  Widget build(BuildContext context) {
    return DragListView(
      enableReordering: widget.dragEnabled,
      axis: Axis.vertical,
      scrollViewOptions: const ScrollViewOptions(
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
      ),
      children: devices
          .map((device) => DragListItem(
                key: ValueKey(device.id),
                widget: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Center(child: Text(device.name)),
                      ],
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class GridCountTab extends StatefulWidget {
  final bool _dragEnabled;
  const GridCountTab({super.key, required bool dragEnabled})
      : _dragEnabled = dragEnabled;

  bool get dragEnabled => _dragEnabled;

  @override
  State<GridCountTab> createState() => _GridCountTabState();
}

class _GridCountTabState extends State<GridCountTab> {
  List<DeviceWidget> devices = [
    DeviceWidget(name: "Living Room TV", id: "tv1", size: DeviceSize.wide),
    DeviceWidget(name: "Kitchen Light", id: "light1", size: DeviceSize.small),
    DeviceWidget(name: "Bedroom AC", id: "ac1", size: DeviceSize.square),
    DeviceWidget(name: "Door Lock", id: "lock1", size: DeviceSize.small),
    DeviceWidget(
        name: "Garden Sprinkler", id: "sprinkler1", size: DeviceSize.square),
    DeviceWidget(name: "Garage Door", id: "garage1", size: DeviceSize.wide),
    DeviceWidget(
        name: "Security Camera", id: "camera1", size: DeviceSize.square),
    DeviceWidget(name: "Window Blinds", id: "blinds1", size: DeviceSize.small),
  ];

  void _toggleDeviceSize(String id) {
    final index = devices.indexWhere((d) => d.id == id);
    if (index != -1) {
      setState(() {
        final device = devices[index];
        // Cycle through sizes: small -> square -> wide -> small
        DeviceSize newSize = switch (device.size!) {
          DeviceSize.small => DeviceSize.square,
          DeviceSize.square => DeviceSize.wide,
          DeviceSize.wide => DeviceSize.small,
        };
        devices[index] = DeviceWidget(
          name: device.name,
          id: device.id,
          size: newSize,
        );
      });
    }
  }

  void _removeDevice(String id) {
    setState(() {
      devices.removeWhere((device) => device.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DragGridView(
      enableReordering: widget.dragEnabled,
      enableShakeAnimation: true,
      scrollViewOptions: const ScrollViewOptions(
        padding: EdgeInsets.all(16),
      ),
      crossAxisCount: 4,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      isLongPressDraggable: false,
      dragCallbacks: DragCallbacks(
        onAccept: (item1, item2, isFront, {acceptDetails}) {
          if (acceptDetails != null) {
            // _reorderDevices(acceptDetails.oldIndex, acceptDetails.newIndex);
          }
        },
      ),
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
      children: devices
          .map((device) => DragGridCountItem(
                key: ValueKey(device.id),
                mainAxisCellCount: switch (device.size!) {
                  DeviceSize.small => 1,
                  DeviceSize.square => 2,
                  DeviceSize.wide => 1,
                },
                crossAxisCellCount: switch (device.size!) {
                  DeviceSize.small => 2,
                  DeviceSize.square => 2,
                  DeviceSize.wide => 4,
                },
                widget: Card(
                  elevation: 2,
                  child: Stack(
                    children: [
                      Center(child: Text(device.name)),
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                switch (device.size!) {
                                  DeviceSize.small => Icons.expand,
                                  DeviceSize.square => Icons.width_wide,
                                  DeviceSize.wide => Icons.compress,
                                },
                                size: 20,
                              ),
                              onPressed: () => _toggleDeviceSize(device.id),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, size: 20),
                              onPressed: () => _removeDevice(device.id),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class GridExtentTab extends StatefulWidget {
  final bool dragEnabled;
  const GridExtentTab({super.key, required this.dragEnabled});

  @override
  State<GridExtentTab> createState() => _GridExtentTabState();
}

class _GridExtentTabState extends State<GridExtentTab> {
  List<DeviceWidget> devices = List.generate(
      20,
      (index) => DeviceWidget(
            name: "Device ${index + 1}",
            id: "device$index",
/*             size: [
              DeviceSize.small,
              DeviceSize.square,
              DeviceSize.wide
            ][index % 3], */
          ));

  @override
  Widget build(BuildContext context) {
    return DragGridView(
      enableReordering: widget.dragEnabled,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      scrollViewOptions: const ScrollViewOptions(
        padding: EdgeInsets.all(16),
      ),
      crossAxisCount: 4,
      children: devices
          .map((device) => DragGridExtentItem(
                key: ValueKey(device.id),
                mainAxisExtent: Random().nextInt(200) + 100,
                crossAxisCellCount: Random().nextInt(2) + 1,
                widget: Card(
                  elevation: 2,
                  child: Stack(
                    children: [
                      Center(child: Text(device.name)),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
