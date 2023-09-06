import 'package:flutter/material.dart';

import 'milestone.dart';
import 'painter.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  final _ctrl = TransformationController();

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(double.infinity),
      transformationController: _ctrl,
      minScale: 0.2,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: BoardPainter(),
            ),
            Milestone(
              label: 'w',
              offset: Offset(0, 0),
            ),
            Milestone(
              label: '10x cooking oder so\nepic',
              offset: Offset(550, -50),
            ),
          ],
        ),
      ),
    );
  }
}
