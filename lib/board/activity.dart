import 'package:flutter/material.dart';

import '../models/blocks/activity.dart';
import 'labeled_positioned.dart';

class Activity extends StatelessWidget {
  final ActivityData data;
  final void Function() onDelete;

  const Activity(this.data, {super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return LabeledPositioned(data, onDelete: onDelete);
  }
}
