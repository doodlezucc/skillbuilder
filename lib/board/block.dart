import 'package:flutter/material.dart';

import '../block_page.dart';
import '../models/blocks/board_block.dart';
import '../models/blocks/labeled.dart';
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
  late Offset positionBeforeDragging;
  bool dragged = false;

  void onDragStateChange(bool isDragging) {
    setState(() {
      dragged = isDragging;
    });

    if (isDragging) {
      positionBeforeDragging = widget.data.position;
    } else {
      onDragEnd();
    }
  }

  void onDragEnd() {
    Offset draggedOffset = widget.data.position - positionBeforeDragging;

    if (draggedOffset != Offset.zero) {
      widget.context.save();
    }
  }

  void onLongPress() async {
    // final action = widget.context.board.composeRemoveBlock(widget.data);
    // widget.context.history.push(action);
    // widget.context.save();

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlockPage(block: widget.data as LabeledData),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BoardDraggable(
      position: widget.data.position,
      onDrag: (position) => setState(() {
        widget.data.position = position;
      }),
      onDragStateChange: onDragStateChange,
      onLongPressStart: (_) => onLongPress(),
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
