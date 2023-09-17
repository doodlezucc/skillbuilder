import 'package:flutter/material.dart';

import '../board/activity.dart';
import '../io/serializable.dart';
import 'board.dart';
import 'connectable.dart';
import 'labeled.dart';

class ActivityData extends LabeledData with HasInput {
  ActivityData({required super.label, required super.position});
  ActivityData.fromJson(Json json) : super.fromJson(json);

  @override
  Widget toWidget({
    required void Function() onDelete,
    required BoardContext context,
  }) =>
      Activity(this, onDelete: onDelete);
}
