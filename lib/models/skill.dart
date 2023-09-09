import 'package:flutter/material.dart';

import '../board/skill.dart';
import 'board.dart';
import 'labeled.dart';

class SkillData extends LabeledData {
  SkillData({required super.label, required super.position});

  @override
  Widget toWidget({
    required void Function() onDelete,
    required BoardContext context,
  }) =>
      Skill(this, onDelete: onDelete);
}
