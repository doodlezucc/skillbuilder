import 'package:flutter/material.dart';

import '../io/serializable.dart';
import 'board.dart';
import 'connectable.dart';
import 'milestone.dart';

abstract class BoardBlock with Connectable, Serializable {
  Offset position;

  BoardBlock({required this.position});
  BoardBlock.fromJson(Json json) : position = OffsetJson.from(json['position']);

  static BoardBlock parse(Json json) {
    return MilestoneData.fromJson(json);
  }

  Widget toWidget({
    required void Function() onDelete,
    required BoardContext context,
  });

  @override
  @mustCallSuper
  Json toJson() => {
        'position': position.toJson(),
      };
}
