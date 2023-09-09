import 'package:flutter/material.dart';

import '../models/board_object.dart';
import 'draggable.dart';

class PositionedObject<T extends PositionedBoardObject> extends StatefulWidget {
  final T data;
  final void Function() onDelete;
  final GestureTapCallback? onTap;
  final Widget child;

  const PositionedObject(
    this.data, {
    super.key,
    required this.onDelete,
    required this.child,
    this.onTap,
  });

  @override
  State<PositionedObject> createState() => _PositionedObjectState();
}

class _PositionedObjectState extends State<PositionedObject> {
  bool dragged = false;

  @override
  Widget build(BuildContext context) {
    return BoardDraggable(
      position: widget.data.position,
      onDrag: (position) => setState(() {
        widget.data.position = position;
      }),
      onDragStateChange: (isDragging) => setState(() {
        dragged = isDragging;
      }),
      onLongPressStart: (_) {
        widget.onDelete();
      },
      onTap: widget.onTap,
      child: UnconstrainedBox(
        child: Container(
          decoration: BoxDecoration(
            color: dragged
                ? Theme.of(context).primaryColor
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(16),
          ),
          constraints: const BoxConstraints(
            minWidth: 100,
            minHeight: 60,
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
