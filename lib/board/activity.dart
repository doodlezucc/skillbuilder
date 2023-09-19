import 'package:flutter/material.dart';

import '../models/blocks/activity.dart';
import '../models/board.dart';
import 'labeled_positioned.dart';

class Activity extends StatelessWidget {
  final ActivityData data;
  final BoardContext context;

  const Activity(this.data, {super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return LabeledPositioned(
      data,
      context: this.context,
    );
  }
}
