import 'dart:math';

import 'package:drag_arrange/drag_arrange.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Example')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(isList: true),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('List'),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(isList: false),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Grid'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final bool isList;
  const HomePage({super.key, required this.isList});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _dragEnabled = true;
  @override
  Widget build(BuildContext context) {
    final nonDraggable = DragGridCountItem(
      key: ValueKey(10.toString()),
      mainAxisCellCount: 1,
      crossAxisCellCount: Random().nextInt(2) + 1,
      widget: const Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Center(child: Text('Non Draggable')),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isList ? 'List Example' : 'Grid Example'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _dragEnabled = !_dragEnabled;
              });
            },
            icon: Icon(_dragEnabled ? Icons.pause : Icons.play_arrow),
          ),
        ],
      ),
      body: widget.isList
          ? DragListView(
              enableReordering: _dragEnabled,
              scrollViewOptions: const ScrollViewOptions(
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
              ),
              dragCallbacks: DragCallbacks(
                onDragEnd: (details, item) {
                  debugPrint('onDragEnd: $details ${item.key}');
                },
              ),
              axis: Axis.vertical,
              isLongPressDraggable: false,
              isNotDragList: [nonDraggable],
              children:
                  List.generate(
                    5,
                    (index) => DragListItem(
                      key: ValueKey(index.toString()),
                      widget: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Center(child: Text('Item $index')),
                        ),
                      ),
                    ),
                  )..addAll([
                    nonDraggable,
                    ...List.generate(
                      5,
                      (index) => DragListItem(
                        key: ValueKey('${index + 5}'),
                        widget: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Center(child: Text('Item ${index + 5}')),
                          ),
                        ),
                      ),
                    ),
                  ]),
            )
          : DragGridView(
              enableReordering: _dragEnabled,
              scrollViewOptions: const ScrollViewOptions(
                padding: EdgeInsets.all(16),
              ),

              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              dragCallbacks: DragCallbacks(
                onDragEnd: (details, item) {
                  if (kDebugMode) {
                    print('onDragEnd: $details ${item.key}');
                  }
                },
              ),

              crossAxisCount: 4,
              isLongPressDraggable: false,

              isNotDragList: [nonDraggable],
              children:
                  List.generate(
                    5,
                    (index) => DragGridCountItem(
                      key: ValueKey(index.toString()),
                      mainAxisCellCount: 1,
                      crossAxisCellCount: Random().nextInt(2) + 1,
                      widget: Card(child: Center(child: Text('Item $index'))),
                    ),
                  )..addAll([
                    nonDraggable,
                    ...List.generate(
                      5,
                      (index) => DragGridCountItem(
                        key: ValueKey('${index + 5}'),
                        mainAxisCellCount: 1,
                        crossAxisCellCount: Random().nextInt(2) + 1,
                        widget: Card(
                          child: Center(child: Text('Item ${index + 5}')),
                        ),
                      ),
                    ),
                  ]), // Provide the list of reorderable items
            ),
    );
  }
}
