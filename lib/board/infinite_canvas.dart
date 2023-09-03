import 'package:flutter/material.dart';

class InfiniteCanvas extends StatefulWidget {
  final List<Widget> children;

  const InfiniteCanvas({super.key, required this.children});

  @override
  State<InfiniteCanvas> createState() => _InfiniteCanvasState();
}

class _InfiniteCanvasState extends State<InfiniteCanvas> {
  Offset _offset = Offset.zero;
  double _zoom = 1.0;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _offset,
      child: Transform.scale(
        scale: _zoom,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: widget.children,
          ),
        ),
      ),
    );
  }
}
