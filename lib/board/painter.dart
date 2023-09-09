import 'package:flutter/material.dart';

import '../models/board.dart';
import '../models/board_object.dart';
import '../models/connectable.dart';

class BoardPainter extends CustomPainter {
  static const cyclePeriod = Duration(seconds: 10);
  static final _cycleInSeconds = cyclePeriod.inMilliseconds / 1000;

  static const double dashIntervalSeconds = 2;
  static const double directionDashLength = 50;
  static const double directionDashSpace = 30;

  static const double _directionDashInterval =
      directionDashLength + directionDashSpace;

  final BuildContext context;
  final double animationTime;
  final BoardData board;

  late final connectionPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Theme.of(context).colorScheme.primaryContainer
    ..strokeWidth = 6.0;

  late final directionPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Theme.of(context).colorScheme.primary
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 6.0;

  BoardPainter({
    required this.context,
    required this.animationTime,
    required this.board,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final obj in board.objects) {
      if (obj is HasOutput) {
        final ends = (obj as HasOutput).connections;

        for (final end in ends) {
          paintLineBetween(
            obj.position,
            (end as PositionedBoardObject).position,
            canvas,
          );
        }
      }
    }
  }

  void paintLineBetween(Offset a, Offset b, Canvas canvas) {
    final length = (b.dx - a.dx) / 2;

    final path = Path();
    path.moveTo(a.dx, a.dy);

    // Horizontal
    path.cubicTo(a.dx + length, a.dy, b.dx - length, b.dy, b.dx, b.dy);
    canvas.drawPath(path, connectionPaint);

    final metric = path.computeMetrics().first;

    const interval = _directionDashInterval;
    const dashLength = directionDashLength;

    final time = animationTime * _cycleInSeconds / dashIntervalSeconds;
    final offset = (time * interval) % interval;

    for (var t = -dashLength + offset; t < metric.length; t += interval) {
      final subPath = metric.extractPath(t, t + dashLength);
      canvas.drawPath(subPath, directionPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
