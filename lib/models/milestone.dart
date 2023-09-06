import 'package:flutter/material.dart';

import '../board/milestone.dart';
import 'board_object.dart';
import 'connectable.dart';

class MilestoneData extends BoardObject with HasInput, HasOutput {
  String label;

  MilestoneData({required this.label, required super.position});

  @override
  Widget toWidget() => Milestone(label: label, offset: position);
}
