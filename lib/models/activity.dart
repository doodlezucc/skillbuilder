import 'package:flutter/material.dart';

import '../board/activity.dart';
import 'board.dart';
import 'labeled.dart';

class ActivityData extends LabeledData {
  ActivityData({required super.label, required super.position});

  @override
  Widget toWidget({
    required void Function() onDelete,
    required BoardContext context,
  }) =>
      Activity(this, onDelete: onDelete);
}
