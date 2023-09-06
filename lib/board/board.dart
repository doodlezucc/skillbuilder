import 'package:flutter/material.dart';

import '../models/board.dart';
import 'animated_painter.dart';

class Board extends StatefulWidget {
  final BoardData data;

  const Board({super.key, required this.data});

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
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPainter(board: widget.data),
            ...widget.data.objects.map((obj) => obj.toWidget()),
          ],
        ),
      ),
    );
  }
}
