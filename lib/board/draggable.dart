import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BoardDraggable extends StatefulWidget {
  final Offset position;
  final void Function(Offset position) onDrag;
  final void Function(bool isDragging) onDragStateChange;
  final Widget child;

  const BoardDraggable({
    super.key,
    required this.position,
    required this.onDrag,
    required this.child,
    required this.onDragStateChange,
  });

  @override
  State<BoardDraggable> createState() => _BoardDraggableState();
}

class _BoardDraggableState extends State<BoardDraggable> {
  bool dragged = false;
  late Offset _startPointerPosition;
  late Offset _startBoardPosition;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      transformHitTests: true,
      offset: widget.position,
      child: GestureDetector(
        dragStartBehavior: DragStartBehavior.down,
        onPanDown: (details) {
          widget.onDragStateChange(true);
          _startPointerPosition = details.localPosition;
          _startBoardPosition = widget.position;
        },
        onPanUpdate: (details) {
          widget.onDrag(_startBoardPosition +
              (details.localPosition - _startPointerPosition));
        },
        onPanEnd: (details) => widget.onDragStateChange(false),
        onPanCancel: () => widget.onDragStateChange(false),
        child: widget.child,
      ),
    );
  }
}
