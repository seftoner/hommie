import 'package:drag_arrange/drag_arrange.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'count tile spans two columns and extent tile keeps 80 px height',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 320,
              child: DragGridView(
                crossAxisCount: 2,
                children: [
                  DragGridCountItem(
                    key: ValueKey('wide-item'),
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    widget: ColoredBox(
                      key: ValueKey('wide'),
                      color: Colors.red,
                      child: SizedBox.expand(),
                    ),
                  ),
                  DragGridExtentItem(
                    key: ValueKey('short-item'),
                    crossAxisCellCount: 1,
                    mainAxisExtent: 80,
                    widget: ColoredBox(
                      key: ValueKey('short'),
                      color: Colors.blue,
                      child: SizedBox.expand(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(
        tester.getSize(find.byKey(const ValueKey('wide'))),
        const Size(320, 160),
      );
      expect(
        tester.getSize(find.byKey(const ValueKey('short'))),
        const Size(160, 80),
      );
    },
  );

  testWidgets('RTL places the first one-cell tile on the right', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: SizedBox(
              width: 320,
              child: DragGridView(
                crossAxisCount: 2,
                children: [
                  DragGridCountItem(
                    key: ValueKey('first-item'),
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    widget: ColoredBox(
                      key: ValueKey('first'),
                      color: Colors.red,
                      child: SizedBox.expand(),
                    ),
                  ),
                  DragGridCountItem(
                    key: ValueKey('second-item'),
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    widget: ColoredBox(
                      key: ValueKey('second'),
                      color: Colors.blue,
                      child: SizedBox.expand(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    expect(
      tester.getTopLeft(find.byKey(const ValueKey('first'))).dx,
      greaterThan(tester.getTopLeft(find.byKey(const ValueKey('second'))).dx),
    );
  });

  testWidgets('dragging a tile over another updates their order', (
    tester,
  ) async {
    final events = <String>[];
    final items = <DragGridCountItem>[
      const DragGridCountItem(
        key: ValueKey('first-item'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        widget: ColoredBox(
          key: ValueKey('first'),
          color: Colors.red,
          child: SizedBox.expand(),
        ),
      ),
      const DragGridCountItem(
        key: ValueKey('second-item'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        widget: ColoredBox(
          key: ValueKey('second'),
          color: Colors.blue,
          child: SizedBox.expand(),
        ),
      ),
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 320,
            child: DragGridView(
              crossAxisCount: 2,
              isLongPressDraggable: false,
              enableReordering: true,
              dragCallbacks: DragCallbacks(
                onDragStarted: (_) => events.add('started'),
                onDragEnd: (_, _) => events.add('ended'),
              ),
              children: items,
            ),
          ),
        ),
      ),
    );

    final target = tester.getCenter(find.byKey(const ValueKey('second')));
    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(const ValueKey('first'))),
    );
    await gesture.moveBy(const Offset(18, 0));
    await tester.pump();
    await gesture.moveTo(target);
    await tester.pump(const Duration(milliseconds: 250));
    await gesture.up();
    await tester.pump();

    expect(items.map((item) => item.key), [
      const ValueKey('second-item'),
      const ValueKey('first-item'),
    ], reason: events.toString());
  });
}
