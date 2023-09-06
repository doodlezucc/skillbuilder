import 'package:flutter/material.dart';

abstract class BoardObject {
  Offset position;

  BoardObject({required this.position});

  Widget toWidget();
}
