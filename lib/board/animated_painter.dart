import 'package:flutter/material.dart';

import '../models/board.dart';
import 'painter.dart';

class AnimatedPainter extends StatefulWidget {
  final BoardData board;

  const AnimatedPainter({super.key, required this.board});

  @override
  State<AnimatedPainter> createState() => _AnimatedPainterState();
}

class _AnimatedPainterState extends State<AnimatedPainter>
    with TickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this);
    _ctrl.repeat(
      period: BoardPainter.cyclePeriod,
    );
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) => CustomPaint(
        painter: BoardPainter(
          context: context,
          animationTime: _ctrl.value,
          board: widget.board,
        ),
      ),
    );
  }
}
