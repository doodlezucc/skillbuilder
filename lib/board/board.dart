import 'package:flutter/material.dart';

import 'animated_painter.dart';
import 'milestone.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  late TransformationController _ctrl;

  @override
  void initState() {
    _ctrl = TransformationController();
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(double.infinity),
      transformationController: _ctrl,
      minScale: 0.2,
      child: const Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPainter(),
            Milestone(
              label: 'w',
              offset: Offset(0, 0),
            ),
            Milestone(
              label: 'some other kind of milestone\nwith an extra line',
              offset: Offset(550, -50),
            ),
          ],
        ),
      ),
    );
  }
}
