import 'package:flutter/material.dart';

import '../board/milestone.dart';
import 'labeled.dart';

class MilestoneData extends LabeledData {
  MilestoneData({required super.label, required super.position});

  @override
  Widget toWidget({required void Function() onDelete}) =>
      Milestone(this, onDelete: onDelete);
}
