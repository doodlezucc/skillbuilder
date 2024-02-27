import 'package:flutter/material.dart';

import '../../io/serializable.dart';
import '../board.dart';
import '../connectable.dart';
import 'activity.dart';
import 'block_type.dart';
import 'milestone.dart';
import 'skill.dart';

abstract class BoardBlock with Connectable, Serializable {
  final DateTime creationTime;
  Offset position;

  BoardBlock({required this.position, DateTime? creationTime})
      : creationTime = creationTime ?? DateTime.now();

  BoardBlock.fromJson(Json json)
      : position = OffsetJson.from(json['position']),
        creationTime =
            DateTime.fromMillisecondsSinceEpoch(json['creationTime']);

  void register(BoardContext context) {}

  BlockType get type;

  Widget toWidget(BoardContext context);

  static BoardBlock parse(Json json) {
    final typeName = json['type'];
    final type =
        BlockType.values.firstWhere((blockType) => blockType.name == typeName);

    switch (type) {
      case BlockType.activity:
        return ActivityData.fromJson(json);
      case BlockType.milestone:
        return MilestoneData.fromJson(json);
      case BlockType.skill:
        return SkillData.fromJson(json);
    }
  }

  @override
  @mustCallSuper
  Json toJson() => {
        'type': type.name,
        'position': position.toJson(),
        'creationTime': creationTime.millisecondsSinceEpoch,
      };
}
