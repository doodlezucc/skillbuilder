import 'package:flutter/material.dart';

import '../models/milestone.dart';
import 'labeled_positioned.dart';

class Milestone extends StatelessWidget {
  final MilestoneData data;
  final void Function() onDelete;

  const Milestone(this.data, {super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return LabeledPositioned(data, onDelete: onDelete);
  }
}
