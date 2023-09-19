import 'package:flutter/material.dart';

import '../models/blocks/board_block.dart';
import '../models/board.dart';
import 'draggable.dart';

class Block<T extends BoardBlock> extends StatefulWidget {
  final T data;
  final BoardContext context;
  final GestureTapCallback? onTap;
  final Widget child;

  const Block(
    this.data, {
    super.key,
    required this.context,
    required this.child,
    this.onTap,
  });

  @override
  State<Block> createState() => _BlockState();
}

class _BlockState extends State<Block> {
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
        if (!isDragging) {
          widget.context.save();
        }
      }),
      onLongPressStart: (_) {
        widget.context.board.removeBlock(widget.data);
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
