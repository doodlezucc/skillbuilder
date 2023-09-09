import 'package:flutter/material.dart';

import '../models/milestone.dart';
import '../models/timestamped.dart';
import 'labeled_positioned.dart';

class Milestone extends StatefulWidget {
  final MilestoneData data;
  final void Function() onDelete;

  const Milestone(this.data, {super.key, required this.onDelete});

  @override
  State<Milestone> createState() => _MilestoneState();
}

class _MilestoneState extends State<Milestone> {
  @override
  Widget build(BuildContext context) {
    return LabeledPositioned(
      widget.data,
      onDelete: widget.onDelete,
      debugLabel: 'Reached: ${widget.data.isReached.value}',
      onTap: () {
        setState(() {
          widget.data.isReached.toggle();
        });
      },
    );
  }
}
