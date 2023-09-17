import 'package:flutter/material.dart';

import '../io/serializable.dart';
import 'board.dart';
import 'connectable.dart';
import 'milestone.dart';

abstract class PositionedBoardObject with Connectable, Serializable {
  Offset position;

  PositionedBoardObject({required this.position});
  PositionedBoardObject.fromJson(Json json)
      : position = OffsetJson.from(json['position']);

  static PositionedBoardObject parse(Json json) {
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
