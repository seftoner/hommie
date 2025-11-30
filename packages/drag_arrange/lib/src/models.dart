import 'package:flutter/widgets.dart';

/// Represents an item in a [ReorderableStaggeredScrollView].
class DragListItem {
  final Key key;
  final Widget widget;

  /// Creates a [DragListItem].
  ///
  /// The [key] is a required unique identifier for the item.
  /// The [widget] is the widget content of the item.
  const DragListItem({
    required this.key,
    required this.widget,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is DragListItem && key == other.key && widget == other.widget;
  }

  @override
  int get hashCode => key.hashCode ^ widget.hashCode;
}

/// Represents an item in a grid layout within a [ReorderableStaggeredScrollView].
abstract class DragGridItem extends DragListItem {
  /// Creates a [DragGridItem].
  ///
  /// The [key] is a required unique identifier for the item.
  /// The [mainAxisCellCount] specifies the number of cells along the main axis.
  /// The [crossAxisCellCount] specifies the number of cells along the cross axis.
  /// The [widget] is the widget content of the item.
  const DragGridItem({
    required super.key,
    required super.widget,
  });

  num get mainAxisSize;
  int get crossAxisSize;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DragGridItem &&
        key == other.key &&
        mainAxisSize == other.mainAxisSize &&
        crossAxisSize == other.crossAxisSize &&
        widget == other.widget;
  }

  @override
  int get hashCode =>
      super.hashCode ^ mainAxisSize.hashCode ^ crossAxisSize.hashCode;
}

/// Represents an item in a grid layout within a [ReorderableStaggeredScrollView].
class DragGridCountItem extends DragGridItem {
  final int mainAxisCellCount;
  final int crossAxisCellCount;

  /// Creates a [DragGridItem].
  ///
  /// The [key] is a required unique identifier for the item.
  /// The [mainAxisCellCount] specifies the number of cells along the main axis.
  /// The [crossAxisCellCount] specifies the number of cells along the cross axis.
  /// The [widget] is the widget content of the item.
  const DragGridCountItem({
    required super.key,
    required this.mainAxisCellCount,
    required this.crossAxisCellCount,
    required super.widget,
  });

  @override
  int get crossAxisSize => crossAxisCellCount;

  @override
  int get mainAxisSize => mainAxisCellCount;
}

/// Represents an item in a grid layout within a [ReorderableStaggeredScrollView].
class DragGridExtentItem extends DragGridItem {
  final double mainAxisExtent;
  final int crossAxisCellCount;

  /// Creates a [DragGridItem].
  ///
  /// The [key] is a required unique identifier for the item.
  /// The [mainAxisExtent] specifies the size extent along the main axis.
  /// The [crossAxisCellCount] specifies the number of cells along the cross axis.
  /// The [widget] is the widget content of the item.
  const DragGridExtentItem({
    required super.key,
    required this.mainAxisExtent,
    required this.crossAxisCellCount,
    required super.widget,
  });

  @override
  int get crossAxisSize => crossAxisCellCount;

  @override
  double get mainAxisSize => mainAxisExtent;
}

/// Contains information about where an element was dragged from and relocated to.
/// Is given by the conclusion of a drag event via the [OnWillAccept] or [OnAccept] handlers
///
/// - [oldIndex]: The previous index an item was located at
/// - [newIndex]: The new index an item was, or potentially will be, relocated to
class AcceptDetails {
  /// The previous index an item was located at
  final int oldIndex;

  /// The new index an item was relocated to
  final int newIndex;

  const AcceptDetails({required this.oldIndex, required this.newIndex});

  @override
  int get hashCode => 17 * (53 * oldIndex) ^ (29 * newIndex);

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is AcceptDetails &&
          (other.oldIndex == oldIndex && other.newIndex == newIndex));

  @override
  String toString() => '(oldIndex: $oldIndex, newIndex: $newIndex)';
}
