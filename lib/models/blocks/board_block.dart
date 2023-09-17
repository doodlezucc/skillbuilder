import 'package:flutter/material.dart';

import '../../io/serializable.dart';
import '../board.dart';
import '../connectable.dart';
import 'block_type.dart';
import 'milestone.dart';

abstract class BoardBlock with Connectable, Serializable {
  Offset position;

  BoardBlock({required this.position});
  BoardBlock.fromJson(Json json) : position = OffsetJson.from(json['position']);

  static BoardBlock parse(Json json) {
    return MilestoneData.fromJson(json);
  }

  BlockType get type;

  Widget toWidget({
    required void Function() onDelete,
    required BoardContext context,
  });

  @override
  @mustCallSuper
  Json toJson() => {
        'type': type.name,
        'position': position.toJson(),
      };
}
