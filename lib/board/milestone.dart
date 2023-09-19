import 'package:flutter/material.dart';

import '../models/board.dart';
import '../models/blocks/milestone.dart';
import '../models/timestamped.dart';
import 'labeled_positioned.dart';

class Milestone extends StatefulWidget {
  final BoardContext context;
  final MilestoneData data;

  const Milestone(
    this.data, {
    super.key,
    required this.context,
  });

  @override
  State<Milestone> createState() => _MilestoneState();
}

class _MilestoneState extends State<Milestone> {
  @override
  Widget build(BuildContext context) {
    final deps = widget.context.board.getAllDependenciesOf(widget.data);

    return LabeledPositioned(
      widget.data,
      context: widget.context,
      debugLabel:
          'Reached: ${widget.data.isReached.value} | Deps: ${deps.length}',
      onTap: () {
        setState(() {
          widget.data.isReached.toggle();
          widget.context.save();
        });
      },
    );
  }
}
