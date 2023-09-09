import 'package:flutter/material.dart';

import '../board/skill.dart';
import 'labeled.dart';

class SkillData extends LabeledData {
  SkillData({required super.label, required super.position});

  @override
  Widget toWidget({required void Function() onDelete}) =>
      Skill(this, onDelete: onDelete);
}
