import 'package:flutter/material.dart';

import 'board.dart';
import 'connectable.dart';

abstract class PositionedBoardObject with Connectable {
  Offset position;

  PositionedBoardObject({required this.position});

  Widget toWidget({
    required void Function() onDelete,
    required BoardContext context,
  });
}
