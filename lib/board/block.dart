import 'package:flutter/material.dart';

import '../block_page.dart';
import '../models/blocks/board_block.dart';
import '../models/blocks/labeled.dart';
import '../models/board.dart';
import 'draggable.dart';

abstract class Block<T extends BoardBlock> extends StatefulWidget {
  final T data;
  final BoardContext context;
  final GestureTapCallback? onTap;

  const Block(
    this.data, {
    super.key,
    required this.context,
    this.onTap,
  });

  @override
  State<Block> createState() => _BlockState();

  Widget buildChild(BuildContext context);
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

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlockPage(block: widget.data as LabeledData),
      ),
    );

    setState(() {
      widget.context.save();
    });
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
          child: widget.buildChild(context),
        ),
      ),
    );
  }
}
