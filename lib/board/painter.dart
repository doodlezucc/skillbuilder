import 'package:flutter/material.dart';

class BoardPainter extends CustomPainter {
  final connectionPaint = Paint()
    ..color = Colors.grey[800]!
    ..strokeWidth = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      Offset(0, 0),
      Offset(550, -50),
      connectionPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
