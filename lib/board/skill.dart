import 'package:flutter/material.dart';

import '../models/blocks/skill.dart';
import '../models/board.dart';
import 'labeled_positioned.dart';

class Skill extends StatelessWidget {
  final SkillData data;
  final BoardContext context;

  const Skill(this.data, {super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return LabeledPositioned(
      data,
      context: this.context,
    );
  }
}
