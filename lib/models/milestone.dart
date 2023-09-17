import 'package:flutter/material.dart';

import '../board/milestone.dart';
import 'board.dart';
import 'connectable.dart';
import 'labeled.dart';
import 'timestamped.dart';

class MilestoneData extends LabeledData with HasInput {
  final Timestamped<bool> isReached = Timestamped(false);

  MilestoneData({required super.label, required super.position});

  @override
  Widget toWidget({
    required void Function() onDelete,
    required BoardContext context,
  }) =>
      Milestone(
        this,
        onDelete: onDelete,
        context: context,
      );
}
