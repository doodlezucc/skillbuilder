import 'package:flutter/material.dart';

import '../../board/skill.dart';
import '../../io/serializable.dart';
import '../board.dart';
import '../connectable.dart';
import 'block_type.dart';
import 'labeled.dart';

class SkillData extends LabeledData with HasInput {
  SkillData({required super.label, required super.position});
  SkillData.fromJson(Json json) : super.fromJson(json);

  @override
  BlockType get type => BlockType.skill;

  @override
  Widget toWidget({
    required void Function() onDelete,
    required BoardContext context,
  }) =>
      Skill(this, onDelete: onDelete);
}
