import 'package:flutter/material.dart';

abstract class PositionedBoardObject {
  Offset position;

  PositionedBoardObject({required this.position});

  Widget toWidget({required void Function() onDelete});
}
