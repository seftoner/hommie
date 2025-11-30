import 'package:flutter/material.dart';
import 'models.dart';

/// A class that holds all drag-related callbacks for the reorderable scroll view.
class DragCallbacks<T extends DragListItem> {
  /// Called when a draggable is dropped onto a [DragTarget].
  final void Function(T? moveData, T data, bool isFront,
      {AcceptDetails? acceptDetails})? onAccept;

  /// Called to determine whether this [DragTarget] is interested in receiving the dragged item.
  final bool Function(T? moveData, T data, bool isFront,
      {AcceptDetails? acceptDetails})? onWillAccept;

  /// Called when a draggable leaves the target.
  final void Function(T? moveData, T data, bool isFront)? onLeave;

  /// Called when a draggable moves within the target.
  final void Function(T data, DragTargetDetails<T> details, bool isFront)?
      onMove;

  /// Called when dragging starts.
  final void Function(T data)? onDragStarted;

  /// Called when the draggable is dragged.
  final void Function(DragUpdateDetails details, T data)? onDragUpdate;

  /// Called when the draggable is dropped without being accepted.
  final void Function(Velocity velocity, Offset offset, T data)?
      onDraggableCanceled;

  /// Called when the draggable is dropped.
  final void Function(DraggableDetails details, T data)? onDragEnd;

  /// Called when the draggable is accepted by a [DragTarget].
  final void Function(T data)? onDragCompleted;

  const DragCallbacks({
    this.onAccept,
    this.onWillAccept,
    this.onLeave,
    this.onMove,
    this.onDragStarted,
    this.onDragUpdate,
    this.onDraggableCanceled,
    this.onDragEnd,
    this.onDragCompleted,
  });
}
