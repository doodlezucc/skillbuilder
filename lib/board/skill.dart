import 'package:flutter/material.dart';

import '../models/blocks/skill.dart';
import 'labeled_positioned.dart';

class Skill extends StatelessWidget {
  final SkillData data;
  final void Function() onDelete;

  const Skill(this.data, {super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return LabeledPositioned(
      data,
      onDelete: onDelete,
    );
  }
}
