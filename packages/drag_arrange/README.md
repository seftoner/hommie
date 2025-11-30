# drag_arrange

A Flutter package for creating draggable and reorderable grid and list views with extensive customization options. This package provides a smooth and intuitive way to reorder items in both grid and list layouts, perfect for creating interactive user interfaces.

|                                       List Demo                                        |                                       Grid Demo                                        |
| :------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------------: |
| ![List](https://raw.githubusercontent.com/itisnajim/drag_arrange/main/readme/list.gif) | ![Grid](https://raw.githubusercontent.com/itisnajim/drag_arrange/main/readme/grid.gif) |

## Features

* Supports both list and grid layouts with drag-and-drop functionality
* Three main widget types: DragListView, DragGridView with count, and DragGridView with extent
* Customizable drag animations and behaviors
* Built-in shake animations
* Configurable scroll physics and view options

## Getting Started

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  drag_arrange: ^latest_version
```

Import the package:

```dart
import 'lib/drag_arrange.dart';
```

## Usage

### List View

```dart
DragListView(
  enableReordering: true,
  axis: Axis.vertical,
  scrollViewOptions: const ScrollViewOptions(
    shrinkWrap: true,
    padding: EdgeInsets.all(16),
    physics: BouncingScrollPhysics(),
  ),
  children: items.map((item) => 
    DragListItem(
      key: ValueKey(item.id),
      widget: YourItemWidget(),
    ),
  ).toList(),
);
```

### Grid View with Count

```dart
DragGridView(
  enableReordering: true,
  enableShakeAnimation: true,
  scrollViewOptions: const ScrollViewOptions(
    padding: EdgeInsets.all(16),
  ),
  crossAxisCount: 4,
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  children: items.map((item) =>
    DragGridCountItem(
      key: ValueKey(item.id),
      mainAxisCellCount: 1,
      crossAxisCellCount: 2,
      widget: YourGridItemWidget(),
    ),
  ).toList(),
);
```

### Grid View with Extent

```dart
DragGridView(
  enableReordering: true,
  mainAxisSpacing: 5,
  crossAxisSpacing: 5,
  scrollViewOptions: const ScrollViewOptions(
    padding: EdgeInsets.all(16),
  ),
  crossAxisCount: 4,
  children: items.map((item) =>
    DragGridExtentItem(
      key: ValueKey(item.id),
      mainAxisExtent: 150,
      crossAxisCellCount: 2,
      widget: YourGridItemWidget(),
    ),
  ).toList(),
);
```

### Custom

You can integrate the `ReorderableStaggeredScrollView` package with your custom list or grid widget by wrapping your custom list or grid widget with the necessary components.

```dart
DragNotification(
  child: ListView(
    scrollDirection: Axis.vertical,
    children: [
      DragContainer(
        scrollDirection: Axis.vertical,
        isLongPressDraggable: true,
        buildItems: (List<Widget> children) {
          return YourCustomListViewWidget(
            // Your custom list or grid widget configuration
            children: children,
          );
        },
        dataList: yourList, // Your List of DragListItem or DragGridItem
        items: (DragListItem element, DraggableWidget draggableWidget) {
          // Map each item in your dataList into a draggable widget
          return Container(
            key: ValueKey(element.key.toString()),
            child: draggableWidget(element.widget),
          );
        }
      ),
    ],
  ),
);
```
Replace the comments with your actual widget configuration and data. This setup will allow you to use the ReorderableStaggeredScrollView package with your custom widget.

## Credits

This package is built on top of [flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view) and is a fork of the original work by [itisnajim](https://github.com/itisnajim).

## Authors

Current Maintainer:
- [seftoner](https://github.com/seftoner)

Original Author:
- [itisnajim](https://github.com/itisnajim) (itisnajim@gmail.com)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
