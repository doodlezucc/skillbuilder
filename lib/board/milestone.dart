import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../models/milestone.dart';

class Milestone extends StatefulWidget {
  final MilestoneData data;

  const Milestone(this.data, {super.key});

  @override
  State<Milestone> createState() => _MilestoneState();
}

class _MilestoneState extends State<Milestone> {
  bool dragged = false;
  late Offset _startPointerPosition;
  late Offset _startMilestonePosition;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      transformHitTests: true,
      offset: widget.data.position,
      child: UnconstrainedBox(
        child: GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onPanDown: (details) {
            setState(() {
              dragged = true;
              _startPointerPosition = details.localPosition;
              _startMilestonePosition = widget.data.position;
            });
          },
          onPanUpdate: (details) {
            setState(() {
              widget.data.position = _startMilestonePosition +
                  (details.localPosition - _startPointerPosition);
            });
          },
          onPanEnd: (details) {
            setState(() {
              dragged = false;
            });
          },
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
      ),
    );
  }
}
