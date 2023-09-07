import 'package:flutter/material.dart';

import '../models/milestone.dart';
import 'draggable.dart';

class Milestone extends StatefulWidget {
  final MilestoneData data;

  const Milestone(this.data, {super.key});

  @override
  State<Milestone> createState() => _MilestoneState();
}

class _MilestoneState extends State<Milestone> {
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
          child: Text(
            widget.data.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
