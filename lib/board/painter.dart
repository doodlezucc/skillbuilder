import 'package:flutter/material.dart';

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

  late final connectionPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Theme.of(context).colorScheme.primaryContainer
    ..strokeWidth = 6.0;

  late final directionPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Theme.of(context).colorScheme.primary
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 6.0;

  BoardPainter({required this.context, required this.animationTime});

  @override
  void paint(Canvas canvas, Size size) {
    paintLineBetween(const Offset(0, 0), const Offset(550, -50), canvas);
  }

  void paintLineBetween(Offset a, Offset b, Canvas canvas) {
    const length = 300;

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
