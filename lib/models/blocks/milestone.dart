import 'package:flutter/material.dart';

import '../../board/milestone.dart';
import '../../io/serializable.dart';
import '../board.dart';
import '../connectable.dart';
import 'block_type.dart';
import 'labeled.dart';
import '../timestamped.dart';

class MilestoneData extends LabeledData with HasInput {
  final Timestamped<bool> isReached;

  MilestoneData({required super.label, required super.position})
      : isReached = Timestamped(false);

  MilestoneData.fromJson(Json json)
      : isReached = Timestamped.fromJson(json['isReached']),
        super.fromJson(json);

  @override
  BlockType get type => BlockType.milestone;

  @override
  Widget toWidget(BoardContext context) => Milestone(this, context: context);

  @override
  Json toJson() => {
        ...super.toJson(),
        'isReached': isReached,
      };
}
